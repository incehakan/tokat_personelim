import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/data/repository/cache_repository.dart';
import '../constants/app_strings.dart';

enum PayrollShareAction {
  whatsApp,
  email,
  saveToPhone,
}

class PayrollShareHelper {
  PayrollShareHelper(this._dio);

  final Dio _dio;

  Future<File> downloadPayroll(String url) async {
    final response = await _dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'Authorization': 'Bearer ${CacheRepository.getAccessToken()}',
        },
      ),
    );

    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) {
      throw Exception(AppStrings.generalErrorMessage);
    }

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/${_buildFileName(url)}');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> sharePayroll(
    File file, {
    required PayrollShareAction action,
  }) async {
    final xFile = XFile(
      file.path,
      mimeType: 'application/pdf',
      name: _buildFileName(file.path),
    );

    switch (action) {
      case PayrollShareAction.whatsApp:
        await Share.shareXFiles(
          [xFile],
          text: AppStrings.payrollShareMessage,
        );
        return;
      case PayrollShareAction.email:
        await Share.shareXFiles(
          [xFile],
          subject: AppStrings.payrollShareEmailSubject,
          text: AppStrings.payrollShareMessage,
        );
        return;
      case PayrollShareAction.saveToPhone:
        final savedPath = await FilePicker.platform.saveFile(
          dialogTitle: AppStrings.saveToPhone,
          fileName: _buildFileName(file.path),
          type: FileType.custom,
          allowedExtensions: const ['pdf'],
          bytes: await file.readAsBytes(),
        );
        if (savedPath == null) {
          throw PayrollSaveCancelledException();
        }
        return;
    }
  }

  String _buildFileName(String source) {
    final uri = Uri.tryParse(source);
    if (uri != null) {
      final lastSegment = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
      if (lastSegment.isNotEmpty && lastSegment.toLowerCase().endsWith('.pdf')) {
        return lastSegment;
      }
    }

    final fileName = source.split(Platform.pathSeparator).last;
    if (fileName.toLowerCase().endsWith('.pdf')) {
      return fileName;
    }

    return 'bordro_${DateTime.now().millisecondsSinceEpoch}.pdf';
  }
}

class PayrollSaveCancelledException implements Exception {}
