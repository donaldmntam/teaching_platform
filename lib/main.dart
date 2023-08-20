import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/root/page.dart' as root;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Services(
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: root.Page()
      ),
    );
  }
}