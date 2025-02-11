import 'package:flutter/material.dart';

class ProfileSetting extends StatefulWidget{
  final String title;
  final String subTitle;

  ProfileSetting({
    required this.title,
    required this.subTitle
  });

  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        height: 75.0,
        width: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
              ),
            ),
            Text(widget.subTitle,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey
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