import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/fixture_model.dart';
import '../../../../../data/models/fixture_unit_model.dart';
import '../../../../../data/repository/corporate_repository.dart';

part 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  FixtureCubit(this.corporateRepository) : super(FixtureInitial());

  final CorporateRepository corporateRepository;

  FixtureUnit? unit;

  void selectUnit(FixtureUnit fixtureUnit) {
    unit = fixtureUnit;
  }

  Future<void> getUnits() async {
    emit(UnitsInProgress());
    final response = await corporateRepository.fetchFixtureUnits();
    response.fold(
      (l) => emit(UnitsFailed(l.message)),
      (r) => emit(UnitsSuccess(r)),
    );
  }

  Future<void> queryWithFixture(String unitId, String fixtureNo) async {
    emit(QueryWithFixtureInProgress());
    final response = await corporateRepository.queryWithFixture(
      unitId,
      fixtureNo,
    );
    response.fold(
      (l) => emit(QueryWithFixtureFailed(l.message)),
      (r) => emit(QueryWithFixtureSuccess(r)),
    );
  }
}
