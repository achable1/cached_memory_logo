// ignore_for_file: one_member_abstracts

/// Device storage validator helper for business logic proceses
abstract class DeviceStorageValidator {
  /// Method that exposes a bool flag if the device has enough space
  Future<bool> hasEnoughSpace(int requiredBytes);
}
