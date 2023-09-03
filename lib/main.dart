import 'package:flutter/material.dart' hide Theme;
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/root/page.dart' as root;
import 'package:teaching_platform/login/page.dart' as login;
import 'package:teaching_platform/common/models/social_media/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _State();
}

class _State extends State<MyApp> {
  User? user;

  @override
  Widget build(BuildContext context) {
    return Services(
      user: user,
      listener: (
        didLogIn: (user) => setState(() => this.user = user),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: switch (user) {
          null => const login.Page(),
          _ => const root.Page(),
        }
      ),
    );
  }
}
