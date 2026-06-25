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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: MainScreenBody(
        drawerController: drawerController,
      ),
    );
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({
    Key? key,
    required this.drawerController,
  }) : super(key: key);

  final ZoomDrawerController drawerController;

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
          title: const Text(
            'TOKAT BELEDİYESİ',
            style: TextStyle(
              color: AppColors.lynch,
              fontWeight: FontWeight.w700,
            ),
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
        body: IndexedStack(
          index: context.watch<MainScreenCubit>().state,
          children: const [
            HomeScreen(),
            ProfileScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            context.read<MainScreenCubit>().onItemTapped(0);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<MainScreenCubit>().state,
          onTap: (value) {
            context.read<MainScreenCubit>().onItemTapped(value);
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
            const Text(
              'TOKAT BELEDİYESİ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
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
