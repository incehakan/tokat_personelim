import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/subordinate_pdks_info_model.dart';

import 'cubit/subordinate_pdks_info_cubit.dart';
import '../../../../../widgets/bordered_text_button.dart';
import '../../../../../widgets/loading_indicator.dart';
import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/utils/dependency_injection.dart';

import '../../../../../../product/utils/open_map.dart';
import '../../../../../data/models/subordinates_model.dart';

class SubordinatePdksInfoScreen extends StatefulWidget {
  const SubordinatePdksInfoScreen({Key? key, required this.subordinate}) : super(key: key);

  final Subordinate subordinate;

  @override
  State<SubordinatePdksInfoScreen> createState() => _SubordinatePdksInfoScreenState();
}

class _SubordinatePdksInfoScreenState extends State<SubordinatePdksInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: BlocProvider(
        create: (context) => getIt.get<SubordinatePdksInfoCubit>()
          ..getSubordinatePdksInfo(
            widget.subordinate.sicilId!.round().toString(),
          ),
        child: BlocBuilder<SubordinatePdksInfoCubit, SubordinatePdksInfoState>(
          builder: (context, state) {
            if (state is SubordinatePdksInfoFailed) {
              return const Center();
            } else if (state is SubordinatePdksInfoSuccess) {
              return SuccessBody(
                pdksInfos: state.pdksInfos,
              );
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
  const SuccessBody({Key? key, required this.pdksInfos}) : super(key: key);

  final List<SubordinatePdksInfo> pdksInfos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pdksInfos.isNotEmpty ? pdksInfos.first.dates!.length : 0,
      itemBuilder: (context, index) {
        final info = pdksInfos.first.dates![index];
        return ExpansionTile(
          childrenPadding: AppDimensions.pd8,
          textColor: Colors.black,
          expandedAlignment: Alignment.topLeft,
          title: Text(
            "${info.tarih!.day.toString().padLeft(2, "0")}/${info.tarih!.month.toString().padLeft(2, "0")}/${info.tarih!.year}",
          ),
          children: [
            Column(
              children: List.generate(
                info.details!.length,
                (index) => Column(
                  children: [
                    ListTile(
                      title: Text(
                        info.details![index].kolonAdi.toString() == "Görevlendirme" ? 'Görevlendirme' : "Giriş Zamanı - Çıkış Zamanı",
                      ),
                      subtitle: Text(
                        info.details![index].kolonDeger.toString(),
                      ),
                    ),
                    info.details![index].kolonAdi.toString() == "Görevlendirme"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: BorderedTextButton(
                                  text: 'Başlangıç Noktası',
                                  onPressed: () {
                                    final latitude = info.details![index].basKoordinatX;
                                    final longtitude = info.details![index].basKoordinatY;
                                    openMap(latitude!, longtitude!);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: BorderedTextButton(
                                  text: 'Bitiş Noktası',
                                  onPressed: () {
                                    final latitude = info.details![index].bitKoordinatX;
                                    final longtitude = info.details![index].bitKoordinatY;
                                    openMap(latitude!, longtitude!);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

// Mock Data
//  return SuccessBody(
//                 pdksInfos: [
//                   SubordinatePdksInfo(
//                     registerId: 12345.0,
//                     nameSurname: 'Feyzullah Kodat',
//                     dates: [
//                       SubordinatePdksDates(
//                         tarih: DateTime.now(),
//                         details: [
//                           SubordinatePdksDetails(
//                             kolonAdi: 'Görevlendirme',
//                             kolonDeger: 'Alsancak',
//                             basKoordinatX: '38.423733',
//                             basKoordinatY: '27.142826',
//                             bitKoordinatX: '38.33256',
//                             bitKoordinatY: '26.76883',
//                           ),
//                           // SubordinatePdksDetails(
//                           //   kolonAdi: 'Görevlendirme',
//                           //   kolonDeger: 'kolon değer',
//                           //   basKoordinatX: '38.423733',
//                           //   basKoordinatY: '27.142826',
//                           //   bitKoordinatX: '38.33256',
//                           //   bitKoordinatY: '26.76883',
//                           // ),
//                         ],
//                       ),
//                       SubordinatePdksDates(
//                         tarih: DateTime.now(),
//                         details: [
//                           SubordinatePdksDetails(
//                             kolonAdi: 'Görevlendirme',
//                             kolonDeger: 'Urla',
//                             basKoordinatX: '38.423733',
//                             basKoordinatY: '27.142826',
//                             bitKoordinatX: '38.33256',
//                             bitKoordinatY: '26.76883',
//                           ),
//                           SubordinatePdksDetails(
//                             kolonAdi: '',
//                             kolonDeger: 'Çeşme',
//                             basKoordinatX: '38.423733',
//                             basKoordinatY: '27.142826',
//                             bitKoordinatX: '38.33256',
//                             bitKoordinatY: '26.76883',
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               );