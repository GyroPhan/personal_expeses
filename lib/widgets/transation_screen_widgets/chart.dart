import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/constant.dart';
import 'package:personal_expenses/models/transation.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transation> recentTransation;
  Chart({this.recentTransation});

  List<Map<String, Object>> get groupTransationValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSpendSum = 0.0;
      var totalInComeSum = 0.0;
      for (int i = 0; i < recentTransation.length; i++) {
        if (recentTransation[i].dateTransation.day == weekDay.day &&
            recentTransation[i].dateTransation.month == weekDay.month &&
            recentTransation[i].dateTransation.year == weekDay.year) {
          if (recentTransation[i].isSpend == true) {
            totalSpendSum += recentTransation[i].amountTransation;
          } else {
            totalInComeSum += recentTransation[i].amountTransation;
          }
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amountSpend': totalSpendSum,
        'amountInCome': totalInComeSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransationValue.fold(0.0, (sum, item) {
      return sum + item['amountSpend'];
    });
  }

  double get totalInCome {
    return groupTransationValue.fold(0.0, (sum, item) {
      return sum + item['amountInCome'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 360,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: groupTransationValue.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              label: data['day'],
              spendingAmount: data['amountSpend'],
              inComeAmount: data['amountInCome'],
              spendingPercentTotal: totalSpending == 0.0
                  ? 0.0
                  : (data['amountSpend'] as double) / totalSpending,
              inComePercentTotal: totalInCome == 0.0
                  ? 0.0
                  : (data['amountInCome'] as double) / totalInCome,
            ),
          );
        }).toList(),
      ),
    );
  }
}
