import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../widgets/info_screen_header.dart';
import 'cubit/movable_active_page_cubit.dart';
import 'cubit/movable_count_cubit.dart';
import 'first_screen/movable_count_first_screen.dart';
import 'second_screen/movable_count_second_screen.dart';
import 'third_screen/movable_count_third_screen.dart';

class MovableCountScreen extends StatefulWidget {
  const MovableCountScreen({Key? key}) : super(key: key);

  @override
  State<MovableCountScreen> createState() => _MovableCountScreenState();
}

class _MovableCountScreenState extends State<MovableCountScreen> {
  final PageController pageController = PageController();

  String headerText(int index) {
    switch (index) {
      case 0:
        return 'Taşınır Sayımı Yapacağınız Birimi Seçiniz:';
      case 1:
        return 'Sayım Yapacağınız Barkodları Lütfen Okutun';
      default:
        return 'Sayım yaptığınız demirbaşlar aşağıdaki gibidir. Hatalı sayım yaptığınız demirbaşı sağdan sola doğru kaydırarak silebilirisiniz';
    }
  }

  @override
  void initState() {
    context.read<MovableCountCubit>().clearValues();
    context.read<MovableActivePageCubit>().changePage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taşınır Sayımı'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          children: [
            IconStepper(
              icons: const [
                Icon(
                  Icons.touch_app,
                  color: Colors.white,
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Icon(
                  Icons.add_to_photos_sharp,
                  color: Colors.white,
                ),
              ],
              enableStepTapping: false,
              activeStep: context.watch<MovableActivePageCubit>().state,
              enableNextPreviousButtons: false,
              lineColor: Theme.of(context).primaryColor,
              activeStepColor: Theme.of(context).primaryColor,
              stepColor: Theme.of(context).primaryColor,
              activeStepBorderColor: Theme.of(context).primaryColor,
            ),
            InfoScreenHeader(
              text: headerText(context.watch<MovableActivePageCubit>().state),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  MovablaCountFirstScreen(
                    pageController: pageController,
                  ),
                  MovableCountSecondScreen(
                    pageController: pageController,
                  ),
                  MovableCountThirdScreen(
                    pageController: pageController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
