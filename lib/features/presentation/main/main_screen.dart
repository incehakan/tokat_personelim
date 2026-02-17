import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/router/app_routes.dart';
import '../../data/repository/cache_repository.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import 'main_screen_cubit.dart';

part 'main_screen_items.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ZoomDrawerController drawerController = ZoomDrawerController();
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: MainScreenBody(
        drawerController: drawerController,
        pageController: pageController,
      ),
    );
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({
    Key? key,
    required this.drawerController,
    required this.pageController,
  }) : super(key: key);

  final ZoomDrawerController drawerController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenTapClose: true,
      controller: drawerController,
      showShadow: true,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      angle: 0,
      duration: const Duration(milliseconds: 400),
      menuBackgroundColor: AppColors.lynch,
      menuScreen: const DrawerMenu(),
      mainScreen: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            AppImages.appLogo,
            color: AppColors.lynch,
            width: 150,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.lynch,
            ),
            onPressed: () {
              drawerController.toggle!();
            },
          ),
          actions: [
            context.watch<MainScreenCubit>().state == 0
                ? IconButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.notifications);
                    },
                    icon: const Icon(Ionicons.notifications),
                    color: Theme.of(context).primaryColor,
                  )
                : PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: const Text('Çıkış Yap'),
                          onTap: () {
                            CacheRepository.logout();
                            context.pushReplacementNamed(AppRoutes.login);
                          },
                        ),
                      ];
                    },
                  ),
          ],
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Image.asset(
              AppImages.appIcon,
              width: 45,
              fit: BoxFit.scaleDown,
            ),
          ),
          onPressed: () => context.pushNamed(AppRoutes.feed),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<MainScreenCubit>().state,
          onTap: (value) {
            context.read<MainScreenCubit>().onItemTapped(value);
            pageController.jumpToPage(value);
          },
          items: List.generate(
            navbarLabels.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(navbarIcons[index]),
              label: navbarLabels[index],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lynch,
      body: Padding(
        padding: const EdgeInsets.only(left: AppDimensions.largeGap),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.appLogo),
            const SizedBox(height: AppDimensions.largeGap),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                drawerTitles.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.smallGap),
                  child: DrawerCard(
                    text: drawerTitles[index],
                    icon: drawerIcons[index],
                    route: drawerRoutes[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
