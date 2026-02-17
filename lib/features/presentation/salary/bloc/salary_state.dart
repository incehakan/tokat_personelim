part of 'salary_bloc.dart';

enum SalaryStatus {
  initial,
  loading,
  success,
  failure,
}

class SalaryState extends Equatable {
  const SalaryState({
    this.status = SalaryStatus.initial,
    this.netSalary,
    this.grossSalary,
    this.salaryCuts,
    this.salaries,
    this.statusMessage,
  });

  final SalaryStatus status;
  final List<Salary>? salaries;
  final String? netSalary;
  final String? grossSalary;
  final String? salaryCuts;
  final String? statusMessage;

  SalaryState copyWith({
    SalaryStatus? status,
    String? netSalary,
    String? grossSalary,
    String? salaryCuts,
    List<Salary>? salaries,
    String? statusMessage,
  }) {
    return SalaryState(
      status: status ?? this.status,
      netSalary: netSalary ?? this.netSalary,
      grossSalary: grossSalary ?? this.grossSalary,
      salaryCuts: salaryCuts ?? this.salaryCuts,
      salaries: salaries ?? this.salaries,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        netSalary ?? "",
        grossSalary ?? "",
        salaryCuts ?? "",
        salaries ?? [],
        statusMessage ?? "",
      ];
}
