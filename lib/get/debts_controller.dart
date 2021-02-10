import 'package:billy/models/debt.dart';
import 'package:billy/services/dbProvider.dart';
import "package:get/get.dart";

class DebtsController extends GetxController {
  // Controller access point
  static DebtsController get to => Get.find();

  // Properties
  var debts = List<Debt>.empty(growable: true).obs;
  var balance = 0.obs;

  // BLoC
  void load() async {
    List<Debt> x = await DebtDBProvider.db.getAllDebts();
    debts.clear();
    debts.addAll(x);
    refreshBalance();
  }

  void refreshBalance() {
    int step = 0;
    for (var debt in debts) {
      step += debt.value;
    }
    //  ¯\_(ツ)_/¯
    balance += -balance;
    balance += step;
  }

  Future<void> create(Debt newDebt) async {
    var res = await DebtDBProvider.db.newDebt(newDebt);
    debts.add(res);
    balance += res.value;
  }

  Future<bool> delete(Debt debt) async {
    bool res = await DebtDBProvider.db.deleteDebt(debt.id);
    int index = debts.indexOf(debt);
    debts.removeAt(index);
    balance -= debt.value;
    return res;
  }
}
