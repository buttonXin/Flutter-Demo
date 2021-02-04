import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomTimePicker extends CommonPickerModel {
  bool showSecondsColumn;

  CustomTimePicker(
      {DateTime currentTime, LocaleType locale, this.showSecondsColumn: true})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  // @override
  // // TODO: implement leftList
  // List<String> get leftList => List.generate(78-52, (int index) {
  //   // print('LEFT LIST... ${minTime.year + index}${_localeYear()}');
  //   return '${52 + index}';
  // });
  // @override
  // void set leftList(List<String> _leftList) {
  //   // TODO: implement leftList
  //   super.leftList = leftList;
  // }
  @override
  String leftStringAtIndex(int index) {
    // print('lao_gao-->CustomTimePicker_leftStringAtIndex_${index}');
    if (index >= 0 && index < 79) {
      return digits(index, 2);
    } else {
      return null;
    }
    // if (index >= 52 && index < 79) {
    //   return digits(index, 2);
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return ":";
  }

  @override
  String rightDivider() {
    return "";
  }

  @override
  List<int> layoutProportions() {
    return [1, 0, 0];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
        this.currentLeftIndex(), this.currentMiddleIndex(), this.currentRightIndex())
        : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
        this.currentMiddleIndex(), this.currentRightIndex());
  }
}
