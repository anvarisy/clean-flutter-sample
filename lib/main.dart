import 'package:crud_stadandri/app/pages/home/home_view.dart';
import 'package:crud_stadandri/app/utils/router.dart' as r;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final r.Router _router;

  MyApp({Key? key}) : _router = r.Router(), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Simple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}