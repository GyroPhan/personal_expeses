import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<LineChartBarData> linesBarInComeData({inComeData, spendData}) {
  final inComeLine = LineChartBarData(
    spots: inComeData,
    isCurved: true,
    colors: [const Color(0xff4af699), Colors.white, Colors.redAccent],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(
      show: false,
    ),
  );

  final spendLine = LineChartBarData(
    spots: spendData,
    isCurved: true,
    colors: [
      const Color(0xffaa4cfc),
    ],
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
    belowBarData: BarAreaData(show: false, colors: [
      const Color(0x00aa4cfc),
    ]),
  );

  return [
    inComeLine,
    spendLine,
  ];
}
