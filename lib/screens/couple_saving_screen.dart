import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import '../data/data_couple.dart';
import '../models/transation.dart';

import '../widgets/transation_screen_widgets/transation_widget.dart';
import '../widgets/transation_screen_widgets/add_widget.dart';
import '../widgets/show_alert.dart';
import '../widgets/drawer_custom.dart';
import '../widgets/couple_widget/line_chart.dart';

class CoupleSavingScreen extends StatefulWidget {
  static String id = 'couple_screen';
  @override
  _CoupleSavingScreenState createState() => new _CoupleSavingScreenState();
}

class _CoupleSavingScreenState extends State<CoupleSavingScreen> {
  final LocalStorage storage = LocalStorage('personal_expenses');
  bool initialized = false;

  List<Transation> coupleList = [];

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

          spendCoupleData.add(FlSpot(
              double.parse(selectedDate.month.toString()),
              double.parse(amountTransTextField) * 4 / 10));
          totalSpend += double.parse(amountTransTextField);
          spendCoupleData.sort((a, b) {
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

          inComeCoupleData.add(FlSpot(
              double.parse(selectedDate.month.toString()),
              double.parse(amountTransTextField) * 4 / 10));
          totalInCome += double.parse(amountTransTextField);

          inComeCoupleData.sort((a, b) {
            return (a.x.toInt() - b.x.toInt());
          });
        }

        coupleList.add(newTransation);
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
    storage.setItem('couple', jsonEncode(coupleList));
  }

  _delete(index) {
    setState(() {
      if (coupleList[index].isSpend == false) {
        print(false);
        inComeCoupleData.removeWhere((i) =>
            i.x ==
            double.parse(coupleList[index].dateTransation.month.toString()));
      } else {
        print(true);
        spendCoupleData.removeWhere((i) =>
            i.x ==
            double.parse(coupleList[index].dateTransation.month.toString()));
      }
      coupleList
          .removeWhere((i) => i.idTransation == coupleList[index].idTransation);

      _saveToStorage();
    });
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      coupleList = storage.getItem('couple') ?? [];
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
              _clearStorage();
            },
            tooltip: 'Clear storage',
          )
        ],
        title: Center(child: Text('Couple Expenses')),
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
                var items = storage.getItem('couple');
                if (items != null) {
                  var deco = jsonDecode(items);
                  coupleList = List<Transation>.from(
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

                  for (int i = 0; i <= coupleList.length - 1; i++) {
                    if (coupleList[i].isSpend == false) {
                      inComeCoupleData.add(FlSpot(
                          double.parse(
                              coupleList[i].dateTransation.month.toString()),
                          double.parse((coupleList[i].amountTransation * 4 / 10)
                              .toString())));
                      totalInCome += coupleList[i].amountTransation;
                      inComeCoupleData.sort((a, b) {
                        return (a.x.toInt() - b.x.toInt());
                      });
                    } else {
                      spendCoupleData.add(FlSpot(
                          double.parse(
                              coupleList[i].dateTransation.month.toString()),
                          double.parse((coupleList[i].amountTransation * 4 / 10)
                              .toString())));
                      totalSpend += coupleList[i].amountTransation;
                      spendCoupleData.sort((a, b) {
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
                    chartIncomeShow: inComeCoupleData,
                    chartSpendShow: spendCoupleData,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: coupleList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransationListTitle(
                            isSpend: coupleList[index].isSpend,
                            amountTransation:
                                coupleList[index].amountTransation,
                            titleTransation: coupleList[index].titleTransation,
                            dateTransation: coupleList[index].dateTransation,
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
