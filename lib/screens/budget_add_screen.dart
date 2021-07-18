import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetAddScreen extends StatelessWidget {
  Function onChangedWeek;
  Function onChangedMonth;
  Function iconOnPressed;
  BudgetAddScreen(
      {this.onChangedMonth, this.onChangedWeek, this.iconOnPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Theme(
            data: new ThemeData(
              primaryColor: Colors.white,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: 120,
              child: TextField(
                onChanged: onChangedWeek,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Week Budget',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    hintText: 'x1000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Theme(
            data: new ThemeData(
              primaryColor: Colors.white,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: 120,
              child: TextField(
                onChanged: onChangedMonth,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Month Budget',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    hintText: 'x1000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.done_all_outlined,
                color: Colors.white,
              ),
              onPressed: iconOnPressed)
        ],
      ),
    );
  }
}
