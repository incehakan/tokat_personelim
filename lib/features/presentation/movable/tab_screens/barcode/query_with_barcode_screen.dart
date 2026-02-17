import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_images.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/query_with_barcode_cubit.dart';

class QueryWithBarcodeScreen extends StatefulWidget {
  const QueryWithBarcodeScreen({Key? key}) : super(key: key);

  @override
  State<QueryWithBarcodeScreen> createState() => _QueryWithBarcodeScreenState();
}

class _QueryWithBarcodeScreenState extends State<QueryWithBarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<QueryWithBarcodeCubit>(),
      child: Column(
        children: [
          Image.asset(
            AppImages.barcodeImage,
            fit: BoxFit.contain,
            width: 150,
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          AppButton(
            text: 'Barkod ile Sorgula',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => _buildBarcodeScanner(context),
              );
            },
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          BlocBuilder<QueryWithBarcodeCubit, QueryWithBarcodeState>(
            builder: (context, state) {
              if (state is QueryWithBarcodeInitial) {
                return const Center(
                  child: Text(
                      'Taşınır bilgisi görüntülemek için barkod okutunuz.'),
                );
              } else if (state is QueryWithBarcodeSuccess) {
                return const Center(
                  child: Text('data'),
                );
              } else if (state is QueryWithBarcodeFailed) {
                return CustomErrorText(message: state.message);
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          )
        ],
      ),
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
                    final value = barcodes[0].rawValue!;
                    scannerController.dispose();
                    Navigator.pop(context);

                    if (mounted && value.isNotEmpty) {
                      context
                          .read<QueryWithBarcodeCubit>()
                          .queryWithBarcode(value);
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
