import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../data/models/service_model.dart';
import '../../../widgets/custom_error_text.dart';
import '../../../widgets/info_card_template.dart';
import '../../../widgets/loading_indicator.dart';
import '../cubit/movable_count_cubit.dart';

class MovableCountRoomsScreen extends StatefulWidget {
  const MovableCountRoomsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MovableCountRoomsScreen> createState() => _MovableCountRoomsScreenState();
}

class _MovableCountRoomsScreenState extends State<MovableCountRoomsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovableCountCubit>().getRooms(
          context.read<MovableCountCubit>().selectedService!.id!.round().toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oda Seçiniz'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocBuilder<MovableCountCubit, MovableCountState>(
          builder: (context, state) {
            if (state is RoomsFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is RoomsSuccess) {
              return SuccessBody(services: state.services);
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.services}) : super(key: key);

  final List<ServiceData> services;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        services.length,
        (index) => InfoCardTemplate(
          onTap: () {
            context.read<MovableCountCubit>().selectRoom(services[index]);
            context.pop();
          },
          title: services[index].adi.toString(),
        ),
      ),
    );
  }
}
