# Changelog

All notable changes to this project will be documented in this file.

## Unreleased
- Added support for additional authentication methods.

## [1.0.1] - 2025-01-01
### Added
- Implemented a new feature: UniqueKey generation with truncation in `_helpers.tpl`.
- Removed the option to create a namespace within the Helm chart; namespaces must now be created beforehand.
- Introduced support for `persistentVolumeReclaimPolicy` for MySQL's data directory.
- Added a test command in the NOTES file to verify database connectivity.
- Included a new `testQuery` function in `_helpers.tpl` to execute a query displaying initial data in the database.

### Changed
- Updated `values.yaml` to eliminate the unnecessary `create: true` entry when the namespace template is absent.
- Refined PV naming logic to be derived from the database section for better consistency.
- Appended `-pv` and `-pvc` postfixes to `persistentVolume` and `persistentVolumeClaim` names, respectively.

### Fixed
- Resolved a bug causing invalid Docker image reference formatting.

## [1.0.0] - 2024-12-25
### Added
- Initial release of the Helm chart for deploying the e-commerce application.
- Introduced basic API functionality with product management endpoints.
- Added support for MySQL database deployment and configuration.
- Namespace creation controlled via Helm values.

---

The format of this file follows the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) principles.
