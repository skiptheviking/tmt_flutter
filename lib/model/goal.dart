import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'edit_goal_directive.dart';

class Goal {
  String title;
  String description;
  double costInDollars;
  double timeInHours;
  bool _complete = false;
  bool isDeleted = false;
  int levelDeep = 0;  // start at 0 // TODO Can this be calculated instead of stored?
  List<Goal> goals = []; // children
  String id = getUniqueID();

  Goal(this.title, this.description, this.costInDollars, this.timeInHours) {
    this.levelDeep = 0;
    this.isDeleted = false;
  }

  factory Goal.fromString(String title) {
    return new Goal(title, "",0,0);
  }

  bool isLeaf() {
    return getActiveGoals().length == 0;
  }

  delete() {
    this.isDeleted = true;
  }

  restore() {
    this.isDeleted = false;
  }

  addSubGoal(Goal goal) {
    goal.levelDeep = this.levelDeep + 1; // TODO can this be calculated
    this.goals.add(goal);
  }

  void editGoal(EditGoal editedGoal) { // TODO can this be done with a Partial?
    print(editedGoal);
    this.title = editedGoal.title;
    this.description = editedGoal.description;
    this.timeInHours = editedGoal.timeInHours;
    this.costInDollars = editedGoal.costInDollars;
    this._complete = editedGoal.complete;
  }

  List<Goal> getActiveGoals() {
    return goals.where((element) => element.isDeleted == false).toList();
  }

  @override
  String toString() {
    return 'Goal{title: $title, description: $description, costInDollars: $costInDollars, timeInHours: $timeInHours, complete: $_complete, isDeleted: $isDeleted, levelDeep: $levelDeep, goals: $goals}';
  }

  factory Goal.fromJson(Map<String, dynamic> jsonMap) {
    double costInDollars = double.parse(jsonMap["cid"].toString());

    var timeInHours = jsonMap["tih"];
    if (timeInHours.runtimeType == int) {
      timeInHours = timeInHours.toDouble();
    }
    Goal result = new Goal(jsonMap["t"], jsonMap["desc"],costInDollars,timeInHours);
    result.id = jsonMap['id'].toString();
    result._complete = jsonMap['c'];
    result.isDeleted = jsonMap['del'];
    result.levelDeep = jsonMap['lD'];
    var list = jsonMap['g'] as List;
    result.goals = list.map((i) => Goal.fromJson(i)).toList();
    return result;
  }

  // Note Firebase limits string sizes to 10 mb.  We compress this file when we save
  Map<String, dynamic> toJson() => {
    'id': id,
    't': title,
    'desc': description,
    'cid':costInDollars,
    'tih':timeInHours,
    'c':_complete,
    'del':isDeleted,
    'lD':levelDeep,
    'g': goals
  };

  Function deepEq = const DeepCollectionEquality().equals;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Goal &&
          id == other.id &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          costInDollars == other.costInDollars &&
          timeInHours == other.timeInHours &&
          _complete == other._complete &&
          isDeleted == other.isDeleted &&
          levelDeep == other.levelDeep &&
          deepEq(goals, other.goals);

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      costInDollars.hashCode ^
      timeInHours.hashCode ^
      _complete.hashCode ^
      isDeleted.hashCode ^
      levelDeep.hashCode ^
      goals.hashCode;

  List<Goal> getGoals() {
    return this.goals;
  }

  void toggleComplete() {
    _complete = !_complete;
  }

  bool isCompletable() {
    return this.goals.where((goal) => goal.isDeleted == false).length < 1;
  }

  static String getUniqueID() {
    return Random().nextInt(999999).toString() + "." + DateTime.now().toString();
  }

  void setComplete(bool bool) {
    this._complete = bool;
  }

  bool isComplete() {
    if (isLeaf()) return _complete;
    double numCompleted = getActiveGoals().fold(0, (prev, element) => element.isComplete() ?
    prev + 1 : prev);
    if (numCompleted == getActiveGoals().length) return true;
    return false;
  }

}
