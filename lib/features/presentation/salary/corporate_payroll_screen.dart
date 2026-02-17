import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/loading_indicator.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import 'package:xml/xml.dart';

import 'bloc/corporate_salary_bloc.dart';

class CorporatePayrollScreen extends StatefulWidget {
  const CorporatePayrollScreen({Key? key}) : super(key: key);

  @override
  State<CorporatePayrollScreen> createState() => _CorporatePayrollScreenState();
}

class _CorporatePayrollScreenState extends State<CorporatePayrollScreen> {
  final List<String> titles = [
    'Normal Tutar',
    'Hafta Tatili Tutarı',
    'Genel Tatil Tutarı',
    'Ücretli İzin Tutarı',
    'Mazeret İzin Tutarı',
    'Tatil Mesai Tutarı',
    'Fazla Mesai Tutarı(1)',
    'Fazla Mesai Tutarı(2)',
    'Gece Vardiya Tutarı',
    'Diğer Kazançlar',
    'Yemek',
    'Bayram',
    'Aile Yardımı',
    'Prim',
    'İkramiye',
    'İhbar Tazminatı',
    'Giyim Yardımı',
    'Doğum Yardımı',
    'Askerlik Yardımı',
    'Evlenme Yardımı',
    'Ölüm Yardımı',
    'Tahsil',
    'Sünnet Yardımı',
    'Ek Ödeme',
    'TIS Yol Yardımı',
    'Fark',
    'Sendika Aidatı',
    'Borç Taksidi',
    'İcra Taksidi',
    'Avans',
    'İzin Avansı',
    'Bayram Avansı',
    'Yakacak Avansı',
    'Ceza',
    'Diğer Kesinti(5)',
    'Diğer Kesinti(6)',
    'SSK Primi',
    'Devr Gelir Vergisi Matrahı',
    'Toplam Gelir Vergisi Matrahı',
    'Toplam Gelir Vergisi İndirimi',
    'Gelir Vergisi Matrahı',
    'Gelir Vergisi',
    'Damga Vergisi',
    'AGİ',
    'Toplam Kazanç',
    'Toplam Kesinti',
    'Yuvarlama Farkı',
    'Ödenecek Net Ücret'
  ];
  final List<String> subtitles = [
    "NormalTutar",
    "HaftaTatiliTutar",
    "GenelTatilTutar",
    "UcretliIzinTutar",
    "MazeretIzinTutar",
    "TatilMesTutar",
    "FazlaMes1Ucret",
    "FazlaMes2Ucret",
    "GeceVardTutar",
    "DigKazanc1Tutar",
    "Yemek",
    "Bayram",
    "AileYardimi",
    "Prim",
    "Ikramiye",
    "IhbarTazminati",
    "GiyimYardimi",
    "DogumYardimi",
    "AskerlikYardimi",
    "EvlenmeYardimi",
    "OlumYardimi",
    "Tahsil",
    "SunnetYardimi",
    "EkOdeme",
    "TISYolYardimi",
    "Fark",
    "SendikaAidati",
    "BorcTaksidi",
    "IcraTaksidi",
    "Avans",
    "IzinAvansi",
    "BayramAvansi",
    "YakacakAvansi",
    "Ceza",
    "DigerKesinti5",
    "DigerKesniti6",
    "SSKPrimi",
    "DevrGVMatrahi",
    "ToplamGVMatrahi",
    "ToplamGVInd",
    "GVMatrahi",
    "GelirVergisi",
    "DamgaVergisi",
    "TahakkukAyinaAitAsgariGecimIndirimi",
    "ToplamKazanc",
    "ToplamKesinti",
    "YuvarlamaFarki",
    "OdenecekNetUcret",
  ];

  @override
  void initState() {
    super.initState();
    context.read<CorporateSalaryBloc>().add(GetCorporateSalary(
          CacheRepository.userInfo().registryNo!.floor().toString(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.salaryInfo),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocBuilder<CorporateSalaryBloc, CorporateSalaryState>(
          builder: (context, state) {
            switch (state.status) {
              case CorporateSalaryStatus.initial:
              case CorporateSalaryStatus.loading:
                return const CustomLoadingIndicator();
              case CorporateSalaryStatus.failure:
                return const CustomErrorText();
              case CorporateSalaryStatus.success:
                return PayrollList(
                  documents: state.documents!,
                  titles: titles,
                  subtitles: subtitles,
                );
            }
          },
        ),
      ),
    );
  }
}

class PayrollList extends StatelessWidget {
  const PayrollList({Key? key, required this.documents, required this.titles, required this.subtitles}) : super(key: key);

  final Iterable<XmlElement> documents;
  final List<String> titles;
  final List<String> subtitles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subtitles.length,
      itemBuilder: (BuildContext context, int index) {
        return InfoCardTemplate(
          title: titles[index],
          subtitle: "${documents.first.findElements(subtitles[index]).first.children.first} ₺",
        );
      },
    );
  }
}
