import 'package:billy/get/debts_controller.dart';
import 'package:billy/models/debt.dart';
import 'package:get/get.dart';
import 'package:billy/screens/createDebtScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    DebtsController.to.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Domů"),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20, top: 5),
              child: Obx(
                () => Text(
                  "${DebtsController.to.balance} Kč",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (DebtsController.to.debts.length != 0) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: DebtsController.to.debts.length,
                    // itemCount: 0,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          Debt target = DebtsController.to.debts[index];
                          bool dism = await DebtsController.to.delete(target);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text((dism)
                                  ? "Odstraněno: ${target.title}"
                                  : "Někde se stala chyba..."),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            trailing: Text(
                              "${DebtsController.to.debts[index].value} Kč",
                              style: TextStyle(
                                color:
                                    (DebtsController.to.debts[index].value > 0)
                                        ? Colors.green
                                        : Colors.red,
                                fontSize: 18,
                              ),
                            ),
                            title: Text(
                                "${DebtsController.to.debts[index].title}"),
                            subtitle:
                                Text(DebtsController.to.debts[index].target),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(height: 0, width: 0);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDebtScreen()),
          );
        },
      ),
    );
  }
}
