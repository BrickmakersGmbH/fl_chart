import 'package:example/bar_chart/samples/bar_chart_sample0.dart';
import 'package:flutter/material.dart';

class BarChartPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 50, 28, 0),
          child: BarChartSample0(
            values: [
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60,
              120,
              20,
              60
            ],
            titleDataTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.4,
              fontFamily: 'Ubuntu',
            ),
            tooltipTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.4,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),
            // paddingBetweenBars: 2,
            gridLineColor: Colors.blueAccent,
            barColor: Colors.amber,
            initialBarIndex: 1,
            barTouchTooltipTextFn: (value) => 'ø $value Parkplätze frei',
            chartDescription: 'This is a chart!',
          ),
        ),
      ),
    );
  }
}
