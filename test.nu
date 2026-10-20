# Run test suite for an image
export def main [
    image: string               # the image name (must equal the directory name)
    branches: list<string>      # the branches to test
] {
    let multiple = $branches | length | $in > 1
    $branches | par-each -k { test $image }
}

# Execute test suite for a particular branch (piped in)
def test [
    image_name: string          # the image name
]: string -> record<branch: string, result: string> {
    # assemble variables
    let branch = $in
    let image_version: string = echo $"../($image_name)/VERSION" | open --raw | str trim
    let image_tag = $"($image_name)-test-($branch)"

    # build test image
    echo $"Building ($image_name) ($branch)..." | print

    let build_args = [
        "buildx"
        "build"
        "--load"
        "--quiet"
        "--build-arg" $"BF_IMAGE=($image_name)"
        "--build-arg" $"BF_VERSION=($image_version)"
        "--file" $"../($image_name)/($branch)/Dockerfile"
        "--tag" $image_tag
        "."
    ]
    let build_result = do { ^docker ...$build_args } | complete
    if $build_result.exit_code != 0 {
        return {
            branch: $branch
            result: $build_result.stderr
        }
    }

    # execute tests
    print $"Executing tests for ($image_name) ($branch)..."

    let test_args = [
        "run"
        "--quiet"
        "--entrypoint" "/test"
        $image_tag
    ]
    let test_result = do { ^docker ...$test_args } | complete

    # return result
    let ok = $"(ansi green)✔(ansi reset)"
    return {
        branch: $branch
        result: (if $test_result.exit_code == 0 { $ok } else { $test_result.stderr })
    }
}