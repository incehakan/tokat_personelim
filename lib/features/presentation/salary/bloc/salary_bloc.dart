import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/salary.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'salary_event.dart';
part 'salary_state.dart';

class SalaryBloc extends Bloc<SalaryEvent, SalaryState> {
  SalaryBloc(this.networkManager) : super(const SalaryState()) {
    on<GetSalary>((event, emit) => _onGetSalary(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetSalary(GetSalary event, Emitter<SalaryState> emit) async {
    emit(state.copyWith(status: SalaryStatus.loading));
    try {
      final response = await networkManager.get(Endpoints.salary);
      final salaryModel = SalaryModel.fromJson(response.data);
      if (salaryModel.salaries!.isNotEmpty) {
        emit(state.copyWith(
          status: SalaryStatus.success,
          netSalary: salaryModel.salaries?.first.netSalary.toString(),
          grossSalary: salaryModel.salaries?.first.grossSalary.toString(),
          salaryCuts: salaryModel.salaries?.first.salaryCuts.toString(),
          salaries: salaryModel.salaries,
        ));
      } else {
        emit(state.copyWith(
          status: SalaryStatus.failure,
          statusMessage: salaryModel.sonucMesaj,
        ));
      }
    } on DioException catch (_) {
      emit(state.copyWith(
        status: SalaryStatus.failure,
      ));
    }
  }
}
