import 'package:flutter/material.dart';

class DeletedText extends StatelessWidget {
  String text;

  DeletedText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style:
          TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
    );
  }
}
