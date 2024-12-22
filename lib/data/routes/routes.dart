import 'package:flutter/material.dart';
import 'package:learnify/data/routes/route_constants.dart';
import 'package:learnify/features/home/presentation/home.dart';

Map<String,WidgetBuilder> routes = {
  RouteConstants.home: (context) => Home(),
};