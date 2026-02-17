import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/movable_active_page_cubit.dart';
import '../cubit/movable_count_cubit.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/text_field_with_border.dart';
import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/show_error_message.dart';

class MovablaCountFirstScreen extends StatefulWidget {
  const MovablaCountFirstScreen({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  State<MovablaCountFirstScreen> createState() => _MovablaCountFirstScreenState();
}

class _MovablaCountFirstScreenState extends State<MovablaCountFirstScreen> {
  late TextEditingController _unitController;
  late TextEditingController _serviceController;
  late TextEditingController _roomController;

  @override
  void initState() {
    _unitController = TextEditingController();
    _serviceController = TextEditingController();
    _roomController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _unitController.dispose();
    _serviceController.dispose();
    _roomController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithBorder(
          controller: _unitController,
          hintText: 'Lütfen birim seçiniz',
          readOnly: true,
          onTap: () {
            context.pushNamed(AppRoutes.movableCountFixtureUnit).whenComplete(
              () {
                if (context.read<MovableCountCubit>().selectedUnit != null) {
                  _unitController.text = context.read<MovableCountCubit>().selectedUnit!.adi.toString();
                }
              },
            );
          },
        ),
        const SizedBox(height: AppDimensions.mediumGap),
        TextFieldWithBorder(
          controller: _serviceController,
          hintText: 'Lütfen servis seçiniz',
          readOnly: true,
          onTap: () {
            if (context.read<MovableCountCubit>().selectedUnit != null) {
              context.pushNamed(AppRoutes.movableCountServices).whenComplete(
                () {
                  if (context.read<MovableCountCubit>().selectedService != null) {
                    _serviceController.text = context.read<MovableCountCubit>().selectedService!.adi.toString();
                  }
                },
              );
            }
          },
        ),
        const SizedBox(height: AppDimensions.mediumGap),
        TextFieldWithBorder(
          controller: _roomController,
          readOnly: true,
          hintText: 'Lütfen oda seçiniz',
          onTap: () {
            if (context.read<MovableCountCubit>().selectedService != null) {
              context.pushNamed(AppRoutes.movableCountRooms).whenComplete(
                () {
                  if (context.read<MovableCountCubit>().selectedRoom != null) {
                    _roomController.text = context.read<MovableCountCubit>().selectedRoom!.adi.toString();
                  }
                },
              );
            }
          },
        ),
        const SizedBox(height: AppDimensions.mediumGap),
        AppButton(
          text: 'İleri',
          onPressed: () {
            if (context.read<MovableCountCubit>().selectedUnit != null) {
              context.read<MovableActivePageCubit>().changePage(1);
              widget.pageController.jumpToPage(1);
            } else {
              showErrorMessage('Lütfen Sayım Yapacağınız Yeri Seçiniz!');
            }
          },
        )
      ],
    );
  }
}
