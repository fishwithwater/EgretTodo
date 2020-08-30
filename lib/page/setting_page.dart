import 'package:egret_todo/model/egret_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  EgretTheme egretTheme;
  @override
  Widget build(BuildContext context) {
    egretTheme = Provider.of<EgretTheme>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          Container(
            height: 500.0,
            child: GridView.count(
              crossAxisCount: 6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              children: _buildColorItem(egretTheme.themeColor),
            ),
          ),
        ],
      ),
    );
  }

  _buildColorItem(MaterialColor selectedColor) {
    List<MaterialColor> materialColorList = Colors.primaries;
    List<FlatButton> resultList = [];
    for (MaterialColor materialColor in materialColorList) {
      resultList.add(FlatButton(
        color: materialColor.shade500,
        shape: selectedColor == materialColor ? Border.all(
                    color: Colors.black26, style: BorderStyle.solid, width: 4)
                : null,
        onPressed: (){
          egretTheme.changeColor(materialColor);
        },
      ));
    }
    return resultList;
  }
}
