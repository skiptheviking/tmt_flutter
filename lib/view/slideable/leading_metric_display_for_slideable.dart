import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../calc/goal_calculator.dart';
import '../../model/goal.dart';
import 'slideable_tasks.dart';

class buildGoalLeadingDisplay extends StatelessWidget {
  const buildGoalLeadingDisplay({
    Key? key,
    required this.widget,
    required this.goal,
  }) : super(key: key);

  final SlideableTasks widget;
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    if (!goal.isCompletable()) {
      GC gc = GoalCalc(goal);
      return getLeadingForCompositeTask(gc, context);
    }
      return getLeadingForCompletableTask();
  }

  Row getLeadingForCompletableTask() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        getIdentSpacing(goal),
        IconButton(
          icon: Icon(
            goal.isComplete() ? Icons.radio_button_checked: Icons.radio_button_unchecked,
            // color: Colors.blue,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
            ),
          onPressed: () {
            widget.toggleCompleteHandler(goal);
          }
        )]);
  }

  Row getLeadingForCompositeTask(GC gc, BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getIdentSpacing(goal),
          Icon(
            Icons.dashboard,
            color: Colors.blue,
            size: 36.0,
          ),
          //,
          // Icon(
          //   Icons.timer,
          //   //color: Colors.blueAccent,
          //   size: 15.0,
          //   semanticLabel: 'Text to announce in accessibility modes',
          // ),
          // new CircularPercentIndicator(
          //   radius: 40.0,
          //   lineWidth: 5.0,
          //   percent: GoalCalc(goal).getTimePercentageComplete(),
          //   center: new Text(gc.getPercentageCompleteTimeFormatted(),
          //     style:
          //     new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
          //   ),
          //   progressColor: Theme.of(context).colorScheme.primary,
          //   animation: true,
          // ),
          // Icon(
          //   Icons.attach_money,
          //   //color: Colors.green,
          //   size: 15.0,
          //   semanticLabel: 'Text to announce in accessibility modes',
          // ),
          // new CircularPercentIndicator(
          //   radius: 40.0,
          //   lineWidth: 5.0,
          //   percent: GoalCalc(goal).getCostPercentageComplete(),
          //   center: new Text(gc.getPercentageCompleteCostFormatted(),
          //     style:
          //     new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
          //   ),
          //   progressColor: Theme.of(context).colorScheme.primaryVariant,
          //   animation: true,
          // ),
        ]);
  }

  Widget getIdentSpacing(Goal goal) {
    if ( goal.ident < 1) return SizedBox.shrink();
    return Container(margin: EdgeInsets.only(left: goal.ident * 25.0), child:
    Icon(Icons.subdirectory_arrow_right, size: 20.0));
  }
}