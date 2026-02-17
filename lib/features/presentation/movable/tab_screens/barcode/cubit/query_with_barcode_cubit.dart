import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/fixture_model.dart';
import '../../../../../data/repository/corporate_repository.dart';

part 'query_with_barcode_state.dart';

class QueryWithBarcodeCubit extends Cubit<QueryWithBarcodeState> {
  QueryWithBarcodeCubit(this.corporateRepository) : super(QueryWithBarcodeInitial());

  final CorporateRepository corporateRepository;

  Future<void> queryWithBarcode(String barcode) async {
    emit(QueryWithBarcodeInProgress());
    final response = await corporateRepository.queryWithBarcode(
      barcode,
    );
    response.fold(
      (l) => emit(QueryWithBarcodeFailed(l.message)),
      (r) => emit(QueryWithBarcodeSuccess(r)),
    );
  }
}
