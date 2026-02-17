import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/feed_model.dart';
import '../../../../../data/repository/notification_repository.dart';

part 'flows_state.dart';

class FlowsCubit extends Cubit<FlowsState> {
  FlowsCubit(this.notificationRepository) : super(FlowsInitial());

  final NotificationRepository notificationRepository;

  Future<void> getFeed() async {
    emit(FlowsInProgress());
    final response = await notificationRepository.fetchFeeds();
    response.fold(
      (l) => emit(FlowsFailed(l.message)),
      (r) => emit(FlowsSuccess(r)),
    );
  }
}
