import 'package:flutter/material.dart';
import 'package:xogame/helper/getit.dart';
import 'package:xogame/helper/preferences.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    final currentName = getGetit<SharedPref>().get("name") as String?;
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: currentName == null || currentName.isEmpty
                  ? "Enter your Name"
                  : currentName),
          onSubmitted: (val) {
            getGetit<SharedPref>().setString("name", val);
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            for (var item in ["x", "o"])
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        getGetit<SharedPref>().get("myplayer") == item
                            ? Colors.green
                            : Colors.grey)),
                child: Text(item),
                onPressed: () {
                  setState(() {
                    getGetit<SharedPref>().setString("myplayer", item);
                  });
                },
              )
          ],
        )
      ],
    );
  }
}
