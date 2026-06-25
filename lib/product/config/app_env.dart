class AppEnv {
  AppEnv._();

  /// Run with:
  /// flutter run --dart-define=USE_MOCK=true
  static const bool useMock = bool.fromEnvironment(
    'USE_MOCK',
    defaultValue: false,
  );
}
