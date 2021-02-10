import 'dart:async';

import 'package:billy/models/debt.dart';
import 'package:billy/services/dbProvider.dart';
import 'package:flutter/widgets.dart';

enum DebtAction {
  Load,
  Create,
  Delete,
}

class DebtsBloc {
  List<Debt> _debts = new List();
  get debts => _debtsController.stream;

  final _debtsController = StreamController<List<Debt>>.broadcast();
  Stream<List<Debt>> get debtsStream => _debtsController.stream;
  final _eventStreamController = StreamController<DebtAction>();
  StreamSink<DebtAction> get eventSink => _eventStreamController.sink;
  Stream<DebtAction> get _eventStream => _eventStreamController.stream;

  DebtsBloc() {
    WidgetsFlutterBinding.ensureInitialized();

    _eventStream.listen((event) async {
      if (event == DebtAction.Load) {
        _debts = await loadDebts();
        _debtsController.sink.add(_debts);
      }
    });
  }

  loadDebts() async {
    List<Debt> res = await DebtDBProvider.db.getAllDebts();
    _debtsController.sink.add(res);
    print("LOADING DEBTS: " + res.toString());
  }

  createDebt() async {
    Debt req = new Debt(
      id: 0,
      title: "Test TITLE",
      detail: "Test DETAL...",
      target: "Test TARGET",
      value: 200,
      dateCreated: DateTime.now().toString(),
    );
    await DebtDBProvider.db.newDebt(req);
    await loadDebts();
  }

  dispose() {
    _debtsController.close();
    _eventStreamController.close();
  }
}
