import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/fixture_model.dart';
import '../../../../../data/repository/corporate_repository.dart';

part 'query_with_serial_number_state.dart';

class QueryWithSerialNumberCubit extends Cubit<QueryWithSerialNumberState> {
  QueryWithSerialNumberCubit(this.corporateRepository) : super(QueryWithSerialNumberInitial());

  final CorporateRepository corporateRepository;

  Future<void> queryWithSerialNo(String barcode) async {
    emit(QueryWithSerialNumberInProgress());

    final response = await corporateRepository.queryWithSerialNo(barcode);
    response.fold(
      (l) => emit(QueryWithSerialNumberFailed(l.message)),
      (r) => emit(QueryWithSerialNumberSuccess(r)),
    );
  }
}
