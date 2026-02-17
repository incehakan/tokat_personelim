part of 'fixture_cubit.dart';

@immutable
class FixtureState {}

class FixtureInitial extends FixtureState {}

class UnitsInProgress extends FixtureState {}

class UnitsSuccess extends FixtureState {
  final List<FixtureUnit> units;

  UnitsSuccess(this.units);
}

class UnitsFailed extends FixtureState {
  final String message;

  UnitsFailed(this.message);
}

class QueryWithFixtureInProgress extends FixtureState {}

class QueryWithFixtureSuccess extends FixtureState {
  final Fixture fixture;

  QueryWithFixtureSuccess(this.fixture);
}

class QueryWithFixtureFailed extends FixtureState {
  final String message;

  QueryWithFixtureFailed(this.message);
}
