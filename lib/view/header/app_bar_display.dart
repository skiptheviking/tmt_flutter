import 'package:flutter/material.dart';
import 'package:tmt_flutter/model/goal.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tmt_flutter/calc/goal_calculator.dart';

enum MetricType {
TIME, MONEY, TASKS
}

class AppBarDisplay extends StatelessWidget {
  const AppBarDisplay({
    Key? key,
    required this.context,
    required this.goal,
  }) : super(key: key);

  final BuildContext context;
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return buildAppBarDashBoard(context);
  }

  DefaultTextStyle buildAppBarDashBoard(BuildContext context) {
    // https://docs.getwidget.dev/gf-progress-bar/
    return DefaultTextStyle(
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: 15
      ),
      child: Padding(
        padding: EdgeInsets.all(6),
          child:
                Column(
                  children: [
                    Text("Time"),
                    buildGfProgressBar(goal, MetricType.TIME),
                    Text("Cost"),
                    buildGfProgressBar(goal, MetricType.MONEY),
                    Text("Tasks"),
                    buildGfProgressBar(goal, MetricType.TASKS)
                ]),
        )
      );
  }

  GFProgressBar buildGfProgressBar(Goal goal, MetricType metricType) {
    double percentageComplete;
    String displayText;
    Color progressColor;
    GC gc = GoalCalc(goal);
    switch(metricType) {
      case MetricType.TIME: {
        percentageComplete = gc.getTimePercentageComplete();
        progressColor = GFColors.INFO;
        displayText = gc.getTimeCompletedProgressText();
      }
      break;
      case MetricType.MONEY: {
        progressColor = Theme.of(context).colorScheme.primaryVariant;
        percentageComplete = gc.getCostPercentageComplete();
        displayText = gc.getMoneyCompletedProgressText();
        if (displayText == "No Cost") {
          displayText = "N/A";
          progressColor = Colors.black;
        }

      }
      break;
      case MetricType.TASKS: {
        percentageComplete = gc.getTasksPercentageComplete();
        progressColor = Theme.of(context).colorScheme.onSurface;
        displayText = gc.getLeafsCompletedProgressText();
      }
    }
    return GFProgressBar(
      percentage: percentageComplete,
      lineHeight: 20,
      alignment: MainAxisAlignment.spaceBetween,
      child: Text(displayText, textAlign: TextAlign.end,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.black26,
      progressBarColor: progressColor,
    );
  }
}