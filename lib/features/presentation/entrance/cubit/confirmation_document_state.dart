part of 'confirmation_document_cubit.dart';

@immutable
class ConfirmationDocumentState {}

class ConfirmationDocumentInitial extends ConfirmationDocumentState {}

class ConfirmationDocumentInProgress extends ConfirmationDocumentState {}

class ConfirmationDocumentSuccess extends ConfirmationDocumentState {
  final ConfirmationDocument document;

  ConfirmationDocumentSuccess(this.document);
}

class ConfirmationDocumentAccepted extends ConfirmationDocumentState {}

class ConfirmationDocumentFailed extends ConfirmationDocumentState {
  final String message;

  ConfirmationDocumentFailed(this.message);
}

class ConfirmationDocumentConfirmSuccess extends ConfirmationDocumentState {}

class ConfirmationDocumentConfirmFailed extends ConfirmationDocumentState {
  final String message;

  ConfirmationDocumentConfirmFailed(this.message);
}
