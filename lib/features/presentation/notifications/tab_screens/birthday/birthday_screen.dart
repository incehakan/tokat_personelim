import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';

import '../../../../../product/constants/app_colors.dart';
import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_images.dart';
import '../../../../../product/extensions/context_extensions.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../../product/utils/show_error_message.dart';
import '../../../../data/models/birthday_model.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/birthday_cubit.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: BlocProvider(
        create: (context) => getIt.get<BirthdayCubit>()..getBirthdays(),
        child: BlocConsumer<BirthdayCubit, BirthdayState>(
          listener: (context, state) {
            if (state is BirthdayCelebrateFailed) {
              showErrorMessage(state.message);
            }
          },
          builder: (context, state) {
            if (state is BirthdayFailed) {
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else if (state is BirthdaySuccess) {
              return ListView(
                children: List.generate(
                  state.birthdays.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.mediumGap),
                    child: BirthdayCard(birthday: state.birthdays[index]),
                  ),
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

class BirthdayCard extends StatefulWidget {
  const BirthdayCard({Key? key, required this.birthday}) : super(key: key);

  final Birthday birthday;

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: AppDimensions.pd8,
          decoration: BoxDecoration(
            color: AppColors.selago,
            borderRadius: AppDimensions.cardRadius,
            border: Border.all(
              color: AppColors.sunsetOrange,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                AppImages.birthdayCakeImage,
                width: context.width * 0.3,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.birthday.baslik.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.birthday.ozet.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '${widget.birthday.begeniSayisi.toString()} kişi kutladı',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppDimensions.smallGap),
                    LikeButton(
                      padding: EdgeInsets.zero,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      circleColor: const CircleColor(
                        start: AppColors.sunsetOrange,
                        end: AppColors.sunsetOrange,
                      ),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: AppColors.sunsetOrange,
                        dotSecondaryColor: AppColors.sunsetOrange,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Ionicons.heart,
                          color: widget.birthday.begendiMi.toString() != "0" ? AppColors.sunsetOrange : Colors.grey,
                        );
                      },
                      countBuilder: (int? count, bool isLiked, String text) {
                        Widget result;
                        // if (count == 0 && akislarListesi![index].begendiMi.toString() == "0") {
                        if (widget.birthday.begendiMi.toString() == "0") {
                          result = const Text(
                            'Doğum Gününü Kutla!',
                          );
                        } else {
                          result = const Text(
                            "Tebriğiniz İletildi!",
                          );
                        }
                        count = 10;
                        return result;
                      },
                      likeCount: 0,
                      countPostion: CountPostion.right,
                      onTap: (bool isLiked) async {
                        if (widget.birthday.begendiMi.toString() == "0") {
                          final registerNo = widget.birthday.prsSicilId?.round().toString();
                          context.read<BirthdayCubit>().celebrateBirthday(
                                registerNo ?? "",
                                "0",
                              );
                        }
                        return !isLiked;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
