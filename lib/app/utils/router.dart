
import 'package:crud_stadandri/app/pages/home/home_view.dart';
import 'package:crud_stadandri/app/pages/pages.dart';
import 'package:flutter/material.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _buildRoute(settings, HomePage());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}