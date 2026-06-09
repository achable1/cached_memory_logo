# Changelog

## (Breaking change) 0.2.2

### Changed

* `CachedMemoryPackage.init` now changes all his parameters into an global class `PackageInitParams`, and to named parameters all of them
* Two extra parameters in the init part (minFreeSpaceMB & safetyMarginMB); docs within the params class (previously was a hidden values, but now are exposed)
* And for consideration about the usage of hive AND this package:

yaml```
types:
  LogoTable:
    typeId: 0
    nextIndex: 5
    fields:
      path:
        index: 0
      saved:
        index: 3
      fileName:
        index: 4
```

This rule is given for id's, consider using different typeId's and indexes
Recommended using 20 or more in `index` and `typeId` 10 or more

## 0.2.1

### Changed

* Renamed Hive box used for logo storage.
* Internal storage improvements and cleanup.

## 0.2.0

### Added

* Hive cleanup support for cached logos.
* Storage validation flow.
* `GetOrRefreshLogo` use case for automatic cache refresh.
* Disk space validation using `disk_space_2`.

### Changed

* Cached logo storage migrated to byte-based persistence.
* Improved file path handling and logging.
* Refactored logo persistence layer.
* Example application improvements.

### Fixed

* Null-safe logo saving.
* Various linter and test structure issues.

## 0.1.9

### Added

* File-backed logo storage implementation.
* `LogoTable` entity for local persistence.
* Configurable cache tolerance through dependency injection.

### Changed

* Refactored logo storage architecture.
* Improved mock flow integration and testing structure.
* Updated AutoRoute dependencies.

## 0.1.8

### Changed

* Logo save date now stored as ISO string.
* Improved cache expiration tolerance handling.

## 0.1.7

### Fixed

* Remote data source request issues.
* Stability improvements for remote logo retrieval.

## 0.1.6

### Changed

* `CachedMemoryPackage` now accepts a custom Dio instance.
* Improved HTTP client configurability.

## 0.1.5

### Changed

* Dependency injection refactored to use Dio.
* Migrated to real remote data source implementation.

## 0.1.4

### Added

* Logging support across package operations.

### Changed

* Dependency injection improvements.
* Example application cleanup and refactoring.

## 0.1.3

### Added

* Detailed logging for logo retrieval and caching flow.

## 0.1.2

### Added

* Access token support for logo requests.

## 0.1.1

### Changed

* Updated package dependencies.

## 0.1.0

### Added

* Initial public package release.
* Remote logo fetching support.
* Local logo caching using Hive.
* Dependency injection setup.
* Example Flutter application.
* Clean architecture project structure.
* Error handling and cache management utilities.
