import "dart:io";

import "package:disk_space_2/disk_space_2.dart";
import "package:get_it/get_it.dart";

import "device_storage_validator.dart";

/// Device storage validator helper for business logic processes
class DeviceStorageValidatorImpl implements DeviceStorageValidator {
  /// Device storage validator helper for business logic processes
  const DeviceStorageValidatorImpl({
    this.minFreeSpaceMB = 50,
    this.safetyMarginMB = 500,
  });
  
  /// Minimum free space in MB required (default 50 MB)
  final double minFreeSpaceMB;

  /// Safety margin in MB to account for system usage (default 500 MB)
  final double safetyMarginMB;


  @override
  Future<bool> hasEnoughSpace(int requiredBytes) async {
    final dir = GetIt.I<Directory>();
    final freeDeviceSpaceMiB =
        await DiskSpace.getFreeDiskSpaceForPath(dir.path);

    // 1 MB is approximately 0.9537 MiB, DiskSpace returns MiB, so we transform here
    final freeDeviceSpaceMB = (freeDeviceSpaceMiB ?? 0) / 0.9537;

    // Convert required bytes to MB
    final requiredMB = requiredBytes / (1024 * 1024);

    final neededMB = minFreeSpaceMB + requiredMB + safetyMarginMB;

    return freeDeviceSpaceMB >= neededMB;
  }
}
