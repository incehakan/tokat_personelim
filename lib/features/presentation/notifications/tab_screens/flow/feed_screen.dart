import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../product/constants/app_colors.dart';
import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_images.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../data/models/feed_model.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/info_card_template.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/flows_cubit.dart';

class FlowScreen extends StatefulWidget {
  const FlowScreen({Key? key}) : super(key: key);

  @override
  State<FlowScreen> createState() => _FlowScreenState();
}

class _FlowScreenState extends State<FlowScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FlowsCubit>()..getFeed(),
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocBuilder<FlowsCubit, FlowsState>(
          builder: (context, state) {
            if (state is FlowsFailed) {
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else if (state is FlowsSuccess) {
              return ListView(
                children: List.generate(
                  state.feeds.length,
                  (index) => FeedCard(feed: state.feeds[index]),
                ),
              );
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

// Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (_) => MenuPage(
//       gonderiListeleri![index].baskanlikAdi!,
//       gonderiListeleri![index].id.toString(),
//     ),
//   ),
// );

class FeedCard extends StatelessWidget {
  const FeedCard({Key? key, required this.feed}) : super(key: key);

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      leading: Image.asset(
        AppImages.appIcon,
        color: AppColors.kashmirBlue,
      ),
      title: feed.baskanlikAdi.toString(),
    );
  }
}
