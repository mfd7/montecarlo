import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montecarlo/ui/hasil.dart';
import 'dart:developer';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<Home> {
  String input = '0';
  int frekuensi = 0;
  double sumKumulatif = 0;
  double batasBawah = 0;
  double batasAtas = 0;
  List<TextEditingController> _controllers = new List();
  List<TextEditingController> _frekController = new List();
  List<TextEditingController> _jmlLaptop = new List();
  List<double> kumulatif = new List();
  List<double> _batasBawah = new List();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    for(var i = 0; i < int.parse(input); i++){
      _jmlLaptop.add(new TextEditingController());
      _jmlLaptop[i].text = i.toString();
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        title: new Text('Montecarlo 152017116'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Berapa banyak data yang akan diinputkan?'),
              onSubmitted: (String str) {
                setState(() {
                  input = str;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 3,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.01,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return new TextField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      controller: _jmlLaptop[index],
                    );
                  },
                  itemCount: int.parse(input),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    _frekController.add(new TextEditingController());
                    return new TextField(
                      controller: _frekController[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onSubmitted: (String str) {
                        setState(() {
                          frekuensi = frekuensi +
                              int.parse(_frekController[index].text);
                          _controllers[index].text =
                              (int.parse(_frekController[index].text) /
                                      frekuensi)
                                  .toString();
                          for (var i = 0; i < index; i++) {
                            _controllers[i].text =
                                (int.parse(_frekController[i].text) / frekuensi)
                                    .toString();
                          }
                        });
                      },
                    );
                  },
                  itemCount: int.parse(input),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    _controllers.add(new TextEditingController());
                    return new TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      readOnly: true,
                    );
                  },
                  itemCount: int.parse(input),
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
        onPressed: (){

          for(var i = 0; i < int.parse(input); i++){
            sumKumulatif = sumKumulatif + double.parse(_controllers[i].text);
            kumulatif.add(double.parse((sumKumulatif).toStringAsFixed(3)));
          }

          _batasBawah.add(0);
          for(var i = 0; i < int.parse(input); i++){
            _batasBawah.add(double.parse((kumulatif[i] + 0.01).toStringAsFixed(3)));
          }

          var route = new MaterialPageRoute(
            builder: (BuildContext context) => Hasil(
              controllers: _controllers,
              frekController: _frekController,
              jmlData: int.parse(input),
              kumulatif: kumulatif,
              batasBawah: _batasBawah,
              frekuensi: frekuensi,
              jmlLaptop: _jmlLaptop,
            ),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
  }
}
