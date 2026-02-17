part of 'corporate_salary_bloc.dart';

enum CorporateSalaryStatus {
  initial,
  loading,
  success,
  failure,
}

enum CorporateDateStatus {
  loading,
  success,
}

class CorporateSalaryState extends Equatable {
  const CorporateSalaryState({
    this.status = CorporateSalaryStatus.initial,
    this.dateStatus = CorporateDateStatus.loading,
    this.documents,
    this.months,
    this.years,
    this.selectedMonth,
    this.selectedYear,
  });

  final CorporateSalaryStatus status;
  final CorporateDateStatus dateStatus;
  final List<XmlElement>? documents;
  final List<int>? months;
  final List<int>? years;
  final int? selectedYear;
  final int? selectedMonth;

  CorporateSalaryState copyWith({
    CorporateSalaryStatus? status,
    CorporateDateStatus? dateStatus,
    List<XmlElement>? documents,
    List<int>? months,
    List<int>? years,
    int? selectedYear,
    int? selectedMonth,
  }) {
    return CorporateSalaryState(
      status: status ?? this.status,
      dateStatus: dateStatus ?? this.dateStatus,
      documents: documents ?? this.documents,
      months: months ?? this.months,
      years: years ?? this.years,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }

  @override
  List<Object> get props => [
        status,
        dateStatus,
        documents ?? [],
        months ?? [],
        years ?? [],
        selectedMonth ?? 1,
        selectedYear ?? 2024,
      ];
}
