import 'package:flutter/material.dart';

class SettingButton extends StatefulWidget{
  final String button;

  SettingButton({
    required this.button
  });

  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 64.0,
        width: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(onPressed: () => print("Button Pressed"),
              child: Text(
                widget.button, style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey
                ),
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}