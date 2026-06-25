import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/utils/network_manager.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/job_tracking_cubit.dart';
import 'job_tracking_link.dart';

class JobTrackingScreen extends StatefulWidget {
  const JobTrackingScreen({Key? key}) : super(key: key);

  @override
  State<JobTrackingScreen> createState() => _JobTrackingScreenState();
}

class _JobTrackingScreenState extends State<JobTrackingScreen> {
  final cubit = JobTrackingCubit(NetworkManager(Dio()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.jobTracking),
      ),
      body: BlocProvider(
        create: (context) => cubit..getLink(),
        child: BlocBuilder<JobTrackingCubit, JobTrackingState>(
          builder: (context, state) {
            if (state is JobTrackingFailed) {
              return CustomErrorText(message: state.message);
            } else if (state is JobTrackingSuccess) {
              return JobTrackingSuccessBody(link: state.link);
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class JobTrackingSuccessBody extends StatefulWidget {
  const JobTrackingSuccessBody({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  State<JobTrackingSuccessBody> createState() => _JobTrackingSuccessBodyState();
}

class _JobTrackingSuccessBodyState extends State<JobTrackingSuccessBody> {
  WebViewController? _controller;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final loginUri = buildJobTrackingAutoLoginUri(
      baseUrl: widget.link,
      username: CacheRepository.getUsername(),
      password: CacheRepository.getPassword(),
    );

    if (loginUri == null) {
      _errorMessage = CacheRepository.getUsername() == null ||
              CacheRepository.getPassword() == null
          ? AppStrings.jobTrackingCredentialsMissing
          : AppStrings.jobTrackingLinkUnavailable;
      return;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(loginUri);
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return CustomErrorText(message: _errorMessage!);
    }

    return WebViewWidget(controller: _controller!);
  }
}
