import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/data/data_couple.dart';
import 'package:personal_expenses/data/data_personal.dart';
import '../data/chart_line.dart';

LineChartData chartPoint(inComeShow, spendShow) {
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
      touchCallback: (LineTouchResponse touchResponse) {
        print('touch');
      },
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: false, //dong ke
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        margin: 15,
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            case 4:
              return '4';
            case 5:
              return '5';
            case 6:
              return '6';
            case 7:
              return '7';
            case 8:
              return '8';
            case 9:
              return '9';
            case 10:
              return '0';
            case 11:
              return '1';
            case 12:
              return '2';
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0m';
            case 1:
              return '2.5m';
            case 2:
              return '5m';
            case 3:
              return '7.5m';
            case 4:
              return '10m';
          }
          return '';
        },
        margin: 8,
        reservedSize: 45,
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(
          color: Color(0xff4e4965),
          width: 4,
        ),
        left: BorderSide(
          color: Colors.transparent,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    minX: 1,
    maxX: 12,
    maxY: 5,
    minY: 0,
    lineBarsData:
        linesBarInComeData(inComeData: inComeShow, spendData: spendShow),
  );
}
