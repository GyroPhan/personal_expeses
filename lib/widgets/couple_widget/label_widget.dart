import 'package:flutter/material.dart';
import '../../constant.dart';

class LabelCustom extends StatelessWidget {
  double inComeText;
  double spendText;

  LabelCustom({
    this.inComeText,
    this.spendText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 20),
      width: 390,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Money',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 20,
                  color: kInComeColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'In Come',
                  style: TextStyle(
                      color: kInComeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ],
            ),
            trailing: Text(
              '${inComeText.toString()} m',
              style: TextStyle(
                  color: kInComeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.clear,
                  size: 20,
                  color: kSpendColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Spend',
                  style: TextStyle(
                      color: kSpendColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ],
            ),
            trailing: Text(
              '${spendText.toString()} m',
              style: TextStyle(
                  color: kSpendColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
          Container(
            height: 2,
            width: 330,
            color: Colors.grey,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.done,
                  size: 20,
                  color: Colors.lightGreen,
                ),
                SizedBox(
                  width: 7,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ],
            ),
            trailing: Text(
              '${(inComeText - spendText).toString()} m',
              style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
