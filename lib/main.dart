import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:convvls/model/main.dart';
import 'package:convvls/screen/home.dart';

void main() => runApp(Convvls());

class Convvls extends StatelessWidget {
  final _routes = <String, WidgetBuilder>{};

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: "Convvls",
        home: Home(),
        theme: _themeData(),
        routes: _routes,
      ),
    );
  }

  ThemeData _themeData() {
    // https://docs.flutter.io/flutter/material/ThemeData-class.html
    return ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.amber[800],
      backgroundColor: Colors.indigo[200],
      buttonColor: Colors.indigo[300],
      // primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
    );
  }
}
