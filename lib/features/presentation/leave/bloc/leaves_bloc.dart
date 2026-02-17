import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/leave.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'leaves_event.dart';
part 'leaves_state.dart';

class LeavesBloc extends Bloc<LeavesEvent, LeavesState> {
  LeavesBloc(this.networkManager) : super(const LeavesState()) {
    on<GetLeaves>((event, emit) => _onGetLeaves(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetLeaves(GetLeaves event, Emitter<LeavesState> emit) async {
    emit(state.copyWith(status: LeaveStatus.loading));

    try {
      final response = await networkManager.get(Endpoints.leave);
      final leaveModel = LeaveModel.fromJson(response.data);
      if (leaveModel.leaveInfo != null) {
        emit(state.copyWith(
          status: LeaveStatus.success,
          leaveInfo: leaveModel.leaveInfo,
        ));
      } else {
        emit(state.copyWith(
          status: LeaveStatus.failure,
          statusMessage: leaveModel.message,
        ));
      }
    } catch (e) {}
  }
}
