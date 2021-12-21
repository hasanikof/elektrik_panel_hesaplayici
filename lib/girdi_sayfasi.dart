import 'package:flutter/material.dart';
import 'package:splash_screen_reel/hesap_sayfasi.dart';
import 'package:splash_screen_reel/models/elektrik_panel.dart';
import 'package:splash_screen_reel/utils/database_helper.dart';

TextEditingController _panelSayisiController = TextEditingController();
TextEditingController _panelWattController = TextEditingController();
TextEditingController _gunIsigiSureController = TextEditingController();

class GirdiSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Girdi sayfasi"),
      ),
      body: _MyBody(),
    );
  }
}

class _MyBody extends StatefulWidget {
  const _MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<_MyBody> {
  DatabaseHelper? _databaseHelper;
  List<Paneller> tumPanellerListesi = [];

  @override
  void initState() {
    super.initState();
    tumPanellerListesi = List<Paneller>.empty(growable: true);
    _databaseHelper = DatabaseHelper();
    _databaseHelper!.tumPaneller().then((tumPanelleriTutanMapListesi) {
      for (Map<String, dynamic> okunanPanelMapi
          in tumPanelleriTutanMapListesi) {
        tumPanellerListesi
            .add(Paneller.dbdenOkudugunBilgiyiMapeDonustur(okunanPanelMapi));
      }
      print("db'den gelen panel sayisi : " +
          tumPanellerListesi.length.toString());
    }).catchError((hata) => print("hata :  $hata"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _panelSayisiController,
              obscureText: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Panel Sayısı',
              ),
            ),
            Divider(height: 20),
            TextField(
              controller: _panelWattController,
              obscureText: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Panellerin Watt'ı",
              ),
            ),
            Divider(height: 20),
            TextField(
              
              controller: _gunIsigiSureController,
              obscureText: false,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Günlük güneş süresi",
              ),
            ),
            Divider(height: 20),
            
            /*
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HesapSayfasi(
                              double.parse(_panelSayisiController.text),
                              double.parse(_panelWattController.text),
                              double.parse(_gunIsigiSureController.text))));
                },
                child: Text("Gönder")),
                
             */
            ElevatedButton(onPressed: () {
              
              _panelEkle(Paneller(int.tryParse(_panelWattController.text),5,5));
              
            }, child: Text("Yükle")),
          ],
        ),
      ),
    );
  }

  void _panelEkle(Paneller gelenPanel) async{
    
    var eklenenPanelIdsi = await _databaseHelper!.panelEkle(gelenPanel);
    gelenPanel.panelId = eklenenPanelIdsi;
    
  }
}
