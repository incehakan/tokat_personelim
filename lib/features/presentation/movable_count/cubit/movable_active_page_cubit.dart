import 'package:bloc/bloc.dart';

class MovableActivePageCubit extends Cubit<int> {
  MovableActivePageCubit() : super(0);

  void changePage(index) {
    emit(index);
  }
}
