import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nearby_devices_cubit.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/loading_indicator.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../../product/utils/open_map.dart';

import '../../data/models/pdks_device_model.dart';

class PdksNearbyDevicesScreen extends StatefulWidget {
  const PdksNearbyDevicesScreen({Key? key}) : super(key: key);

  @override
  State<PdksNearbyDevicesScreen> createState() => _PdksNearbyDevicesScreenState();
}

class _PdksNearbyDevicesScreenState extends State<PdksNearbyDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yakın Lokasyonlar'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocProvider(
          create: (context) => getIt.get<NearbyDevicesCubit>()..getDevices(),
          child: BlocBuilder<NearbyDevicesCubit, NearbyDevicesState>(
            builder: (context, state) {
              if (state is NearbyDevicesFailed) {
                return CustomErrorText(message: state.message);
              } else if (state is NearbyDevicesSuccess) {
                return SuccessBody(
                  devices: state.devices,
                );
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.devices}) : super(key: key);

  final List<PdksDevice> devices;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        devices.length,
        (index) => InfoCardTemplate(
          title: devices[index].adi.toString(),
          onTap: () => openMap(
            devices[index].koordinatX.toString(),
            devices[index].koordinatY.toString(),
          ),
        ),
      ),
    );
  }
}
