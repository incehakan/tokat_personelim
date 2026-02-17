import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/debit.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'debit_event.dart';
part 'debit_state.dart';

class DebitBloc extends Bloc<DebitEvent, DebitState> {
  DebitBloc(this.networkManager) : super(const DebitState()) {
    on<GetDebits>((event, emit) => _onGetDebits(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetDebits(GetDebits event, Emitter<DebitState> emit) async {
    emit(state.copyWith(status: DebitStatus.loading));
    try {
      final response = await networkManager.get(Endpoints.debit);
      final debitModel = DebitModel.fromJson(response.data);

      // Servisten dönen mesaj alınıyor
      final message = debitModel.message ?? 'Bilinmeyen hata';

      if (debitModel.code == -1) {
        // Veri yoksa başarılı durum olarak işaretle ama mesajı da ilet
        emit(state.copyWith(
          status: DebitStatus.success,
          debitInfo: DebitInfo(
            registrationAuthority: null,
            debits: [], // Boş liste olarak başlat, null yerine
          ),
          statusMessage: message,
        ));
      } else if (debitModel.debitInfo != null) {
        // Normal başarılı durum
        final debitInfo = debitModel.debitInfo!;
        // Zimmetler null ise boş liste olarak ata
        if (debitInfo.debits == null) {
          debitInfo.debits = [];
        }

        emit(state.copyWith(
          status: DebitStatus.success,
          debitInfo: debitInfo,
        ));
      } else {
        emit(state.copyWith(
          status: DebitStatus.failure,
          statusMessage: message,
        ));
      }
    } on DioException catch (_) {
      emit(state.copyWith(
        status: DebitStatus.failure,
        statusMessage: 'Bağlantı hatası',
      ));
    }
  }
}
