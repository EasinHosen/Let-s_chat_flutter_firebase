import 'package:intl/intl.dart';

String getFormatedDate(DateTime dt, {String format = 'dd/MM/yyyy HH:mm'} ) =>
  DateFormat(format).format(dt);