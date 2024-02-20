import 'package:intl/intl.dart';

class FormatDecimal {
  static String format(double value) {
    return NumberFormat.decimalPattern().format(value).toString().replaceAll(',', '.');
  }
}
