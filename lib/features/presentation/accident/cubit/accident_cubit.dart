import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/accident_report_model.dart';
import '../../../data/repository/corporate_repository.dart';

part 'accident_state.dart';

class AccidentCubit extends Cubit<AccidentState> {
  AccidentCubit(this.corporateRepository) : super(AccidentInitial());

  final CorporateRepository corporateRepository;

  Position? selectedLocation;

  List<PlatformFile>? selectedFiles;

  DateTime? selectedDate;

  void setLocation(Position position) {
    selectedLocation = position;
  }

  void selectFiles(List<PlatformFile> files) {
    selectedFiles = files;
  }

  void selectDate(DateTime date) {
    selectedDate = date;
  }

  String? get locationText => 'Enlem: ${selectedLocation?.latitude} Boylam: ${selectedLocation?.longitude} ';

  Future<void> getAccidentReports() async {
    emit(AccidentReportsInProgress());
    final response = await corporateRepository.fetchAccidentReports();
    response.fold(
      (l) => emit(AccidentReportsFailed(l.message)),
      (r) => emit(AccidentReportsSuccess(r)),
    );
  }

  Future<void> newAccident(DateTime date, String comment, Position location, List<PlatformFile>? files) async {
    emit(NewAccidentInProgress());
    final response = await corporateRepository.newAccidentReport(
      date: date,
      comment: comment,
      location: location,
      files: files,
    );
    response.fold(
      (l) => emit(NewAccidentFailed(l.message)),
      (r) => emit(NewAccidentSuccess(r)),
    );
  }
}
