import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/pages.dart';
import 'package:flutter_project_template/shared/utils/main_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mime/mime.dart';
import 'package:get/get.dart';

class Func {
  static Timer? _debouncer;

  static Future<void> _debounce(VoidCallback callback) async {
    if (_debouncer != null) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 1000), callback);
  }

  static Future<void> searchListener(
    String value,
    Future Function(String) onSearch,
  ) async {
    await _debounce(() async => onSearch(value));
  }

  static void clearSession() {
    modalHelper.showToast("Sesi Anda telah habis");
    session.clear();
    Get.offAllNamed(Routes.login);
  }

  static String encryptSHA256(String data) {
    var bytes = utf8.encode(data);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<void> shareFile(Uint8List byteData, String fileName) async {
    try {
      Directory? tempDir = await getTemporaryDirectory();

      String filePath = '${tempDir.path}/$fileName';
      File file = File(filePath);

      final result = await file.writeAsBytes(byteData);
      await SharePlus.instance.share(ShareParams(files: [XFile(result.path)]));
    } catch (e) {
      modalHelper.info(message: 'Terjadi kesalahan tidak terduga');
    }
  }

  static Future<void> openUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  static Future<bool> checkImageFile(String path) async {
    File imageFile = File(path);
    final mimeType = lookupMimeType(imageFile.path);
    return mimeType != null && mimeType.startsWith('image/');
  }

  static Future<File?> pickImage(BuildContext context) async {
    final source = await modalHelper.showImageSource(context);
    if (source != null) {
      try {
        modalHelper.loading();
        final resultImg = await ImagePicker().pickImage(
          source: source,
          imageQuality: 90,
          maxHeight: 1600,
          maxWidth: 1600,
        );
        Get.back();

        if (resultImg != null) {
          final imgIsValid = await checkImageFile(resultImg.path);
          if (!imgIsValid) {
            modalHelper.info(message: "Gambar yang Anda pilih tidak valid");
            return null;
          }
          return File(resultImg.path);
        }
      } catch (e) {
        Get.back();
        final status = await Permission.camera.status;
        if (status.isDenied) {
          modalHelper.info(
            message:
                'Gagal membuka kamera karena tidak memiliki izin mengakses kamera.',
          );
          return null;
        }
        modalHelper.info(message: 'Terjadi kesalahan tidak terduga!');
      }
    }
    return null;
  }
}
