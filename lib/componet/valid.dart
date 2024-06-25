import 'package:eol/constant/message.dart';

validinput(String value, int min, int max) {
  if (value.length > max) {
    return "$messageiinputMax  $max";
  }
  if (value.isEmpty) {
    return "$messageiinputEmpty";
  }
  if (value.length < min) {
    return "$messageiinputMin  $min";
  }
}
