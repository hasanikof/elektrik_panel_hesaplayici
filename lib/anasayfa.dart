import 'package:flutter/material.dart';
import 'package:splash_screen_reel/girdi_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GirdiSayfasi()));
              },  
              child: Text("Girdi Oluştur")),
          ElevatedButton(onPressed: () {}, child: Text("Girdileri Göster")),
          ElevatedButton(onPressed: () {}, child: Text("Ayarlar")),
        ],
      )),
    );
  }
}
