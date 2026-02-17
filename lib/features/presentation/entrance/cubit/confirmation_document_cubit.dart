import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/pdks_repository.dart';

import '../../../data/models/confirmation_document_model.dart';

part 'confirmation_document_state.dart';

class ConfirmationDocumentCubit extends Cubit<ConfirmationDocumentState> {
  ConfirmationDocumentCubit(this.pdksRepository) : super(ConfirmationDocumentInitial());

  final PdksRepository pdksRepository;

  Future<void> getConfirmationDocument() async {
    emit(ConfirmationDocumentInProgress());
    final response = await pdksRepository.fetchConfirmationDocument();
    response.fold(
      (l) => emit(ConfirmationDocumentFailed(l.message)),
      (r) {
        if (r != null) {
          emit(ConfirmationDocumentSuccess(r));
        } else {
          emit(ConfirmationDocumentAccepted());
        }
      },
    );
  }

  Future<void> confirmDocument(String documentId) async {
    final response = await pdksRepository.confirmDocument(documentId);
    response.fold(
      (l) async {
        emit(ConfirmationDocumentConfirmFailed(l.message));
        await getConfirmationDocument();
      },
      (r) => emit(ConfirmationDocumentConfirmSuccess()),
    );
  }
}
