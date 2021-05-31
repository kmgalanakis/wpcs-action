#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

echo "CS repository: ${INPUT_STANDARD_REPO}"

if [[ "${INPUT_STANDARD_REPO}" == *"Automattic/VIP-Coding-Standards"* ]]; then
    echo "Installing VIPCS"
    git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git ~/wpcs
    git clone -b ${INPUT_REPO_BRANCH} ${INPUT_STANDARD_REPO} ~/vipcs
    phpcs --config-set installed_paths ~/wpcs,~/vipcs
else
    git clone -b ${INPUT_REPO_BRANCH} ${INPUT_STANDARD_REPO} ~/wpcs
    phpcs --config-set installed_paths ~/wpcs
fi

phpcs -i

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    phpcs -n --report=checkstyle --standard=${INPUT_STANDARD} --extensions=php ${INPUT_PATHS}
else
    echo "Check for warnings enabled"

    phpcs --report=checkstyle --standard=${INPUT_STANDARD} --extensions=php ${INPUT_PATHS}
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
