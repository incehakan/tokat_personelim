import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/repository/pdks_repository.dart';
import 'bloc/duties_bloc.dart';
import 'bloc/entrance_operations_bloc.dart';
import '../../../../product/extensions/date_time_extension.dart';
import '../../../../product/utils/network_manager.dart';
import '../../../data/models/device_location_model.dart';
import '../../../data/models/pdks_duty_model.dart';
import '../cubit/entrance_cubit.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/custom_error_text.dart';
import '../../../../product/utils/open_map.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../../product/utils/show_loading_indicator.dart';

import '../../../../product/constants/app_colors.dart';
import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/router/app_routes.dart';
import '../../../widgets/employee_information_card.dart';
import '../../../widgets/loading_indicator.dart';

class EntranceOperationsScreen extends StatefulWidget {
  const EntranceOperationsScreen({Key? key}) : super(key: key);

  @override
  State<EntranceOperationsScreen> createState() => _EntranceOperationsScreenState();
}

class _EntranceOperationsScreenState extends State<EntranceOperationsScreen> {
  final dutiesBloc = DutiesBloc(
    NetworkManager(Dio()),
  );

  final entranceBloc = EntranceOperationsBloc(
    PdksRepository(
      NetworkManager(
        Dio(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => entranceBloc..add(const GetLastEntrance()),
        ),
        BlocProvider(
          create: (context) => dutiesBloc..add(const GetAvailableDeviceLocations()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.pdksOperations),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(AppRoutes.pdksFaq),
              icon: const Icon(Icons.question_mark),
            )
          ],
        ),
        body: BlocListener<EntranceOperationsBloc, EntranceOperationsState>(
          listener: (context, state) {
            if (state.status == EntranceOperationsStatus.entranceOperationFailed) {
              context.pop();
              showErrorMessage(state.message);
            } else if (state.status == EntranceOperationsStatus.entranceOperationInProgress) {
              showLoadingIndicator(context);
            } else if (state.status == EntranceOperationsStatus.entraneOperationSuccess) {
              context.pop();
              showSuccessMessage('İşleminiz başarılı');
            }
          },
          child: BlocBuilder<EntranceOperationsBloc, EntranceOperationsState>(
            builder: (context, state) {
              return const SingleChildScrollView(
                child: Padding(
                  padding: AppDimensions.pagePadding,
                  child: Column(
                    children: [
                      EmployeeInformationCard(),
                      SizedBox(height: AppDimensions.largeGap),
                      LastEntranceSection(),
                      SizedBox(height: AppDimensions.largeGap),
                      DutiesSection(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LastEntranceSection extends StatelessWidget {
  const LastEntranceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntranceOperationsBloc, EntranceOperationsState>(
      builder: (context, state) {
        switch (state.status) {
          case EntranceOperationsStatus.lastEntranceSuccess:
          case EntranceOperationsStatus.entranceOperationFailed:
          case EntranceOperationsStatus.entraneOperationSuccess:
          case EntranceOperationsStatus.entranceOperationInProgress:
            return Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'En son ${state.lastEntrance?.date!.formattedDate} - ${state.lastEntrance?.date!.formattedTime} tarihinde ',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.lynch,
                        ),
                    children: [
                      TextSpan(
                        text: state.entranceType.entranceText,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const TextSpan(
                        text: ' işlemi yaptınız.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.smallGap),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Aşağıdaki seçeneklerden ',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.lynch,
                        ),
                    children: [
                      TextSpan(
                        text: state.entranceType.entranceReverseText,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const TextSpan(
                        text: ' yapabilirsiniz :',
                      ),
                    ],
                  ),
                )
              ],
            );
          case EntranceOperationsStatus.lastEntranceFailed:
            return const SizedBox();
          case EntranceOperationsStatus.lastEntranceLoading:
          case EntranceOperationsStatus.initial:
            return const Center(
              child: CustomLoadingIndicator(),
            );
        }
      },
    );
  }
}

class DutiesSection extends StatelessWidget {
  const DutiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DutiesBloc, DutiesState>(
      builder: (context, state) {
        switch (state.status) {
          case DutiesStatus.dutiesLoading:
          case DutiesStatus.initial:
          case DutiesStatus.availableDevicesLoading:
            return const Center(
              child: CustomLoadingIndicator(),
            );
          case DutiesStatus.dutiesFailed:
          case DutiesStatus.locationServiceFailed:
            return Center(
              child: CustomErrorText(
                message: state.statusMessage.toString(),
              ),
            );
          case DutiesStatus.availableDevicesSuccess:
            return DevicesCloseToLocationSection(
              devices: state.availableDevices!,
            );
          case DutiesStatus.dutiesSuccess:
            return WhenAvailableDutySection(duties: state.duties);
          case DutiesStatus.notAvailableDutyOnLocation:
            return const WhenLocationIsNotAvailable();
        }
      },
    );
  }
}

class DevicesCloseToLocationSection extends StatelessWidget {
  const DevicesCloseToLocationSection({Key? key, required this.devices}) : super(key: key);

  final List<DeviceLocation> devices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return DeviceCard(
          deviceLocation: devices[index],
        );
      },
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({Key? key, required this.deviceLocation}) : super(key: key);

  final DeviceLocation deviceLocation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntranceOperationsBloc, EntranceOperationsState>(
      buildWhen: (previous, current) => current.entranceType != previous.entranceType,
      builder: (context, state) {
        return ListTile(
          title: Text('${state.entranceType}'),
          // title: Text(
          //   deviceLocation.adi.toString(),
          //   style: const TextStyle(
          //     color: Colors.white,
          //   ),
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppDimensions.buttonRadius,
          ),
          tileColor: context.read<EntranceOperationsBloc>().state.entranceType.cardColor,
          trailing: Text(
            context.read<EntranceOperationsBloc>().state.entranceType == EntranceType.entrance ? 'Çıkış Yap' : 'Giriş Yap',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {
            final entranceType = context.read<EntranceOperationsBloc>().state.entranceType;
            showDialog(
              context: context,
              builder: (_) {
                final deviceName = deviceLocation.adi.toString();
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  title: Text(
                    '$deviceName adlı cihazdan ${entranceType.entranceText} işlemi yapacaksınız. Onaylıyor musunuz?',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Kapat',
                            onPressed: () => context.pop(),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: AppButton(
                            text: 'Onayla',
                            onPressed: () {
                              context.pop();
                              context.read<EntranceOperationsBloc>().add(
                                    MakeEntrance(
                                      entranceType: entranceType,
                                      deviceId: deviceLocation.id.toString(),
                                    ),
                                  );
                              // context.read<EntranceCubit>().entranceOperation(
                              //       entranceType: context.read<EntranceCubit>().entranceType.toString(),
                              //       deviceId: deviceLocation.id!.round().toString(),
                              //     );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

/// Eğer kullanıcının üzerinde görevlendirme varsa gösterilecek olan kısım.
class WhenAvailableDutySection extends StatelessWidget {
  const WhenAvailableDutySection({Key? key, required this.duties}) : super(key: key);

  final List<PdksDuty> duties;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: AppDimensions.pd16,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Görevlendirmeniz Bulunmaktadır!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(),
              Text(
                'Başlangıç Tarihi',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                  '${DateFormat.yMd('tr').format(duties.first.baslamaTarihi!)} - ${DateFormat.jm('tr').format(duties.first.baslamaTarihi!)}'),
              Text(
                'Bitiş Tarihi',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "${DateFormat.yMd('tr').format(duties.first.bitisTarihi!)} - ${DateFormat.jm('tr').format(duties.first.bitisTarihi!)}",
              ),
              const Divider(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: context.read<EntranceCubit>().entranceTypeReverseText,
                    ),
                    const TextSpan(
                      text: " yapacağınız konuma ",
                    ),
                    TextSpan(
                      text: "BURADAN ",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<EntranceCubit>().entranceType == 1
                              ? openMap(duties.first.bitKoordinatX!, duties.first.bitKoordinatY!)
                              : openMap(duties.first.basKoordinatX!, duties.first.basKoordinatY!);
                        },
                    ),
                    const TextSpan(
                      text: "ulaşabilirsiniz.",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}

// Eğer kullanıcının konumu işlem yapmak için uygun değilse gösterilecek
// olan kısım.
class WhenLocationIsNotAvailable extends StatelessWidget {
  const WhenLocationIsNotAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.pd16,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: AppDimensions.cardRadius,
      ),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Bulunduğunuz lokasyonda ",
                ),
                TextSpan(
                  text: context.read<EntranceCubit>().entranceTypeReverseText,
                ),
                const TextSpan(
                  text: " yapamazsınız.",
                ),
                const TextSpan(
                  text: "\nSize En Yakın Konumlara ",
                ),
                TextSpan(
                  text: "BURADAN ",
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pushNamed(AppRoutes.pdksNearbyDevices);
                    },
                ),
                const TextSpan(
                  text: "Ulaşabilirsiniz",
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
