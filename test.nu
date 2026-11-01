# Run test suite for an image
export def main [
    image: string                       # the image name (must equal the directory name)
    branches: list<string> = [""]       # the branches to test - "" for an image with one Dockerfile in its root
    --prefix: string = ""               # prefix for each branch's directory, e.g. "php" for php8.5
    --build-flags: list<string> = []    # additional flags for docker buildx build
    --smoke                             # after the tests pass, run ./smoke.sh with the test image
] {
    let results = $branches | par-each -k { test $image $prefix $build_flags $smoke }

    # summary table, then the names of any failed tests underneath
    $results
        | reject failed
        | print
    let failed = $results | where ($it.failed | is-not-empty)
    for r in $failed {
        print $"(char newline)(ansi rb)Failed tests for ($image) ($r.branch | str trim):(ansi reset)"
        for t in $r.failed { print $"  ($t)" }
    }

    # exit with an error if any branch did not pass, so scripts can tell a failure from a pass
    if ($results | any {|r| not ($r.result | str contains "✔") }) { exit 1 }
}

# Execute test suite for a particular branch (piped in)
def test [
    image_name: string                  # the image name
    prefix: string                      # prefix for the branch's directory
    build_flags: list<string>           # additional flags for docker buildx build
    smoke: bool                         # whether or not to run ./smoke.sh after the tests
]: string -> record<branch: string, result: string, failed: list<string>> {
    # assemble variables - each branch needs its own tag as they are built in parallel
    let branch = $in
    let image_version: string = echo $"../($image_name)/VERSION"
        | open --raw
        | str trim
    let dockerfile = if $branch == "" { "Dockerfile" } else { $"($prefix)($branch)/Dockerfile" }
    let image_tag = if $branch == "" { $"($image_name)-test" } else { $"($image_name)-test-($branch)" }
    let name = $"($image_name) ($branch)" | str trim

    # build test image
    echo $"Building ($name)..." | print

    let build_args = [
        "buildx"
        "build"
        "--load"
        "--quiet"
        ...$build_flags
        "--build-arg" $"BF_IMAGE=($image_name)"
        "--build-arg" $"BF_VERSION=($image_version)"
        "--file" $"../($image_name)/($dockerfile)"
        "--tag" $image_tag
        "."
    ]
    let build_result = do { ^docker ...$build_args } | complete
    if $build_result.exit_code != 0 {
        return {
            branch: $branch
            result: $build_result.stderr
            failed: []
        }
    }

    # execute tests
    print $"Executing tests for ($name)..."

    let test_args = [
        "run"
        "--rm"
        "--quiet"
        "--entrypoint" "/test"
        $image_tag
    ]
    let test_result = do { ^docker ...$test_args } | complete
    if $test_result.exit_code != 0 {
        # the test runner prints "FAILED <test>" to stdout for each failure, and "x of y tests failed." to stderr
        let failed = $test_result.stdout
            | ansi strip
            | lines
            | where ($it | str starts-with "FAILED ")
            | str replace "FAILED " ""
        let summary = $test_result.stderr
            | ansi strip
            | lines
            | str trim
            | where ($it =~ 'tests failed\.$')
            | str replace -r '^x\s+' ""
        return {
            branch: $branch
            result: (if ($summary | is-empty) { $test_result.stderr } else { $"(ansi red)✘(ansi reset) ($summary | first)" })
            failed: $failed
        }
    }

    # execute smoke test
    if $smoke {
        print $"Executing smoke test for ($name)..."

        let smoke_args = [
            $"../($image_name)/smoke.sh"
            $image_tag
        ]
        let smoke_result = do { ^sh ...$smoke_args } | complete
        if $smoke_result.exit_code != 0 {
            return {
                branch: $branch
                result: $"($smoke_result.stdout)($smoke_result.stderr)"
                failed: []
            }
        }
    }

    # return result
    let ok = $"(ansi green)✔(ansi reset)"
    return {
        branch: $branch
        result: $ok
        failed: []
    }
}
