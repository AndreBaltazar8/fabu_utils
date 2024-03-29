import 'package:fabu_utils/dynamic_extension.dart';

/// Extensions that apply to nullable strings.
///
/// Contains common functionality used against nullable strings.
extension NullableStringExtension on String? {
  /// Whether this string is null or empty.
  bool get isNullOrEmpty => let((it) => it == null || it.isEmpty);

  /// Whether this string is null or whitespace.
  bool get isNullOrWhitespace => let((it) => it == null || it.trim().isEmpty);
}
