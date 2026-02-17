import 'package:flutter/material.dart';

class PdksFaqScreen extends StatefulWidget {
  const PdksFaqScreen({Key? key}) : super(key: key);

  @override
  State<PdksFaqScreen> createState() => _PdksFaqScreenState();
}

class _PdksFaqScreenState extends State<PdksFaqScreen> {
  final titles = [
    'Konumum Takip Ediliyor mu?',
    'İnternet Paketimi Tüketir mi?',
    'Görevlendirmem olmasa da cihaz olmayan lokasyonlarda kullanabilir miyim?',
  ];

  final subtitles = [
    'Mobil Intranet PDKS uygulaması görevlendirilen personelin konumunu takip etmez, konum bilgisi sadece PDKS alanına tıklandığı esnasında eşleşme kontrolü amacıyla kullanılmaktadır.',
    'İntranet Mobil PDKS kullanımı internet paketi tüketim miktarı KB düzeyinde olduğu için göz ardı edilebilir düzeydedir.',
    'Mobil İntranet PDKS sayesinde konumunuza en yakın tanımlı hizmet lokasyonlarını gözleyebilir, yöneticinizin bilgisi dahilinde o lokasyonda giriş-çıkış  işlemi yapabilirsiniz'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular'),
      ),
      body: Column(
        children: List.generate(
          titles.length,
          (index) => ListTile(
            title: Text(titles[index]),
            subtitle: Text(subtitles[index]),
          ),
        ),
      ),
    );
  }
}
