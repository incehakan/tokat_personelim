part of 'selected_files_cubit.dart';

class SelectedFilesState extends Equatable {
  const SelectedFilesState({
    this.files = const <PlatformFile>[],
  });

  final List<PlatformFile> files;

  SelectedFilesState copyWith({
    required List<PlatformFile> files,
  }) {
    return SelectedFilesState(
      files: files,
    );
  }

  @override
  List<Object> get props => [files];
}
