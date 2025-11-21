import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime? initialDisplayDate;
  final Function(DateTime)? onDateSingleSubmit;
  final Function(DateTime, DateTime)? onDateRangeSubmit;
  final bool Function(DateTime)? selectableDayPredicate;
  final DateRangePickerSelectionMode selectionMode;
  const AppDatePicker({
    super.key,
    this.initialDate,
    this.onDateRangeSubmit,
    this.onDateSingleSubmit,
    this.selectableDayPredicate,
    this.selectionMode = DateRangePickerSelectionMode.range,
    this.initialDisplayDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 406,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SfDateRangePicker(
              selectableDayPredicate: selectableDayPredicate,
              backgroundColor: Colors.white,
              headerHeight: 80,
              viewSpacing: 12,
              initialDisplayDate: initialDate ?? initialDisplayDate,
              initialSelectedDate: initialDate,
              navigationDirection: DateRangePickerNavigationDirection.vertical,
              headerStyle: const DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.white,
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(fontSize: 12),
                ),
              ),
              selectionMode: selectionMode,
              view: DateRangePickerView.month,
              allowViewNavigation: true,
              showActionButtons: true,
              onCancel: Get.back,
              onSubmit: (value) {
                if (value != null) {
                  if (selectionMode == DateRangePickerSelectionMode.range) {
                    var date = value as PickerDateRange;
                    if (date.startDate != null && date.endDate != null) {
                      onDateRangeSubmit!(date.startDate!, date.endDate!);
                      Get.back();
                    }
                  } else {
                    onDateSingleSubmit!(value as DateTime);
                    Get.back();
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
