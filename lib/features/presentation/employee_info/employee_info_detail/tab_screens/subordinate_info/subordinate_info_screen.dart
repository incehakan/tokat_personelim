import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/models/subordinates_model.dart';
import '../../../../../data/models/user_info_model.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/loading_indicator.dart';
import 'cubit/subordinate_info_cubit.dart';

class SubordinateInfoScreen extends StatefulWidget {
  const SubordinateInfoScreen({Key? key, required this.subordinate}) : super(key: key);

  final Subordinate subordinate;

  @override
  State<SubordinateInfoScreen> createState() => _SubordinateInfoScreenState();
}

class _SubordinateInfoScreenState extends State<SubordinateInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: BlocProvider(
        create: (context) => getIt.get<SubordinateInfoCubit>()
          ..getSubordinateInfo(
            widget.subordinate.sicilId!.toInt().toString(),
          ),
        child: BlocBuilder<SubordinateInfoCubit, SubordinateInfoState>(
          builder: (context, state) {
            // return SubordinateInfoScreenSuccessBody(
            //   employeeInfo: EmployeeInfo(
            //     name: 'Feyzullah Kodat',
            //     workplaceName: 'İztek',
            //     dutyPlaceName: 'İztek',
            //     personelTypeName: 'Yazılımcı',
            //     registerNo: 123456.0,
            //     startingDate: '26.12.1996',
            //     registryNo: 26512158022.0,
            //     birthdate: '26.12.1996',
            //     phoneNumber: '5442475785',
            //     email: 'feyzkodat@gmail.com',
            //     address: 'Etiler mah. 873 sok. Aydın apt.',
            //   ),
            // );
            if (state is SubordinateInfoFailed) {
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else if (state is SubordinateInfoSuccess) {
              return SubordinateInfoScreenSuccessBody(
                employeeInfo: state.employeeInfo,
              );
            } else {
              return const Center(child: CustomLoadingIndicator());
            }
          },
        ),
      ),
    );
  }
}

class SubordinateInfoScreenSuccessBody extends StatelessWidget {
  const SubordinateInfoScreenSuccessBody({Key? key, required this.employeeInfo}) : super(key: key);

  final UserInfo employeeInfo;

  @override
  Widget build(BuildContext context) {
    final titles = [
      'İş Yeri Adı',
      'Görev Yeri',
      'Personel Türü',
      'Sicil Numarası',
      'Başlangıç Tarihi',
      'TC Kimlik Numarası',
      'Doğum Tarihi',
      'Cep Telefonu',
      'E-Posta',
    ];

    final contents = [
      employeeInfo.workplaceName,
      employeeInfo.dutyPlaceName,
      employeeInfo.personelTypeName,
      employeeInfo.registerNo!.round(),
      employeeInfo.startingDate,
      employeeInfo.registryNo!.round(),
      employeeInfo.birthdate,
      employeeInfo.phoneNumber,
      employeeInfo.email,
    ];

    return ListView(
      children: List.generate(
        titles.length,
        (index) => ListTile(
          title: Text(titles[index].toString()),
          subtitle: Text(contents[index].toString()),
        ),
      ),
    );
  }
}


      // Mock Data
  