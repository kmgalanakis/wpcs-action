# WPCS GitHub Action

This action will help you to run phpcs (PHP_CodeSniffer) against [WordPress Coding Standards](https://github.com/WordPress/WordPress-Coding-Standards) with [GitHub Actions](https://github.com/features/actions) platform.

To make it as simple as possible, this action supports WordPress Coding Standards exclusively and only checks for PHP files. This action doesn't require any change or addition to your source code. It means that you don't need to add composer/phpcs to your plugin or create PHP CodeSniffer config to use this action.

This is a fork of [chekalsky/phpcs-action](https://github.com/chekalsky/phpcs-action), so this action supports GitHub Action Antonation too. All credit goes to 
[Ilya Chekalsky](https://github.com/chekalsky).

## Usage

Add the following code to `.github/workflows/wpcs.yml` file.

```yaml
name: WPCS check

on: pull_request

jobs:
  phpcs:
      name: WPCS
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - name: WPCS check
          uses: 10up/wpcs-action@master
```

Available options (with default value):

```yaml
        ...
        - name: WPCS check
          uses: 10up/wpcs-action@master
          with:
            enable_warnings: false # Enable checking for warnings (-w)
            paths: '.' # Paths to check, space separated
            excludes: '' # Paths to excludes, space separated
            standard: 'WordPress' # Standard to use
            is_vipcs: 'false' # Check against VIPCS. This override custom standard repo settings.
            standard_repo: '' # Public (git) repository URL of the coding standard
            repo_branch: 'master' # Branch of Standard repository
```

## Examples

### VIP Coding Standards

```yaml
name: WPCS check

on: pull_request

jobs:
  phpcs:
      name: VIPCS
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - name: VIPCS check
          uses: 10up/wpcs-action@master
          with:
            standard: 'WordPress-VIP-Go'
            is_vipcs: 'true'
```
