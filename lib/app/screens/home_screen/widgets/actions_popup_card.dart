import 'package:flutter/material.dart';

class ActionsPopupCard extends StatelessWidget {
  final List<String> actions;
  final Color actionColor;
  final Color actionTextColor;
  final Color actionIconColor;
  final IconData actionIcon;
  final VoidCallback goTo;
  final String buttonText;

  const ActionsPopupCard({
    Key key,
    this.actions = const [],
    this.actionColor,
    this.actionTextColor = Colors.white,
    this.actionIconColor,
    this.actionIcon,
    this.goTo,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                  actions.isNotEmpty ? 'Pending actions' : 'Profile complete'),
            ),
            if (actions.isEmpty)
              Center(
                child: Icon(
                  Icons.assignment_turned_in,
                  color: Colors.green,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: actionColor ?? Colors.grey[800],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          actionIcon,
                          color: actionColor ?? Colors.yellow[200],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Missing value: ${actions[index]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: actionTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (goTo != null)
              FlatButton(
                onPressed: goTo,
                child: Text(buttonText ?? 'Open profile'),
              ),
          ],
        ),
      ),
    );
  }
}
