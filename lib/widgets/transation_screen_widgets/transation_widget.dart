import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';

class TransationListTitle extends StatelessWidget {
  var f = NumberFormat.currency(locale: 'vi', symbol: '');
  String titleTransation;
  bool isSpend;
  double amountTransation;
  DateTime dateTransation;
  Function deleteOnTap;
  TransationListTitle(
      {this.titleTransation,
      this.isSpend,
      this.amountTransation,
      this.dateTransation,
      this.deleteOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 10,
        shadowColor: kMainColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                child: Text(
                  '${f.format(amountTransation)}k',
                  style: TextStyle(
                      color: isSpend == true ? kSpendColor : kInComeColor),
                ),
                height: 50,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                      width: 2,
                      color: isSpend == true ? kSpendColor : kInComeColor),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleTransation,
                      style: kTitleTextStyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (DateFormat().format(dateTransation)),
                      style: kSubTextStyle,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: deleteOnTap,
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
