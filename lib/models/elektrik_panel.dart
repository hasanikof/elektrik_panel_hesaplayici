class Paneller {
  
  int? _panelSayisi;
  int? _panelWattGucu;
  int? _panelIsikSuresi;
  int? _panelId;

  get panelSayisi => this._panelSayisi;

  set panelSayisi(value) => this._panelSayisi = value;

  get panelWattGucu => this._panelWattGucu;

  set panelWattGucu(value) => this._panelWattGucu = value;

  get panelIsikSuresi => this._panelIsikSuresi;

  set panelIsikSuresi(value) => this._panelIsikSuresi = value;

  get panelId => this._panelId;

  set panelId(value) => this._panelId = value;

  Paneller(this._panelWattGucu, this._panelSayisi, this._panelIsikSuresi);

  Paneller.withID(this._panelId, this._panelWattGucu, this._panelSayisi,
      this._panelIsikSuresi);

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map = Map<String, dynamic>();

    map["panelSayisi"] = _panelSayisi;
    map["panelWattGucu"] = _panelWattGucu;
    map["panelIsikSuresi"] = _panelIsikSuresi;
    map["panelID"] = _panelId;

    return map;
  }

  Paneller.dbdenOkudugunBilgiyiMapeDonustur(Map<String, dynamic> map) {
    _panelSayisi = map["panelSayisi"];
    _panelWattGucu = map["panelWattGucu"];
    _panelIsikSuresi = map["panelIsikSuresi"];
    _panelId = map["panelID"];
  }
}
