import 'package:bloc/bloc.dart';

class MainScreenCubit extends Cubit<int> {
  MainScreenCubit() : super(0);

  void onItemTapped(int index) {
    emit(index);
  }
}
