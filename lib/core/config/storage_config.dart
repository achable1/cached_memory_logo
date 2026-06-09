/// Configuration values for storage-related safeguards (needed to be implemented
/// in all client apps)
class StorageConfig {
  /// Configuration values for storage-related safeguards (needed to be implemented
  /// in all client apps)
  const StorageConfig({
    this.minFreeSpaceMB = 50,
    this.safetyMarginMB = 500,
  });

  /// Minimum free space in MB required before saving a file (default: 50 MB)
  final double minFreeSpaceMB;

  /// Safety margin in MB to account for system and concurrent usage (default: 500 MB)
  final double safetyMarginMB;
}
