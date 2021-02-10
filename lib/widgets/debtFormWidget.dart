import 'package:billy/get/debts_controller.dart';
import 'package:billy/models/debt.dart';
import 'package:billy/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DebtFormWidget extends StatefulWidget {
  @override
  _DebtFormWidgetState createState() => _DebtFormWidgetState();
}

class _DebtFormWidgetState extends State<DebtFormWidget> {
  final _newDebtFormKey = GlobalKey<FormState>();
  final inpTitle = TextEditingController();
  final inpTarget = TextEditingController();
  final inpValue = TextEditingController();
  bool inpTargetMe = false;

  String validateTextInput(String value) {
    if (value.isEmpty) return "Vyplňte toto pole";
    return null;
  }

  String validateMoneyInput(String value) {
    if (value.isEmpty)
      return "Vyplňte toto pole";
    else if (int.tryParse(value) == null) return "Zadejte pouze celé číslo";
    return null;
  }

  @override
  void dispose() {
    inpTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _newDebtFormKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 3),
            child: TextFormField(
              controller: inpTitle,
              validator: (value) => validateTextInput(value),
              decoration: InputDecoration(
                labelText: 'Název',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: inpTarget,
              validator: (value) => validateTextInput(value),
              decoration: InputDecoration(
                labelText: 'Komu',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: inpValue,
              validator: (value) => validateMoneyInput(value),
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              decoration: InputDecoration(
                suffix: Text("Kč"),
                labelText: 'Částka',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Checkbox(
                  value: inpTargetMe,
                  onChanged: (val) {
                    setState(() {
                      inpTargetMe = !inpTargetMe;
                    });
                  },
                ),
                Text(
                  "JÁ jsem dlužník",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text("Přidat"),
            onPressed: () async {
              if (_newDebtFormKey.currentState.validate()) {
                Debt _new = new Debt(
                  id: 0,
                  title: inpTitle.text,
                  detail: "",
                  value: (inpTargetMe)
                      ? int.parse(inpValue.text) * -1
                      : int.parse(inpValue.text),
                  target: inpTarget.text,
                  dateCreated: DateTime.now().toString(),
                );
                await DebtsController.to.create(_new);
                _newDebtFormKey.currentState.reset();
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }
}
