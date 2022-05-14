import 'package:flutter/material.dart';
import 'package:tmt_flutter/model/model_helpers/move_goal_directive.dart';
import 'goal.dart';

class AppState {
  List<Goal> _goalStack = [];

  String userId;

  AppState(this.userId);

  AppState.withGoal(this.userId, this._goalStack);

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'goalStack' : _goalStack
  };

  factory AppState.fromJson(Map<String, dynamic> jsonMap) {
    var userId = jsonMap['userId'];
    if (userId == null) userId = "demo";
    AppState appState = new AppState(userId);
    var list = jsonMap['goalStack'] as List;
    appState._goalStack = list.map((i) => Goal.fromJson(i)).toList();
    return appState;
  }

  static String getRootTitle() {
    return "Projects";
  }

  static AppState defaultAppState() {
    AppState appState = new AppState("demo");
    appState._goalStack.add(new Goal(getRootTitle(),null));
    appState._goalStack.first.addSubGoal(new Goal("Welcome to TMT",null));
    return appState;
  }

  @override
  String toString() {
    return 'AppState{'
        '\ncurrentlyDisplayedGoals: $getCurrentlyDisplayedGoalsIncludingDeleted(), '
        '\ntitle: $getTitle(), '
        '\ngoalStack: $_goalStack}';
  }

  Goal? getGrandParentGoal() {
    if (!isAtRoot()) {
      return _goalStack[_goalStack.length - 2];
    }
  }

  bool isAtRoot() {  // When we are at the root we want certain operations to not work such as moving a goal up.
    if (this._goalStack.length == 1) return true;
    return false;
  }

  void openGoal(Goal goal) {
    this._goalStack.add(goal);
  }

  void navigateUp({int levels = 1}) {
    if (!isAtRoot()) {
      for (int x = 0; x < levels; x++) {
        this._goalStack.removeLast();
      }
    }
  }

  void move(MoveGoal moveGoal) {
    if (moveGoal.getGoalToMoveTo() == null) {
      if (isAtRoot()) {
        throw Exception("Can't move up when at the root");
      }
      moveGoal.goalToMoveTo = getGrandParentGoal();
    }
    _moveGoal(moveGoal.getGoalToMove(), moveGoal.getGoalToMoveTo());
  }

  void _moveGoal(Goal goalToMove, Goal? goalToMoveTo) {
    if (goalToMove == goalToMoveTo) {
      throw Exception('Cant move a goal inside itself');
    }
    if (getCurrentlyDisplayedGoalsIncludingDeleted().contains(goalToMove) && goalToMove != goalToMoveTo) {
      getCurrentlyDisplayedGoalsIncludingDeleted().remove(goalToMove);
      goalToMoveTo!.addSubGoal(goalToMove);
    }
  }

  // TODO right now this just goes down one level


  List<Goal> getListOfGoals(Goal goal, int depth) {
    List<Goal> result = [];
    for (var g in goal.getActiveGoals()) {
      //g.indent = depth;
      g.setIdent(depth);
      result.add(g);
      if (g.expanded) {
        result.addAll(getListOfGoals(g, depth+1));
      }
    }
    return result;
  }

  List<Goal> getCurrentlyDisplayedGoalsIncludingDeleted() {  // includes deleted goals
    return _goalStack.last.getGoals();
  }

  List<Goal> getUndeletedGoals() { // excludes deleted goals
      return getCurrentlyDisplayedGoalsIncludingDeleted().where((element) =>
      element.isDeleted == false).toList();
  }

  List<Goal> getGoalsToDisplay() { // excludes deleted goals
    return getListOfGoals(_goalStack.last, 0);
  }

  String getTitle() {
    if (_goalStack.isEmpty) {
      return "ROOT";
    }
    return this._goalStack.last.title;
  }

  Goal getCurrentGoal() {
    return this._goalStack.last;
  }

  bool isAppStateHealthy() {
    if (this._goalStack.length == 0) return false; // always need at least one goal, the root
    return true;
  }


  String formatBreadCrumbTitle(String title) {
    int maxLength = 17;
    if (title.length > maxLength) {
      return title.substring(0,maxLength -3) + "...";
    }
    return title;
  }

  List<String> getBreadCrumbs() {
    return _goalStack.map((goal) => formatBreadCrumbTitle(goal.title)).toList();
  }

  bool toggleColor = false;

  Color getNextColor() {
    toggleColor = !toggleColor;
    if (toggleColor) {
      return Colors.black12;
    }
      return Colors.grey;
  }

  void toggleExpandOnGoal(Goal goal) {
    goal.expanded = !goal.expanded;
  }

  getRootGoal() {
    return this._goalStack[0];
  }

  populateParents() {
    this.populateChildren(getRootGoal());
  }

  populateChildren(Goal parent) {
    if (parent.goals.length != 0) {
      parent.goals.forEach((child) {
        child.setParent(parent);
      });
    }
  }
}