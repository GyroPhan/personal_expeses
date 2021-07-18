import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:personal_expenses/data/chart_line.dart';
import '../models/transation.dart';
import '../data/data_personal.dart';

import '../widgets/transation_screen_widgets/transation_widget.dart';
import '../widgets/transation_screen_widgets/add_widget.dart';
import '../widgets/show_alert.dart';
import '../widgets/drawer_custom.dart';
import '../widgets/couple_widget/line_chart.dart';

class PersonalScreen extends StatefulWidget {
  static String id = 'personal_screen';
  @override
  _PersonalScreenState createState() => new _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final LocalStorage storage = LocalStorage('personal_expenses');
  bool initialized = false;

  List<Transation> personalList = [];

  String titleTransTextField;
  String amountTransTextField;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool isSpend = false;

  DateTime selectedDate = DateTime.now();

  double totalInCome = 0.0;
  double totalSpend = 0.0;

////////////////////////////////////////////////////////////////////////////////////////////////////

  _save() {
    if (amountTransTextField.isEmpty || titleTransTextField.isEmpty) {
      print('fuck');
      showAlertDialog(context);
    } else {
      setState(() {
        Transation newTransation;

        if (isSpend == true) {
          newTransation = Transation(
            idTransation: DateTime.now().millisecondsSinceEpoch,
            titleTransation: titleTransTextField,
            amountTransation: double.parse(amountTransTextField),
            isSpend: true,
            dateTransation: selectedDate,
          );

          spendPersonalData.add(FlSpot(
              double.parse(selectedDate.month.toString()),
              double.parse(amountTransTextField) * 4 / 10));
          totalSpend += double.parse(amountTransTextField);
          spendPersonalData.sort((a, b) {
            return (a.x.toInt() - b.x.toInt());
          });
        } else {
          newTransation = Transation(
            idTransation: DateTime.now().millisecondsSinceEpoch,
            titleTransation: titleTransTextField,
            amountTransation: double.parse(amountTransTextField),
            isSpend: false,
            dateTransation: selectedDate,
          );

          inComePersonalData.add(FlSpot(
              double.parse(selectedDate.month.toString()),
              double.parse(amountTransTextField) * 4 / 10));
          totalInCome += double.parse(amountTransTextField);

          inComePersonalData.sort((a, b) {
            return (a.x.toInt() - b.x.toInt());
          });
        }

        personalList.add(newTransation);
        titleTransTextField = null;
        amountTransTextField = null;
        titleController.clear();
        amountController.clear();

        _saveToStorage();
      });
    }
    Navigator.pop(context);
  }

  _saveToStorage() {
    storage.setItem('personal', jsonEncode(personalList));
  }

  _delete(index) {
    setState(() {
      if (personalList[index].isSpend == false) {
        print(false);
        inComePersonalData.removeWhere((i) =>
            i.x ==
            double.parse(personalList[index].dateTransation.month.toString()));
      } else {
        print(true);
        spendPersonalData.removeWhere((i) =>
            i.x ==
            double.parse(personalList[index].dateTransation.month.toString()));
      }

      personalList.removeWhere(
          (i) => i.idTransation == personalList[index].idTransation);

      _saveToStorage();
    });
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      personalList = storage.getItem('personal') ?? [];
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 730)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
/////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 35,
            ),
            onPressed: () {
//              _clearStorage();
              print('inCome: ${inComePersonalData}');
              print('spend: ${spendPersonalData}');
            },
            tooltip: 'Clear storage',
          )
        ],
        title: Center(child: Text('Personal Expenses')),
      ),
      drawer: DrawerCustom(),
      floatingActionButton: AddWidget(
        titleController: titleController,
        amountController: amountController,
        selectedDate: selectedDate,
        titleOnChanged: (val) {
          titleTransTextField = val;
        },
        amountOnChanged: (val) {
          amountTransTextField = val;
        },
        dayPickOnTap: () => _selectDate(context),
        isSpend: isSpend,
        switchOnChanged: (value) {
          setState(() {
            isSpend = value;
          });
        },
        saveOnPressed: () {
          _save();
        },
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(),
          child: FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!initialized) {
                var items = storage.getItem('personal');
                if (items != null) {
                  var deco = jsonDecode(items);
                  personalList = List<Transation>.from(
                    (deco as List).map(
                      (item) => Transation(
                        idTransation: item['idTransation'],
                        titleTransation: item['titleTransation'],
                        dateTransation: DateTime.parse(item['dateTransation']),
                        amountTransation: item['amountTransation'],
                        isSpend: item['isSpend'],
                      ),
                    ),
                  );
                  for (int i = 0; i <= personalList.length - 1; i++) {
                    if (personalList[i].isSpend == false) {
                      inComePersonalData.add(FlSpot(
                          double.parse(
                              personalList[i].dateTransation.month.toString()),
                          double.parse(
                              (personalList[i].amountTransation * 4 / 10)
                                  .toString())));
                      totalInCome += personalList[i].amountTransation;
                      inComePersonalData.sort((a, b) {
                        return (a.x.toInt() - b.x.toInt());
                      });
                    } else {
                      spendPersonalData.add(FlSpot(
                          double.parse(
                              personalList[i].dateTransation.month.toString()),
                          double.parse(
                              (personalList[i].amountTransation * 4 / 10)
                                  .toString())));
                      totalSpend += personalList[i].amountTransation;
                      spendPersonalData.sort((a, b) {
                        return (a.x.toInt() - b.x.toInt());
                      });
                    }
                  }
                }

                initialized = true;
              }

              return Column(
                children: <Widget>[
                  LineChartCustom(
                    totalInCome: totalInCome,
                    totalSpend: totalSpend,
                    chartIncomeShow: inComePersonalData,
                    chartSpendShow: spendPersonalData,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: personalList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransationListTitle(
                            isSpend: personalList[index].isSpend,
                            amountTransation:
                                personalList[index].amountTransation,
                            titleTransation:
                                personalList[index].titleTransation,
                            dateTransation: personalList[index].dateTransation,
                            deleteOnTap: () {
                              _delete(index);
                            },
                          );
                        }),
                  ),
                ],
              );
            },
          )),
    );
  }
}
