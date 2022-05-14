import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'model_helpers/edit_goal_directive.dart';

class Goal {
  String title;
  double money; // cost in dollars
  double time; // time in hours
  Goal? _parent; // TODO implement this
  bool _complete = false;
  bool isDeleted = false;
  List<Goal> goals = []; // children
  String id = getUniqueID();


  Goal(this.title, this._parent, {this.money = 0, this.time = 0});
  Goal.empty() : this("",null);
  Goal.child(Goal parent) : this("",parent);

  int getLevelDeep() {
    if (getParent() != null) {
      return getParent()!.getLevelDeep() + 1;
    }
    return 1;
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
    this.goals.add(goal);
  }

  void editGoal(EditGoal editedGoal) { // TODO can this be done with a Partial?
    print(editedGoal);
    this.title = editedGoal.title;
    this.time = editedGoal.timeInHours;
    this.money = editedGoal.costInDollars;
    this._complete = editedGoal.complete;
  }

  List<Goal> getActiveGoals() {
    return goals.where((element) => element.isDeleted == false).toList();
  }

  @override
  String toString() {
    return 'Goal{title: $title, costInDollars: $money, timeInHours: $time, complete: $_complete, isDeleted: $isDeleted, goals: $goals}';
  }

  static String id_key = 'id';
  static String title_key = 't';
  static String description_key='desc';
  static String cost_dollars_key='cid';
  static String time_in_hours_key='tih';
  static String complete_key='c';
  static String is_deleted_key='del';
  static String levels_deep_key='lD';
  static String goals_key="g";

  factory Goal.fromJson(Map<String, dynamic> jsonMap) {
    jsonMap = cleanMap(jsonMap);

    double costInDollars = double.parse(jsonMap[cost_dollars_key].toString());

    var timeInHours = jsonMap[time_in_hours_key];
    Goal result = new Goal(jsonMap[title_key],jsonMap["parent"],money: costInDollars,time: timeInHours);
    result.id = jsonMap[id_key].toString();
    result._complete = jsonMap[complete_key];
    result.isDeleted = jsonMap[is_deleted_key];
    result.expanded = jsonMap["expanded"];

    var list = jsonMap[goals_key] as List;
    result.goals = list.map((i) => Goal.fromJson(i)).toList();
    return result;
  }

  static Map<String, dynamic> cleanMap(Map<String, dynamic> jsonMap) {
    if (jsonMap[time_in_hours_key].runtimeType == int) {
      jsonMap[time_in_hours_key] = jsonMap[time_in_hours_key].toDouble();
    }
    if (!jsonMap.containsKey("expanded")) {
      jsonMap["expanded"] = false;
    }
    return jsonMap;
  }

  // Note Firebase limits string sizes to 10 mb.  We compress this file when we save
  Map<String, dynamic> toJson() => {
    id_key: id,
    title_key: title,
    cost_dollars_key: money,
    time_in_hours_key: time,
    complete_key:_complete,
    is_deleted_key:isDeleted,
    goals_key: goals,
    "expanded" : expanded,
  };

  Function deepEq = const DeepCollectionEquality().equals;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Goal &&
          id == other.id &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          money == other.money &&
          time == other.time &&
          _complete == other._complete &&
          isDeleted == other.isDeleted &&
          deepEq(goals, other.goals);

  @override
  int get hashCode =>
      title.hashCode ^
      money.hashCode ^
      time.hashCode ^
      _complete.hashCode ^
      isDeleted.hashCode ^
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

  bool expanded = false;

  void toggleExpand() {
    expanded = !expanded;
  }

  int ident = 0;

  void setIdent(int depth) {
    this.ident = depth;
  }

  Goal? getParent() {
    if (_parent != null) return _parent;
    return null;
  }

  void setParent(Goal parent) {
    this._parent = parent;
  }

}
