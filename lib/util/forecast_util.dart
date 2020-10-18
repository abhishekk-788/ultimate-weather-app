import 'package:intl/intl.dart';

class Util {
  static String appId = "329e10ef310fbd824f92a09c7535fef4";
  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEE, MMM d, y").format(dateTime);
  }
}