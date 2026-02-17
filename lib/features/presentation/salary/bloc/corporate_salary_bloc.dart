import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'corporate_salary_event.dart';
part 'corporate_salary_state.dart';

class CorporateSalaryBloc extends Bloc<CorporateSalaryEvent, CorporateSalaryState> {
  CorporateSalaryBloc(this.networkManager) : super(const CorporateSalaryState()) {
    on<CorporateSalaryInitial>((event, emit) => _onCorporateSalaryInitial(event, emit));
    on<GetCorporateSalary>((event, emit) => _onGetCorporateSalary(event, emit));
    on<SelectYear>((event, emit) => _onSelectYear(event, emit));
    on<SelectMonth>((event, emit) => _onSelectMonth(event, emit));
  }

  final NetworkManager networkManager;

  void _onCorporateSalaryInitial(
    CorporateSalaryInitial event,
    Emitter<CorporateSalaryState> emit,
  ) {
    emit(state.copyWith(dateStatus: CorporateDateStatus.loading));
    List<int> years = [];
    final currentYear = DateTime.now().year;
    final threeYearsAgo = DateTime(currentYear - 2).year;
    for (var i = threeYearsAgo; i <= currentYear; i++) {
      years.add(i);
    }

    DateTime now = DateTime.now();
    List<int> months = [];

    int currentMonth = now.month;
    months = List.generate(currentMonth, (index) => index + 1);

    emit(state.copyWith(
      selectedMonth: currentMonth,
      selectedYear: currentYear,
      years: years,
      months: months,
      dateStatus: CorporateDateStatus.success,
    ));
  }

  void _onSelectYear(
    SelectYear event,
    Emitter<CorporateSalaryState> emit,
  ) {
    // Şu anki tarihi al
    DateTime now = DateTime.now();
    List<int> months = [];

    // Eğer seçilen yıl şu andan küçükse, tüm ayları listele
    if (event.year < now.year) {
      months = List.generate(12, (index) => index + 1);
    } else {
      // Eğer seçilen yıl şu andan büyükse, şu ana kadar geçen ayları listele
      int currentMonth = now.month;
      months = List.generate(currentMonth, (index) => index + 1);
    }

    emit(state.copyWith(
      selectedYear: event.year,
      months: months,
      dateStatus: CorporateDateStatus.success,
    ));
  }

  void _onSelectMonth(
    SelectMonth event,
    Emitter<CorporateSalaryState> emit,
  ) {
    emit(state.copyWith(selectedMonth: event.month));
  }

  Future<void> _onGetCorporateSalary(
    GetCorporateSalary event,
    Emitter<CorporateSalaryState> emit,
  ) async {
    emit(state.copyWith(
      status: CorporateSalaryStatus.loading,
    ));

    try {
      final response = await networkManager.get(
        Endpoints.corporateSalary,
        queryParameters: {
          "tcKimlik": event.identity,
          "yil": state.selectedYear,
          "ay": state.selectedMonth,
        },
      );

      List<XmlElement> documents = [];

      try {
        var document = xml.XmlDocument.parse(response.data);
        documents = document.findAllElements("User").toList();

        emit(state.copyWith(
          status: CorporateSalaryStatus.success,
          documents: documents,
        ));
      } on XmlParserException catch (_) {
        emit(state.copyWith(status: CorporateSalaryStatus.failure));
      }
    } on DioException catch (_) {
      emit(state.copyWith(status: CorporateSalaryStatus.failure));
    }
  }
}
