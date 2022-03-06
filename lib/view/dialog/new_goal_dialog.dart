import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmt_flutter/model/goal.dart';

class NewGoalDialog extends StatelessWidget {

  // TODO can these be removed if we are using a TextFormField?
  final titleController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final moneyController = new TextEditingController();
  final timeController = new TextEditingController();

  double getMoneyValue() {
    final result = double.tryParse(moneyController.value.text);
    if (result == null) return 0;
    return result;
  }

  double getTimeValue() {
    final result = double.tryParse(timeController.value.text);
    if (result == null) return 0;
    return result;
  }

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title: Text("New Task"),
          content: Container(
         width: double.minPositive,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                hintText: 'Name of Task',
                labelText: 'Title *',
              ),
              controller: titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Optional Description',
                labelText: 'Description',
              ),
              controller: descriptionController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'Estimated Cost',
                labelText: 'Cost in Dollars',
              ),
              controller: moneyController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.hourglass_top_sharp),
                hintText: 'Estimated Time',
                labelText: 'Time in Hours',
              ),
              controller: timeController,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            // TODO activate validators
            final goal = new Goal(titleController.value.text,
                descriptionController.value.text,
                getMoneyValue(),
                getTimeValue());
            titleController.clear();
            descriptionController.clear();
            moneyController.clear();
            timeController.clear();
            Navigator.of(context).pop(goal);
          },
        ),
      ],
    );
  }

}
