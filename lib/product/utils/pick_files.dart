import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../constants/app_strings.dart';
import '../exceptions/server_exception.dart';

Future<Either<ServerException, List<PlatformFile>?>> pickFiles() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
      onFileLoading: (FilePickerStatus status) {},
      withData: true,
    );
    if (result != null) {
      return Right(result.files);
    }
    return const Right(null);
  } on PlatformException catch (_) {
    return Left(
      ServerException(AppStrings.generalErrorMessage),
    );
  }
}
