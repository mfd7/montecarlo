import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montecarlo/ui/penaksiran.dart';
import 'home.dart';

class Hasil extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<TextEditingController> frekController;
  final List<TextEditingController> jmlLaptop;
  final List<double> kumulatif;
  final List<double> batasBawah;
  final int jmlData;
  final int frekuensi;

  Hasil(
      {Key key,
      this.controllers,
      this.frekController,
      this.jmlData,
      this.kumulatif,
      this.batasBawah,
      this.frekuensi,
      this.jmlLaptop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HasilScreenState();
  }
}

class HasilScreenState extends State<Hasil> {
  List<TextEditingController> kumulatif2 = new List();
  List<TextEditingController> batasBawah2 = new List();

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.jmlData; i++) {
      kumulatif2.add(new TextEditingController());
      kumulatif2[i].text = widget.kumulatif[i].toString();
    }
    for (var i = 0; i < widget.jmlData; i++) {
      batasBawah2.add(new TextEditingController());
      batasBawah2[i].text = widget.batasBawah[i].toString();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        title: new Text('Penjualan Laptop IBM 152017116'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 6,
              childAspectRatio: 5,
              children: [
                Center(
                  child: Text('Laptop/minggu'),
                ),
                Center(
                  child: Text('Frekuensi'),
                ),
                Center(
                  child: Text('Probabilitas'),
                ),
                Center(
                  child: Text('Prob. Kumulatif'),
                ),
                Center(
                  child: Text('Batas Bawah'),
                ),
                Center(
                  child: Text('Batas Atas'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 6,
              childAspectRatio: 0.01,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: new InputDecoration(
                        hintText: index.toString(),
                      ),
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      controller: widget.frekController[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      controller: widget.controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      controller: kumulatif2[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      controller: batasBawah2[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      controller: kumulatif2[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: widget.jmlData,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: RaisedButton(
        color: Colors.pink[200],
        textColor: Colors.white,
        child: Text('Next'),
        onPressed: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => Penaksiran(
              frekuensi: widget.frekuensi,
              batasBawah: widget.batasBawah,
              jmlData: widget.jmlData,
              jmlLaptop: widget.jmlLaptop,
            ),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}
