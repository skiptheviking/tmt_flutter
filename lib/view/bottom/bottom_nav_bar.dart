import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class CustomBottomNavbar extends StatelessWidget {
  final Function navigateUpHandler;
  final Function addGoalHandler;
  final Function saveHandler;
  final Function sortHandler;
  final Function openGoalStoreHandler;
  final bool isAtRoot;

  const CustomBottomNavbar(
      {Key? key,
      required this.navigateUpHandler,
      required this.addGoalHandler,
      required this.saveHandler,
      required this.sortHandler,
      required this.openGoalStoreHandler,
      required this.isAtRoot})
      : super(key: key);

  @override
  BottomAppBar build(BuildContext context) {
    var buttonColor = Colors.white;

    return BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            Spacer(),
            isAtRoot
                ? GFButton(
                    onPressed: () => openGoalStoreHandler(),
                    text: "GoalStore",
                    icon: Icon(Icons.store, color: buttonColor),
                    type: GFButtonType.outline,
                    color: buttonColor,
                  )
                : Container(height: 0, width: 0),
            isAtRoot ? Spacer() : Container(height: 0, width: 0),
            Spacer(),
            !isAtRoot
                ? GFButton(
                    onPressed: () => navigateUpHandler(),
                    text: "Back",
                    icon: Icon(Icons.arrow_back_ios,
                        color: isAtRoot ? Colors.grey : buttonColor),
                    type: GFButtonType.outline,
                    color: isAtRoot ? Colors.grey : buttonColor,
                  )
                : Container(height: 0, width: 0),
            !isAtRoot ? Spacer() : Container(height: 0, width: 0),
            GFButton(
              onPressed: () => addGoalHandler(),
              text: "New Task",
              icon: Icon(Icons.add, color: buttonColor),
              type: GFButtonType.outline,
              color: buttonColor,
            ),
            Spacer(),
            // GFButton(
            //   onPressed: () => sortHandler(),
            //   text: "Sort",
            //   icon: Icon(Icons.add, color: buttonColor),
            //   type: GFButtonType.outline,
            //   color: buttonColor,
            // ),
            // Spacer(),

            //IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ));
  }
}
