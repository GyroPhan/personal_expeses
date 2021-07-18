import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:personal_expenses/constant.dart';

import '../../line_chart/chart_point.dart';
import './label_widget.dart';

class LineChartCustom extends StatefulWidget {
  double totalInCome;
  double totalSpend;
  var chartIncomeShow;
  var chartSpendShow;
  LineChartCustom(
      {this.totalSpend,
      this.totalInCome,
      this.chartIncomeShow,
      this.chartSpendShow});
  @override
  _LineChartCustomState createState() => _LineChartCustomState();
}

class _LineChartCustomState extends State<LineChartCustom> {
  bool isShowingMainData;
  String amountTextFeild;
  String monthTextFeild;
  List<LineChartBarData> linesBarData1;
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [Color(0xff2c274c), kMainColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            width: 380,
                            child: LineChart(chartPoint(widget.chartIncomeShow,
                                widget.chartSpendShow))),
                        SizedBox(
                          width: 10,
                        ),
                        LabelCustom(
                          inComeText: widget.totalInCome,
                          spendText: widget.totalSpend,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
