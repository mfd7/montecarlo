import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Penaksiran extends StatefulWidget {
  final int frekuensi;
  final int jmlData;
  final List<double> batasBawah;
  final List<TextEditingController> jmlLaptop;

  Penaksiran(
      {Key key, this.frekuensi, this.jmlData, this.batasBawah, this.jmlLaptop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PenaksiranScreenState();
  }
}

class PenaksiranScreenState extends State<Penaksiran> {
  List<TextEditingController> _angkaAcak = new List();
  List<TextEditingController> _permintaan = new List();
  List<TextEditingController> _pemasukan = new List();
  var jmlPermintaan = 0;
  var jmlPemasukan = 0;
  double rataPermintaan = 0;
  double rataPemasukan = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Random random = new Random();
    for (var i = 0; i < 10; i++) {
      var acak = random.nextDouble() * (1 - 0) + 0;
      _angkaAcak.add(new TextEditingController());
      _angkaAcak[i].text = acak.toString();
    }

    for (var i = 0; i < 10; i++) {
      _permintaan.add(new TextEditingController());
      for (var j = widget.jmlData; j > 0; j--) {
        if (double.parse(_angkaAcak[i].text) >
            widget.batasBawah[widget.jmlData - 1]) {
          _permintaan[i].text = (widget.jmlData - 1).toString();
        } else if (double.parse(_angkaAcak[i].text) < widget.batasBawah[j]) {
          _permintaan[i].text = widget.jmlLaptop[j - 1].text;
        }
      }
    }

    for (var i = 0; i < 10; i++) {
      _pemasukan.add(new TextEditingController());
      _pemasukan[i].text =
          (int.parse(_permintaan[i].text) * 12500000).toString();
    }

    for (var i = 0; i < _permintaan.length; i++) {
      jmlPermintaan = jmlPermintaan + int.parse(_permintaan[i].text);
      jmlPemasukan = jmlPemasukan + int.parse(_pemasukan[i].text);
    }

    rataPermintaan = jmlPermintaan/70;
    rataPemasukan = jmlPemasukan/70;

    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: rataPemasukan);
    MoneyFormatterOutput fo = fmf.output;

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        title: new Text('Generalisasi & Penaksiran 152017116'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: 5,
              children: [
                Center(
                  child: Text('Minggu ke-'),
                ),
                Center(
                  child: Text('Angka Acak'),
                ),
                Center(
                  child: Text('Permintaan'),
                ),
                Center(
                  child: Text('Pemasukan'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: 0.17,
              children: [
                ListView.builder(
                  itemBuilder: (Context, index) {
                    return new TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: new InputDecoration(
                        hintText: (widget.frekuensi + 1 + index).toString(),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
                ListView.builder(
                  itemBuilder: (Context, index) {
                    return new TextField(
                      controller: _angkaAcak[index],
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: new InputDecoration(
                        hintText: (widget.frekuensi + 1 + index).toString(),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
                ListView.builder(
                  itemBuilder: (Context, index) {
                    return new TextField(
                      controller: _permintaan[index],
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: 10,
                ),
                ListView.builder(
                  itemBuilder: (Context, index) {
                    return new TextField(
                      controller: _pemasukan[index],
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: 10,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              childAspectRatio: 5,
              children: [
                Center(
                  child: Text(
                    'Jumlah Permintaan 10 Minggu kedepan:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text('$jmlPermintaan'),
                ),
                Center(
                  child: Text(
                    'Rata-rata permintaan/hari:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text('$rataPermintaan'),
                ),
                Center(
                  child: Text(
                    'Rata-rata pemasukan/hari:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(fo.nonSymbol),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
