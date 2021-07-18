import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:personal_expenses/screens/budget_add_screen.dart';

import '../models/transation.dart';
import '../data/data_transation.dart';
import '../widgets/transation_screen_widgets/transation_widget.dart';
import '../widgets/transation_screen_widgets/add_widget.dart';
import '../widgets/transation_screen_widgets/chart.dart';
import '../widgets/transation_screen_widgets/circle_chart.dart';
import '../widgets/show_alert.dart';
import '../widgets/drawer_custom.dart';
import '../constant.dart';

class TransationScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _TransationScreenState createState() => new _TransationScreenState();
}

class _TransationScreenState extends State<TransationScreen> {
  final LocalStorage storage = LocalStorage('personal_expenses');
  bool initialized = false;

  List<Transation> transationList = [];

  String titleTransTextField;
  String amountTransTextField;
  String weekBudget = '500';
  String monthBudget = '2500';
  double weekTotalSpend = 0.0;
  double monthTotalSpend = 0.0;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String dropdownValue = 'Week';
  bool isSpend = false;
  List<Transation> get _recentTransations {
    return transationList.where((tx) {
      return tx.dateTransation
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  DateTime selectedDate = DateTime.now();

  bool haha = false;
////////////////////////////////////////////////////////////////////////////////////////////////////
  //-----------------Saving Func------------------------
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
            type: dropdownValue,
          );
        } else {
          newTransation = Transation(
            idTransation: DateTime.now().millisecondsSinceEpoch,
            titleTransation: titleTransTextField,
            amountTransation: double.parse(amountTransTextField),
            isSpend: false,
            dateTransation: selectedDate,
            type: dropdownValue,
          );
        }
        transationList.add(newTransation);
        titleTransTextField = null;
        amountTransTextField = null;
        titleController.clear();
        amountController.clear();
        _saveToStorage();
      });
    }
    getWeekTotalSpend();
    getMonthTotalSpend();
    Navigator.pop(context);
  }

  _saveToStorage() {
    storage.setItem('transation', jsonEncode(transationList));
  }

  _delete(index) {
    setState(() {
      transationList.removeWhere(
          (i) => i.idTransation == transationList[index].idTransation);
      _saveToStorage();
    });
    getWeekTotalSpend();
    getMonthTotalSpend();
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      transationList = storage.getItem('transation') ?? [];
    });
  }

  //-----------------Selectday Func------------------------
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

  //-----------------Percent Func------------------------
  getWeekTotalSpend() {
    weekTotalSpend = 0.0;
    for (int i = 0; i < transationList.length; i++) {
      if (transationList[i].isSpend == true &&
          transationList[i].type.toString() == 'Week') {
        weekTotalSpend += transationList[i].amountTransation;
      }
    }
    return weekTotalSpend;
  }

  getMonthTotalSpend() {
    monthTotalSpend = 0.0;
    for (int i = 0; i < transationList.length; i++) {
      if (transationList[i].isSpend == true &&
          transationList[i].type.toString() == 'Month') {
        monthTotalSpend += transationList[i].amountTransation;
      }
    }
    return monthTotalSpend;
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
        title: Center(child: Text('Personal Expenses')),
      ),
      drawer: DrawerCustom(),
      floatingActionButton: AddWidget(
        //--------------------------------------------
        titleController: titleController,
        amountController: amountController,
        selectedDate: selectedDate,
        titleOnChanged: (val) {
          titleTransTextField = val;
        },
        amountOnChanged: (val) {
          amountTransTextField = val;
        },
        //--------------------------------------------
        dayPickOnTap: () => _selectDate(context),
        //--------------------------------------------
        isSpend: isSpend,
        switchOnChanged: (value) {
          setState(() {
            isSpend = value;
          });
        },
        //--------------------------------------------
        saveOnPressed: () {
          _save();
        },
        //--------------------------------------------
        dropdownValue: dropdownValue,
        itemList: <String>[
          'Week',
          'Month',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChangedDropdow: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        //--------------------------------------------
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
                var items = storage.getItem('transation');
                if (items != null) {
                  var deco = jsonDecode(items);
                  transationList = List<Transation>.from(
                    (deco as List).map(
                      (item) => Transation(
                        idTransation: item['idTransation'],
                        titleTransation: item['titleTransation'],
                        dateTransation: DateTime.parse(item['dateTransation']),
                        amountTransation: item['amountTransation'],
                        isSpend: item['isSpend'],
                        type: item['type'],
                      ),
                    ),
                  );
                  getWeekTotalSpend();
                  getMonthTotalSpend();
                }
                initialized = true;
              }

              return Column(
                children: <Widget>[
                  Container(
                    height: 165,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff2c274c), kMainColor],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Chart(
                          recentTransation: _recentTransations,
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        CircleChart(
                          weekPercent:
                              weekTotalSpend / double.parse(weekBudget) * 100,
                          monthPercent:
                              monthTotalSpend / double.parse(monthBudget) * 100,
                          totalPercent: ((weekTotalSpend + monthTotalSpend) /
                              (double.parse(weekBudget) +
                                  double.parse(monthBudget)) *
                              100),
                        ),
                      ],
                    ),
                  ),
                  ExpansionPanelList(
                    dividerColor: kMainColor,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        haha = !haha;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: Color(0xff2c274c),
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Column(
                            children: [
                              Text(
                                'Budget  ',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'w: ${weekBudget}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    'm: ${monthBudget}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        body: BudgetAddScreen(
                          onChangedWeek: (value) {
                            weekBudget = value;
                          },
                          onChangedMonth: (value) {
                            monthBudget = value;
                          },
                          iconOnPressed: () {
                            setState(() {
                              haha = !haha;
                            });
                          },
                        ),
                        isExpanded: haha,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: transationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransationListTitle(
                            isSpend: transationList[index].isSpend,
                            amountTransation:
                                transationList[index].amountTransation,
                            titleTransation:
                                transationList[index].titleTransation,
                            dateTransation:
                                transationList[index].dateTransation,
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
