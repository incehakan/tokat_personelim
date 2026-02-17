import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_files_state.dart';

class SelectedFilesCubit extends Cubit<SelectedFilesState> {
  SelectedFilesCubit() : super(const SelectedFilesState());

  void addFile(List<PlatformFile>? files) {
    final state = this.state;

    if (files != null) {
      emit(
        SelectedFilesState(
          files: List.from(state.files)..addAll(files),
        ),
      );
    }
  }

  // void removePhoto(int index) {
  //   final state = this.state;
  //   emit(
  //     PhotoState(
  //       photos: List.from(state.photos)..removeAt(index),
  //     ),
  //   );
  // }
}
