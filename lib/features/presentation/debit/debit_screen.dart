import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/constants/app_images.dart';
import 'bloc/debit_bloc.dart';
import '../../../product/utils/network_manager.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../data/models/debit.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/employee_information_card.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/red_container.dart';

/// Zimmet Bilgilerim
class DebitScreen extends StatefulWidget {
  const DebitScreen({Key? key}) : super(key: key);

  @override
  State<DebitScreen> createState() => _DebitScreenState();
}

class _DebitScreenState extends State<DebitScreen> {
  final bloc = DebitBloc(NetworkManager(Dio()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.debitInfo),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(GetDebits()),
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: BlocBuilder<DebitBloc, DebitState>(
            builder: (context, state) {
              switch (state.status) {
                case DebitStatus.initial:
                case DebitStatus.loading:
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                case DebitStatus.failure:
                  return Center(
                    child: Center(
                      child: CustomErrorText(
                        message: state.statusMessage,
                      ),
                    ),
                  );
                case DebitStatus.success:
                  // Zimmet kayıtları bulunamadı mesajı varsa göster
                  if (state.statusMessage != null &&
                      state.statusMessage!.isNotEmpty) {
                    return Center(
                      child: Text(state.statusMessage!),
                    );
                  }
                  // Debits null değil ama boş ise
                  return state.debitInfo?.debits?.isEmpty ?? true
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Zimmet bilgileriniz bulunamadı",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const EmployeeInformationCard(),
                              const SizedBox(height: AppDimensions.mediumGap),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RedContainer(
                                    title: AppStrings.debitCount,
                                    info: (state.debitInfo?.debits?.length ?? 0)
                                        .toString(),
                                  ),
                                  RedContainer(
                                    title: AppStrings.registrationAuthority,
                                    info: state
                                            .debitInfo?.registrationAuthority ??
                                        AppStrings.notFound,
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimensions.largeGap),
                              const InfoScreenHeader(
                                  text: AppStrings.debitDetailnfo),
                              if (state.debitInfo?.debits?.isEmpty ?? true)
                                const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(AppDimensions.mediumGap),
                                    child: Text(AppStrings.notFound),
                                  ),
                                )
                              else
                                Padding(
                                  padding: AppDimensions.pd8,
                                  child: Column(
                                    children: List.generate(
                                      state.debitInfo!.debits!.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: AppDimensions.mediumGap),
                                        child: DebitInformationCard(
                                          debit:
                                              state.debitInfo!.debits![index],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DebitInformationCard extends StatelessWidget {
  const DebitInformationCard({Key? key, required this.debit}) : super(key: key);

  final Debit debit;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: debit.name.toString(),
      subtitle: debit.unit.toString(),
      trailing: Image.asset(
        AppImages.debitImage,
        height: context.height / 20,
      ),
    );
  }
}
