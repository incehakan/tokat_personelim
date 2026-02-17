import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/repository/cache_repository.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/enums/info_type.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../../product/extensions/menu_route_extension.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/network_manager.dart';
import '../../data/models/menu_model.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'bloc/home_bloc.dart';
import '../notifications/active_popup_dialog.dart';

part 'home_screen_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final eventCarouselController = CarouselController();

  final List<String> carouselImages = [
    AppImages.firstHomeImage,
    AppImages.secondHomeImage,
    AppImages.thirdHomeImage,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(NetworkManager(Dio()))..add(const GetMenuItems()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.popUpSuccess) {
            showDialog(
              context: context,
              builder: (ctx) => ActivePopUpDialog(
                activePopUp: state.popUp!,
              ),
            );
          } else if (state.status == HomeStatus.firebaseMessageSuccess) {
            context.pushNamed(AppRoutes.notifications);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return const Center(
                child: CustomLoadingIndicator(),
              );
            case HomeStatus.menuFailed:
              return const CustomErrorText(
                message: 'Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz',
              );
            case HomeStatus.menuSuccess:
            case HomeStatus.popUpSuccess:
            case HomeStatus.firebaseMessageSuccess:
              return HomeScreenBody(
                carouselImages: carouselImages,
                menuItems: state.menu!,
              );
          }
        },
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.carouselImages,
    required this.menuItems,
  }) : super(key: key);

  final List<String> carouselImages;
  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                height: context.height / 3.5,
                width: context.width,
                child: Image.asset(
                  'assets/images/home_screen_header_image.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            PersonalInformationSection(menuItems: menuItems),
            const SizedBox(height: AppDimensions.mediumGap),
            CorporateInformationSection(menuItems: menuItems),
          ],
        ),
      ),
    );
  }
}

class PersonalInformationSection extends StatelessWidget {
  const PersonalInformationSection({Key? key, required this.menuItems})
      : super(key: key);

  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.personalInfo,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.lynch,
              ),
        ),
        const SizedBox(height: AppDimensions.smallGap),
        SizedBox(
          height: 100,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              menuItems.where((element) => element.type == 0.0).toList().length,
              (index) {
                var items =
                    menuItems.where((element) => element.type == 0.0).toList();
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: MenuCard(
                    menu: items[index],
                    infoType: InfoType.personal,
                    route: items[index].route,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CorporateInformationSection extends StatelessWidget {
  const CorporateInformationSection({
    Key? key,
    required this.menuItems,
  }) : super(key: key);

  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.corporateInfo,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.lynch,
              ),
        ),
        const SizedBox(height: AppDimensions.smallGap),
        SizedBox(
          height: 100,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              menuItems.where((element) => element.type == 1.0).toList().length,
              (index) {
                var items =
                    menuItems.where((element) => element.type == 1.0).toList();
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: MenuCard(
                    menu: items[index],
                    infoType: InfoType.corporate,
                    route: items[index].route,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
