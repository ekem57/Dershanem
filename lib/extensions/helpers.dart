import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatTheDate(DateTime selectedDate, {DateFormat format}) {
  final DateTime now = selectedDate;
  final DateFormat formatter = format ?? DateFormat('dd.MM.y', "tr_TR");
  final String formatted = formatter.format(now);
  initializeDateFormatting("tr_TR");
  return formatted;
}
