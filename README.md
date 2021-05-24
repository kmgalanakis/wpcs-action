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
          uses: dinhtungdu/wpcs-action@master
```

Available options:

```yaml
        ...
        - name: WPCS check
          uses: dinhtungdu/wpcs-action@master
          with:
            enable_warnings: true # Enable checking for warnings (-w)
            standard: 'WordPress' # Standard to use, default to WordPress
            paths: '.' # Paths to check, space separated, default to project root directory
```
