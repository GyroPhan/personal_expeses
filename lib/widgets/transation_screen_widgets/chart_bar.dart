import 'package:flutter/material.dart';

import '../../constant.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentTotal;
  final double inComeAmount;
  final double inComePercentTotal;
  ChartBar(
      {this.label,
      this.spendingAmount,
      this.spendingPercentTotal,
      this.inComeAmount,
      this.inComePercentTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text(
              '${(inComeAmount - spendingAmount).toStringAsFixed(0)}k',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ))),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 7,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: inComePercentTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kInComeColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              height: 70,
              width: 7,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kSpendColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}
