import 'package:flutter/material.dart';

Future<String?> getInputText(BuildContext context, String title) async {
  return showDialog<String>(
    context: context,
    builder: (context) {
      var showRequiredFieldError = false;
      final controller = TextEditingController();

      void disposeFn() {
        controller.dispose();
      }

      void onCancel() {
        disposeFn();
        Navigator.pop(context);
      }

      return StatefulBuilder(builder: (context, setState) {
        void onOK() {
          if (controller.text.isEmpty) {
            setState(() {
              showRequiredFieldError = true;
            });
            return;
          }
          disposeFn();
          Navigator.pop(context, controller.text);
        }

        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: controller,
                autofocus: true,
                onSubmitted: (value) => onOK,
                decoration: InputDecoration(
                  errorText: showRequiredFieldError ? 'Required field' : null,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel,
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: onOK,
              child: Text('OK'),
            ),
          ],
        );
      });
    },
  );
}
