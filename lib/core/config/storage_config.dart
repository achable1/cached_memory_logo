/// Configuration values for storage-related safeguards
class StorageConfig {
  /// Default tolerance date used when no saved date is present
  const StorageConfig({
    this.minFreeSpaceMB = 50,
    this.safetyMarginMB = 500,
  });

  /// Minimum free space in MB required before saving a file (default: 50 MB)
  final double minFreeSpaceMB;

  /// Safety margin in MB to account for system and concurrent usage (default: 500 MB)
  final double safetyMarginMB;
}
