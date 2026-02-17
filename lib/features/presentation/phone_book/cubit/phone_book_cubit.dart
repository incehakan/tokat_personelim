import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../data/repository/corporate_repository.dart';

import '../../../data/models/phone_book_model.dart';

part 'phone_book_state.dart';

class PhoneBookCubit extends Cubit<PhoneBookState> {
  PhoneBookCubit(this.corporateRepository) : super(PhoneBookInitial());

  final CorporateRepository corporateRepository;

  Future<void> getPhoneBooks() async {
    emit(PhoneBookInProgress());
    final response = await corporateRepository.fetchPhoneBook();
    response.fold(
      (l) => emit(PhoneBookFailed(AppStrings.generalErrorMessage)),
      (r) => emit(PhoneBookSuccess(r)),
    );
  }
}
