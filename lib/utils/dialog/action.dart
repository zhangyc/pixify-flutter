import 'package:flutter/material.dart';

import '../../common/widgets/button/colored.dart';

Future<T?> showActions<T>({
  required BuildContext context,
  required List<T> actions,
  String? title,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 30,
              height: 3,
              color: Colors.black12,
            ),
            SizedBox(height: 24),
            Visibility(
              visible: title != null && title.isNotEmpty,
              child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
                  )
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...actions.map(
                          (action) => Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ColoredButton(
                                onTap: () {
                                  Navigator.pop(context, action);
                                },
                                color: Theme.of(context).colorScheme.background,
                                text: 'action.label'
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40)
          ],
        ),
      );
    },
  );
}