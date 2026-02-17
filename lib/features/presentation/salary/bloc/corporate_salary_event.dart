part of 'corporate_salary_bloc.dart';

class CorporateSalaryEvent extends Equatable {
  const CorporateSalaryEvent();

  @override
  List<Object> get props => [];
}

class CorporateSalaryInitial extends CorporateSalaryEvent {
  @override
  List<Object> get props => [];
}

class GetCorporateSalary extends CorporateSalaryEvent {
  final String identity;

  const GetCorporateSalary(this.identity);
}

class SelectYear extends CorporateSalaryEvent {
  final int year;

  const SelectYear(this.year);

  @override
  List<Object> get props => [year];
}

class SelectMonth extends CorporateSalaryEvent {
  final int month;

  const SelectMonth(this.month);

  @override
  List<Object> get props => [month];
}
