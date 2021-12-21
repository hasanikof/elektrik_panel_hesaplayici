import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splash_screen_reel/models/elektrik_panel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String _panelTablo = "panel";
  String _columnPanelSayisi = "panelSayisi";
  String _columnPanelWatt = "panelWattGucu";
  String _columnPanelIsikSuresi = "panelIsikSuresi";
  String _columnPanelID = "panelID";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      DatabaseHelper _databaseHelper = DatabaseHelper._internal();
      //print("db helper null idi , oluşturuldu -satır 22");
      return _databaseHelper;
    } else {
      // print("db helper null değildi var olan kullanıldı ! - satır 26");
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDataBase() async {
    if (_database == null) {
      //print("database yok oluşturuluyor - satır 35");
      Database _database = await _initializeDatabase();
      return _database;
    } else {
      //print("database zaten var - satır 39");
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();

    String dbPath = join(klasor.path, "paneller.db");

    // print("Database path'i : " + dbPath);

    var panelDB = openDatabase(dbPath, version: 1, onCreate: _createDB);

    return panelDB;
  }

  //CRUD İŞLEMLERİ

  FutureOr<void> _createDB(Database db, int version) async {
    print("createDB metodu calistirildi tablo olusturulacak");
    await db.execute(
        "CREATE TABLE $_panelTablo ($_columnPanelID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnPanelIsikSuresi INTEGER, $_columnPanelSayisi INTEGER, $_columnPanelWatt INTEGER )");
  }

  Future<int> panelEkle(Paneller panel) async {
    var db = await _getDataBase();

    var sonuc = await db.insert(
      _panelTablo,
      panel.dbyeYazmakIcinMapeDonustur(),
      nullColumnHack: "$_columnPanelID",
    );
    print("ogrenci db'ye eklendi : " + sonuc.toString()); 
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumPaneller() async {
    var db = await _getDataBase();
    var sonuc = await db.query(_panelTablo, orderBy: "$_columnPanelID DESC");

    return sonuc;
  }

  Future<int> panelGuncelle(Paneller panel) async {
    var db = await _getDataBase();
    var sonuc = await db.update(
        _panelTablo, panel.dbyeYazmakIcinMapeDonustur(),
        where: "$_columnPanelID = ?", whereArgs: [panel.panelId]);

    return sonuc;
  }

  Future<int> panelSil(int id) async {
    var db = await _getDataBase();
    var sonuc = await db
        .delete(_panelTablo, where: "$_columnPanelID = ? ", whereArgs: [id]);
    return sonuc;
  }

  Future<int> tumPanelTablosunuSil() async {
    var db = await _getDataBase();
    var sonuc = await db.delete(_panelTablo);
    return sonuc;
  }
}
