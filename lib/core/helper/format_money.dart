import 'package:intl/intl.dart';

class Helper {
  String formattNumber(int number) {
    return NumberFormat.simpleCurrency(name: 'NGN').format(number);
  }
}
