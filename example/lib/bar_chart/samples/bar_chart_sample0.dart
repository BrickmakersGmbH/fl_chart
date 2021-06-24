import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample0 extends StatefulWidget {
  final bool showTitles;
  final List<double> values;
  final List<String>? bottomTitles;
  final Function(int index)? bottomTitleFn;
  final String chartDescription;
  final double height;
  final TextStyle titleDataTextStyle;
  final TextStyle tooltipTextStyle;
  final Color gridLineColor;
  final Color barColor;
  final int initialBarIndex;
  final double? paddingBetweenBars;
  final String Function(num value) barTouchTooltipTextFn;

  BarChartSample0({
    required this.values,
    required this.titleDataTextStyle,
    required this.gridLineColor,
    required this.barColor,
    required this.initialBarIndex,
    required this.barTouchTooltipTextFn,
    required this.tooltipTextStyle,
    required this.chartDescription,
    this.showTitles = true,
    this.bottomTitles,
    this.bottomTitleFn,
    this.paddingBetweenBars,
    double? height,
  }) : height = height ?? 113;

  @override
  _BarChartSample0State createState() => _BarChartSample0State();
}

class _BarChartSample0State extends State<BarChartSample0> {
  late int touchedIndex;

  @override
  void initState() {
    super.initState();
    touchedIndex = widget.initialBarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxValue = widget.values.reduce(max);

        final barWidth = widget.paddingBetweenBars != null
            ? constraints.maxWidth / widget.values.length - (widget.paddingBetweenBars! * 2)
            : constraints.maxWidth / widget.values.length - (35.0 / widget.values.length);

        final groups = <BarChartGroupData>[];
        for (var i = 0; i < widget.values.length; i++) {
          var data = BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                y: widget.values[i],
                width: barWidth,
                colors: i == touchedIndex
                    ? [Color.fromRGBO(116, 184, 65, 1)]
                    : [Color.fromRGBO(183, 183, 183, 1)],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                ),
              )
            ],
          );
          groups.add(data);
        }
        return Container(
          width: double.infinity,
          height: widget.height,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              alignment: BarChartAlignment.spaceEvenly,
              barGroups: groups,
              maxY: maxValue + 1,
              titlesData: FlTitlesData(
                leftTitles: SideTitles(
                  showTitles: widget.showTitles,
                  interval: maxValue,
                  getTextStyles: (value) => widget.titleDataTextStyle,
                  getTitles: (value) => value.toStringAsFixed(0),
                  showTicksOnBorder: true,
                  showTicksBorder: true,
                ),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => widget.titleDataTextStyle,
                  interval: widget.showTitles ? null : 4,
                  intervalOffset: widget.showTitles ? null : 1,
                  getTitles: (value) =>
                      widget.bottomTitles?[value.toInt()] ??
                      (widget.bottomTitleFn != null
                          ? widget.bottomTitleFn!(value.toInt())
                          : '$value'),
                  showTicksOnBorder: true,
                  showTicksBorder: true,
                ),
              ),
              barTouchData: BarTouchData(
                  enabled: true,
                  defaultTooltipOn: {
                    1: [0],
                  },
                  autoHideTooltip: false,
                  touchTooltipData: BarTouchTooltipData(
                    style: TooltipStyle.dotWithLine,
                    fitInsideHorizontally: false,
                    fitInsideVertically: false,
                    tooltipBgColor: Color.fromRGBO(116, 184, 65, 1),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        widget.barTouchTooltipTextFn(widget.values[groupIndex]),
                        widget.tooltipTextStyle,
                      );
                    },
                  ),
                  touchCallback: (barTouchResponse) {
                    if (barTouchResponse.spot != null) {
                      setState(() {
                        touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                      });
                    }
                  }),
              gridData: FlGridData(
                horizontalInterval: maxValue,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: widget.gridLineColor,
                  strokeWidth: 1,
                  dashArray: [6, 6],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
