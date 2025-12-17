/// Returns a short summary of a base64 string: length and head/tail.
String base64Summary(String b) {
  final head = b.length > 20 ? b.substring(0, 20) : b;
  final tail = b.length > 20 ? b.substring(b.length - 20) : "";
  return "len=${b.length}, head=$head, tail=$tail";
}

/// Normalizes base64 by removing whitespace/newlines.
String normalizeBase64(String s) => s.replaceAll(RegExp(r"\s+"), "");
