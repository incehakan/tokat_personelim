import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../data/repository/corporate_repository.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/text_field_with_border.dart';
import '../cubit/movable_active_page_cubit.dart';
import '../cubit/movable_count_cubit.dart';
import 'movable_count_dialog.dart';

class MovableCountSecondScreen extends StatefulWidget {
  const MovableCountSecondScreen({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  State<MovableCountSecondScreen> createState() =>
      _MovableCountSecondScreenState();
}

class _MovableCountSecondScreenState extends State<MovableCountSecondScreen> {
  late TextEditingController _movableController;

  @override
  void initState() {
    _movableController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _movableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppButton(
          text: 'Barkod Okut',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => _buildBarcodeScanner(context),
            );
          },
        ),
        const SizedBox(height: AppDimensions.smallGap),
        Text(
          'Veya',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimensions.smallGap),
        TextFieldWithBorder(
          controller: _movableController,
          hintText: 'Taşınır Ara',
          readOnly: true,
          onTap: () {
            context.pushNamed(AppRoutes.movableCountMovables).whenComplete(
              () {
                if (context.read<MovableCountCubit>().selectedMovable != null) {
                  _movableController.text = context
                      .read<MovableCountCubit>()
                      .selectedMovable!
                      .adi
                      .toString();
                  showDialog(
                    context: context,
                    builder: (ctx) => MovableCountDialog(
                      unitId: context
                          .read<MovableCountCubit>()
                          .selectedMovable!
                          .id
                          .toString(),
                      roomId:
                          context.read<MovableCountCubit>().selectedRoom != null
                              ? context
                                  .read<MovableCountCubit>()
                                  .selectedRoom!
                                  .id
                                  .toString()
                              : "0",
                      movableName: context
                          .read<MovableCountCubit>()
                          .selectedMovable!
                          .adi
                          .toString(),
                      tifDetailId: "0",
                      fixtureNo: '0',
                      fixtureEkNo: '0',
                      movableCodeId: context
                          .read<MovableCountCubit>()
                          .selectedUnit!
                          .id
                          .toString(),
                      comment: _movableController.text,
                    ),
                  );
                }
              },
            );
          },
        ),
        const SizedBox(height: AppDimensions.largeGap),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Geri',
                onPressed: () {
                  widget.pageController.jumpToPage(0);
                  context.read<MovableActivePageCubit>().changePage(0);
                },
              ),
            ),
            const SizedBox(width: AppDimensions.mediumGap),
            Expanded(
              child: AppButton(
                text: 'İleri',
                onPressed: () {
                  context.read<MovableActivePageCubit>().changePage(2);
                  widget.pageController.jumpToPage(2);
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBarcodeScanner(BuildContext context) {
    final scannerController = MobileScannerController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MobileScanner(
                controller: scannerController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty && barcodes[0].rawValue != null) {
                    final barcode = barcodes[0].rawValue!;
                    scannerController.dispose();
                    Navigator.pop(context);

                    if (mounted) {
                      getIt
                          .get<CorporateRepository>()
                          .queryWithSerialNo(barcode)
                          .then(
                        (value) {
                          if (mounted) {
                            value.fold(
                              (l) => showErrorMessage(
                                  "Demirbaş bulunamadı! Lütfen doğru barkodu okuttuğunuzdan emin olun."),
                              (r) => showDialog(
                                context: context,
                                builder: (ctx) => MovableCountDialog(
                                  unitId: context
                                      .read<MovableCountCubit>()
                                      .selectedMovable!
                                      .id
                                      .toString(),
                                  roomId: context
                                      .read<MovableCountCubit>()
                                      .selectedRoom!
                                      .id
                                      .toString(),
                                  movableName: context
                                      .read<MovableCountCubit>()
                                      .selectedMovable!
                                      .adi
                                      .toString(),
                                  // tifDetailId: r.tifDetayId.toString(),
                                  tifDetailId: barcode,
                                  fixtureNo: r.demirbasNo.toString(),
                                  fixtureEkNo: r.demirbasEkNo.toString(),
                                  movableCodeId: "0",
                                  comment: "Açıklama girilmemiştir.",
                                  employeeName: r.zimmetliPersonel.toString(),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Geri'),
          ),
        ],
      ),
    );
  }
}
