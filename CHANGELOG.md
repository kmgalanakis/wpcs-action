# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.1] - 2021-06-29
### Added
- Detect local phpcs config. This is disabled by default. Enable it by setting `use_local_config` to 'true'.
- `phpcs_bin_path` option to use local PHPCS.

### Removed
- `is_vipcs` option. From this version, `wpcs-action` checks against VIPCS automatically if the `standard` option set to `WordPress-VIP-Go` or `WordPressVIPMinimum`.

## [1.3.0] - 2021-06-29
### Added
- Support WordPress Coding Standard exclusively.
- Support Custom Standards.
- Support VIPCS. Enable VIPCS check by using `is_vipcs` options.

### Removed
- `phpcs_bin_path` and `installed_paths` options.
