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
              return JobTrackingSucesssBody(link: state.link);
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

class JobTrackingSucesssBody extends StatefulWidget {
  const JobTrackingSucesssBody({Key? key, required this.link})
      : super(key: key);

  final String link;

  @override
  State<JobTrackingSucesssBody> createState() => _JobTrackingSucesssBodyState();
}

class _JobTrackingSucesssBodyState extends State<JobTrackingSucesssBody> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    final username = CacheRepository.getUsername();
    final password = CacheRepository.getPassword();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "${widget.link}/AutoLogin?username=$username&password=$password"));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
