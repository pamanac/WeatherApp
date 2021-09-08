import 'package:flutter/material.dart';
import 'package:tutorial_app/shared/menu_bottom.dart';
import 'package:tutorial_app/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final double fontSize = 18.0;
  late List<bool> isSelected;
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  String heightMessage = '';
  String weightMessage = '';
  double? height;
  double? weight;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage = 'Insert height in ' + (isMetric ? 'meters' : 'inches');
    weightMessage = 'Insert weight in ' + (isMetric ? 'kilos' : 'pounds');
    return Scaffold(
        appBar: AppBar(title: Text("BMI Calculator")),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: Column(
          children: [
            ToggleButtons(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Metric", style: TextStyle(fontSize: fontSize))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Imperial", style: TextStyle(fontSize: fontSize)))
            ], isSelected: isSelected, onPressed: toggleMeasure),
            TextField(
              controller: txtHeight,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: heightMessage),
            ),
            TextField(
                controller: txtWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: weightMessage)),
            ElevatedButton(
                onPressed: () {
                  double bmi = double.parse(txtHeight.text) *
                      double.parse(txtWeight.text);

                  setState(() {
                    result = bmi.toString();
                  });
                },
                child: Text("Calculate", style: TextStyle(fontSize: fontSize))),
            Text((result == '' ? '' : 'Your BMI is $result'),
                style: TextStyle(fontSize: fontSize)),
          ],
        ));
  }

  void toggleMeasure(index) {
    switch (index) {
      case 0:
        isMetric = true;
        isImperial = false;
        break;
      case 1:
        isMetric = false;
        isImperial = true;
        break;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }
}
