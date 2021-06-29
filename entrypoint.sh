#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git ~/wpcs

if [ "${INPUT_IS_VIPCS}" = "true" ]; then
    echo "Setting up VIPCS"
    git clone https://github.com/Automattic/VIP-Coding-Standards ${HOME}/vipcs
    git clone https://github.com/sirbrillig/phpcs-variable-analysis ${HOME}/variable-analysis
    ${INPUT_PHPCS_BIN_PATH} --config-set installed_paths "${HOME}/wpcs,${HOME}/vipcs,${HOME}/variable-analysis"
elif [ -z "${INPUT_STANDARD_REPO}" ] || [ "${INPUT_STANDARD_REPO}" = "false" ]; then
    ${INPUT_PHPCS_BIN_PATH} --config-set installed_paths ~/wpcs
else
    echo "Standard repository: ${INPUT_STANDARD_REPO}"
    git clone -b ${INPUT_REPO_BRANCH} ${INPUT_STANDARD_REPO} ${HOME}/cs
    ${INPUT_PHPCS_BIN_PATH} --config-set installed_paths "${HOME}/wpcs,${HOME}/cs"
fi

if [ -z "${INPUT_EXCLUDES}" ]; then
    EXCLUDES="node_modules,vendor"
else
    EXCLUDES="node_modules,vendor,${INPUT_EXCLUDES}"
fi

phpcs -i

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} -n --report=checkstyle --standard=${INPUT_STANDARD} --extensions=php --ignore=${EXCLUDES} ${INPUT_PATHS}
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} --report=checkstyle --standard=${INPUT_STANDARD} --ignore=${EXCLUDES} --extensions=php ${INPUT_PATHS}
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
