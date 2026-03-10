import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_btm_modal_camera_source.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModalHelper {
  Future loading({String? message}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        title: Column(
          children: [
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: AppTheme.primaryColor),
            const SizedBox(height: 40),
            Text(
              message ?? "Tunggu Sebentar....",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> showDialogCustom(Widget content) async {
    await Get.dialog(
      transitionCurve: Curves.easeIn,
      AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        actionsPadding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
        content: content,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }

  Future<void> showBottomBar(Widget content) async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(
              context,
            ).viewInsets.bottom, // naik saat keyboard muncul
          ),
          child: content,
        );
      },
    );
  }

  void showToast(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showSnackBar(String message, {double? maxWidth}) {
    Get.rawSnackbar(
      borderRadius: 80,
      snackPosition: SnackPosition.BOTTOM,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      backgroundColor: Colors.grey.withValues(alpha: 0.6),
      duration: const Duration(milliseconds: 1000),
      margin: const EdgeInsets.only(bottom: 30),
      messageText: Text(
        message,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    ImageSource? source;
    await showModalBottomSheet(
      context: context,
      builder: (context) => AppBtmModalCameraSource(onTap: (v) => source = v),
    );
    return source;
  }

  Future<bool?> info({required String message, Function? onOk}) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Informasi', style: AppTheme.titleDialogStyle),
        content: Text(message, style: AppTheme.contentDialogStyle),
        contentPadding: AppTheme.contentPaddingDialog,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onOk != null) {
                onOk();
              } else {
                Get.back(result: true);
              }
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  Future createDialog({
    required String title,
    required String message,
    List<Widget>? actions,
  }) {
    return Get.dialog(
      AlertDialog(
        title: Text(title, style: AppTheme.titleDialogStyle),
        contentPadding: AppTheme.contentPaddingDialog,
        content: Text(message, style: AppTheme.contentDialogStyle),
        actions: actions,
      ),
      barrierDismissible: false,
    );
  }

  Future error({required String message, Function? onOk}) {
    return Get.dialog(
      AlertDialog(
        title: const Text('Ada Kesalahan', style: AppTheme.titleDialogStyle),
        contentPadding: AppTheme.contentPaddingDialog,
        content: Text(message, style: AppTheme.contentDialogStyle),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onOk != null) {
                onOk();
              } else {
                Get.back();
              }
            },
            child: const Text('Ya'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<bool?> confirm({
    String? title,
    required String message,
    Function? onCancel,
    Function? onOk,
  }) {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text(title ?? 'Konfirmasi', style: AppTheme.titleDialogStyle),
        content: Text(message, style: AppTheme.contentDialogStyle),
        contentPadding: AppTheme.contentPaddingDialog,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              } else {
                Get.back(result: false);
              }
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (onOk != null) {
                onOk();
              } else {
                Get.back(result: true);
              }
            },
            child: const Text('Ya'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> showDateRangePicker(
    Function(DateTime, DateTime) onApplyClick, {
    DateTime? initialDate,
    bool Function(DateTime)? selectableDayPredicate,
  }) async {
    showDialogCustom(
      AppDatePicker(
        initialDate: initialDate,
        onDateRangeSubmit: onApplyClick,
        selectableDayPredicate: selectableDayPredicate,
      ),
    );
  }

  Future<void> showDatePicker(
    Function(DateTime) onApplyClick, {
    DateTime? initialDate,
    DateTime? initialDisplayDate,
    bool Function(DateTime)? selectableDayPredicate,
  }) async {
    showDialogCustom(
      AppDatePicker(
        initialDate: initialDate,
        initialDisplayDate: initialDisplayDate,
        onDateSingleSubmit: onApplyClick,
        selectionMode: DateRangePickerSelectionMode.single,
        selectableDayPredicate: selectableDayPredicate,
      ),
    );
  }
}
