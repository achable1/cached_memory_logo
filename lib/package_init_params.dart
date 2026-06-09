import "package:dio/dio.dart";

/// Cached memory logo package inicialization parameters
class PackageInitParams {
  /// Cached memory logo package inicialization parameters
  PackageInitParams({
    required this.dio,
    this.minFreeSpaceMB = 50,
    this.safetyMarginMB = 500,
    this.isMock = false,
    this.toleranceRange,
  });

  /// Dio adapter to handle network part
  final Dio dio;

  /// This duration represents the difference between the saved DateTime and 
  /// the time that you want to fetch again remote logo data, this automatically 
  /// sets for 30 days, but, for testing or development flows, you can set into 
  /// less time
  final Duration? toleranceRange;

  /// Mock flag to enable dev environment
  final bool? isMock;

  /// Minimum free space in MB required before saving a file (default: 50 MB)
  final double? minFreeSpaceMB;

  /// Safety margin in MB to account for system and concurrent usage (default: 500 MB)
  final double? safetyMarginMB;
}
