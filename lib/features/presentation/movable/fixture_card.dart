import 'package:flutter/material.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../data/models/fixture_model.dart';

class FixtureCard extends StatelessWidget {
  const FixtureCard({Key? key, required this.fixture}) : super(key: key);

  final Fixture fixture;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppDimensions.pd16,
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Zimmetli Personel Adı:',
              ),
              subtitle: Text(
                fixture.zimmetliPersonel != null ? fixture.zimmetliPersonel! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Birim Adı:',
              ),
              subtitle: Text(
                fixture.birim != null ? fixture.birim! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Servis Adı:',
              ),
              subtitle: Text(
                fixture.servis != null ? fixture.servis! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Oda Adı:',
              ),
              subtitle: Text(
                fixture.oda != null ? fixture.oda! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Demirbaş Numarası:',
              ),
              subtitle: Text(
                fixture.demirbasNo != null ? fixture.demirbasNo!.round().toString() : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Malzeme Adı:',
              ),
              subtitle: Text(
                fixture.malzemeAdi != null ? fixture.malzemeAdi! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Durumu:',
              ),
              subtitle: Text(
                fixture.durumu != null ? fixture.durumu! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Cihaz Seri No:',
              ),
              subtitle: Text(
                fixture.cihazSeriNo != null ? fixture.cihazSeriNo! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Cihaz Kod Adı:',
              ),
              subtitle: Text(
                fixture.cihazKodAdi != null ? fixture.cihazKodAdi! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Garanti Başlama Tarihiı:',
              ),
              subtitle: Text(
                fixture.garantiBaslamaTarihi != null ? fixture.garantiBaslamaTarihi!.toString() : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Marka:',
              ),
              subtitle: Text(
                fixture.marka != null ? fixture.marka! : 'Bulunamadı',
              ),
            ),
            ListTile(
              title: const Text(
                'Şase No:',
              ),
              subtitle: Text(
                fixture.saseNo != null ? fixture.saseNo! : 'Bulunamadı',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
