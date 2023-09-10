import 'package:flutter/material.dart';

class containers extends StatelessWidget {
  const containers(
      {super.key, required this.title, required this.icons, required this.fun});
  final String title;
  final Icon icons;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fun(),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              icons,
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
