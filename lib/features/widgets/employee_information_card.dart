import 'package:flutter/material.dart';

import '../../product/constants/app_colors.dart';
import '../../product/constants/app_dimensions.dart';
import '../../product/constants/app_images.dart';
import '../../product/constants/app_strings.dart';
import '../../product/extensions/context_extensions.dart';
import '../data/models/user_info_model.dart';
import '../data/repository/cache_repository.dart';

class EmployeeInformationCard extends StatelessWidget {
  const EmployeeInformationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInfo user = CacheRepository.userInfo();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: context.width,
          padding: AppDimensions.pd16,
          decoration: const BoxDecoration(
            borderRadius: AppDimensions.cardRadius,
            color: AppColors.lynch,
            boxShadow: [
              BoxShadow(
                color: AppColors.lynch,
                offset: Offset(0, 9),
                blurRadius: 11,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name} ${user.surname}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: AppDimensions.smallGap),
              Text(
                user.title.toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${AppStrings.registerNo}: ",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    user.registerNo!.round().toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -20,
          right: 10,
          child: Image.asset(
            AppImages.profileCardImage,
            height: 60,
          ),
        )
      ],
    );
  }
}
