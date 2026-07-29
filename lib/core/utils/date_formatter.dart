import 'package:intl/intl.dart';

extension DateFormatting on String {
  String formatApiDate() {
    try {
      final date = DateTime.parse(this);
      return DateFormat('MMMM d, yyyy').format(date);
    } catch (_) {
      return this;
    }
  }
}
