import "package:disk_space_2/disk_space_2.dart";
import "package:path_provider/path_provider.dart";

import "../../../../../core/config/storage_config.dart";
import "device_storage_validator.dart";

/// Device storage validator helper for business logic processes
class DeviceStorageValidatorImpl implements DeviceStorageValidator {
  /// Device storage validator helper for business logic processes
  const DeviceStorageValidatorImpl({
    required this.config,
  });
  
  /// Storage configuration parameter
  final StorageConfig config;

  @override
  Future<bool> hasEnoughSpace(int requiredBytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final freeDeviceSpaceMiB =
        await DiskSpace.getFreeDiskSpaceForPath(dir.path);

    // 1 MB is approximately 0.9537 MiB, DiskSpace returns MiB, so we transform here
    final freeDeviceSpaceMB = (freeDeviceSpaceMiB ?? 0) / 0.9537;

    // Convert required bytes to MB
    final requiredMB = requiredBytes / (1024 * 1024);

    final neededMB = config.minFreeSpaceMB + requiredMB + config.safetyMarginMB;

    return freeDeviceSpaceMB >= neededMB;
  }
}
