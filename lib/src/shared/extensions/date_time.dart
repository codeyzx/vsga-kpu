import 'package:intl/intl.dart';

extension XDateTime on DateTime {
  String get toYyyyMMDd => DateFormat('dd MMMM y').format(this);
}
