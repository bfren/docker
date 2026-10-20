# Run test suite for an image
export def main [
    image: string               # the image name (must equal the directory name)
    branches: list<string>      # the branches to test
] {
    let multiple = $branches | length | $in > 1
    $branches | par-each -k { test $image --multiple=($multiple) }
}

# Execute test suite for a particular branch (piped in)
def test [
    image_name: string          # the image name
    --multiple                  # whether or not we are testing multiple versions
]: string -> any {
    let branch = $in
    echo $"Executing tests for ($image_name) ($branch)..." | print

    let args = [
        $"../($image_name)/test.sh"
        $branch
    ]
    let result = do { ^sh ...$args } | complete

    if ($result.exit_code == 0) {
        return (match $multiple {
            true => {branch: $branch, result: "OK"},
            false => {$result.stdout}
        })
    }

    $result | print
    error make {msg: $"One or more tests for ($image_name) ($branch) failed."}
}