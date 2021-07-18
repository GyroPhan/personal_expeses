import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../screens/budget_add_screen.dart';

final TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 12,
    color: Colors.white);

class CircleChart extends StatefulWidget {
  double weekPercent;
  double monthPercent;
  double totalPercent;
  CircleChart({this.weekPercent, this.monthPercent, this.totalPercent});
  @override
  _CircleChartState createState() => _CircleChartState();
}

class _CircleChartState extends State<CircleChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: EdgeInsets.only(top: 5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularPercentIndicator(
            backgroundColor: Colors.transparent,
            radius: 80,
            lineWidth: 7,
            animation: true,
            animationDuration: 2500,
            percent: widget.weekPercent == null
                ? 1 - 0.0
                : 1 - widget.weekPercent / 100, // percent use
            animateFromLastPercent: true,
            center: Text(
              "${widget.weekPercent.toStringAsFixed(1)}%",
              style: textStyle,
            ),
            footer: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Spend\nWeek",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
//              progressColor: Colors.purple,
            widgetIndicator: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.airplanemode_active_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
            maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.yellow],
            ),
          ),
          CircularPercentIndicator(
            backgroundColor: Colors.transparent,
            radius: 80,
            lineWidth: 7,
            animation: true,
            animationDuration: 2500,
            percent: widget.monthPercent == null
                ? 1 - 0.0
                : 1 - widget.monthPercent / 100, // percent use
            animateFromLastPercent: true,
            center: Text(
              "${widget.monthPercent.toStringAsFixed(1)}%",
              style: textStyle,
            ),
            footer: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Spend\nMonth",
                style: textStyle,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
//              progressColor: Colors.purple,
            widgetIndicator: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.airplanemode_active_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
            maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFF416C), Color(0xffFF4B2B)],
            ),
          ),
          CircularPercentIndicator(
            backgroundColor: Colors.transparent,
            radius: 80,
            lineWidth: 7,
            animation: true,
            animationDuration: 2500,
            percent: widget.totalPercent == null
                ? 1 - 0.0
                : 1 - widget.totalPercent / 100, // percent use
            animateFromLastPercent: true,
            center: Text(
              "${widget.totalPercent.toStringAsFixed(1)}%",
              style: textStyle,
            ),
            footer: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Total",
                style: textStyle,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
//              progressColor: Colors.purple,
            widgetIndicator: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.airplanemode_active_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
            maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
            linearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff78ffd6), Color(0xffa8ff78)],
            ),
          ),
        ],
      ),
    );
  }
}
