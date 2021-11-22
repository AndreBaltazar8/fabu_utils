import 'package:fabu_utils/dynamic_extension.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() => let((it) => it == null || it.isEmpty);
  bool isNullOrWhitespace() => let((it) => it == null || it.trim().isEmpty);
}
