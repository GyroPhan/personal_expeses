import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:custom_switch/custom_switch.dart';
import '../../constant.dart';
import '../show_alert.dart';

class AddWidget extends StatefulWidget {
  TextEditingController titleController;
  TextEditingController amountController;
  DateTime selectedDate;
  bool isSpend;
  List<DropdownMenuItem> itemList;
  String dropdownValue;
  Function titleOnChanged;
  Function amountOnChanged;
  Function saveOnPressed;
  Function dayPickOnTap;
  Function switchOnChanged;
  Function onChangedDropdow;
  AddWidget(
      {this.titleController,
      this.amountController,
      this.selectedDate,
      this.isSpend,
      this.dropdownValue,
      this.titleOnChanged,
      this.saveOnPressed,
      this.amountOnChanged,
      this.dayPickOnTap,
      this.switchOnChanged,
      this.itemList,
      this.onChangedDropdow});

  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kMainColor,
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            margin: EdgeInsets.only(left: 15),
            child: Container(
              height: 240,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          controller: widget.titleController,
                          autofocus: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_balance_wallet_outlined),
                            hintText: 'What does transation ?',
                            labelText: 'Transation',
                          ),
                          onChanged: widget.titleOnChanged,
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: widget.amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(Icons.attach_money),
                            hintText: 'Amount',
                            labelText: 'Amount',
                          ),
                          onChanged: widget.amountOnChanged,
                        ),
                      ),
                      Row(
                        children: [
                          CustomSwitch(
                            activeColor: Colors.pinkAccent,
                            value: widget.isSpend,
                            onChanged: widget.switchOnChanged,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          DropdownButton<String>(
                            value: widget.dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: widget.onChangedDropdow,
                            items: widget.itemList,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Day : ${DateFormat("dd/MM/yyyy").format(widget.selectedDate)}',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: widget.dayPickOnTap,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontSize: 17, color: kMainColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      size: 30,
                      color: kMainColor,
                    ),
                    onPressed: widget.saveOnPressed,
                    tooltip: 'Save',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
