import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_form/app/myApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
  runApp(const MyApp());
}
