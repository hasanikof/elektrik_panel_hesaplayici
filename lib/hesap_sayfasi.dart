import 'package:flutter/material.dart';

class HesapSayfasi extends StatefulWidget {
  late final double panelSayisi;
  late final double panelWatt;
  late final double panelTime;
  final double alisFiyati = 0.36;
  final double satisFiyati = 0.72;
  final double dagitimBedeli = 0.20;
  
  HesapSayfasi(@required this.panelSayisi, @required this.panelWatt, @required this.panelTime);

  late final double genelYuk = panelSayisi * panelWatt * panelTime;
  late final double aylikGenelYuk = (genelYuk * 30);
  late final double genelSatisFiyati = (aylikGenelYuk * satisFiyati)/1000;


  @override
  _HesapSayfasiState createState() => _HesapSayfasiState();
}

class _HesapSayfasiState extends State<HesapSayfasi> {
 
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Sayfasi"),
      ),
      body: Center(
        child: Column(
       
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.genelSatisFiyati} = TL "),
            Text("${widget.aylikGenelYuk/1000} watt")
          ],
        ),
      ),
    );
  }
}
