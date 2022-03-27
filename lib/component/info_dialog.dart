import 'package:flutter/material.dart';
import 'package:xogame/helper/getit.dart';
import 'package:xogame/helper/preferences.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({Key key}) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                 ( getGetit<SharedPref>().get("name") == "" || getGetit<SharedPref>().get("name") == null ) ?  "Enter your Name" :  getGetit<SharedPref>().get("name")),
          onSubmitted: (val) {
            //if (val.isEmpty) val = "";
            getGetit<SharedPref>().setString("name", val);
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            for (var item in ["x", "o"])
              FlatButton(
                color: getGetit<SharedPref>().get("myplayer") == item
                    ? Colors.green
                    : Colors.grey,
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
