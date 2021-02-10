import 'package:billy/widgets/debtFormWidget.dart';
import 'package:flutter/material.dart';

class CreateDebtScreen extends StatefulWidget {
  @override
  _CreateDebtScreenState createState() => _CreateDebtScreenState();
}

class _CreateDebtScreenState extends State<CreateDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nový dluh"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(25),
        child: ListView(
          children: [
            DebtFormWidget(),
          ],
        ),
      ),
    );
  }
}
