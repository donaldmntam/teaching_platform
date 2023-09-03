import 'package:flutter/material.dart' hide TextField, TextButton, Listener;
import 'package:teaching_platform/common/models/account/type.dart';
import 'package:teaching_platform/common/theme/theme.dart';
import 'package:teaching_platform/common/widgets/button/text_button.dart';
import 'package:teaching_platform/common/widgets/services/services.dart';
import 'package:teaching_platform/common/widgets/text_field/text_field.dart';
import 'package:teaching_platform/login/widgets/selector.dart';
import 'package:teaching_platform/common/models/social_media/user.dart';

class Page extends StatefulWidget {
  const Page({
    super.key,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  AccountType selectedType = AccountType.teacher;
  String userName = "";
  String password = "";

  void logIn() {
    final User user = (
      userName: userName,
      picture: const NetworkImage("https://picsum.photos/200"),
    );
    final services = Services.of(context);
    services.listener.didLogIn(user);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Services.of(context).theme;
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: _columnWidth(constraints),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: _columnWidth(constraints),
                    height: _imageHeight(constraints),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: _spacing),
                  Selector(
                    selectedType: selectedType,
                    onTypeChanged: (type) => setState(() =>
                      selectedType = type
                    )
                  ),
                  const SizedBox(height: _spacing),
                  Row(
                    children: [
                      Text(
                        "User-name/email: ",
                        style: theme.textStyle(
                          size: 24,
                          weight: FontWeight.normal,
                          color: theme.colors.primary,
                        )
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          onTextChange: (v) => setState(() => userName = v),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: _spacing),
                  Row(
                    children: [
                      Text(
                        "Password: ",
                        style: theme.textStyle(
                          size: 24,
                          weight: FontWeight.normal,
                          color: theme.colors.primary,
                        )
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          obscureText: true,
                          onTextChange: (v) => setState(() => password = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: _spacing),
                  TextButton(
                    "Login",
                    onPressed: _canLogIn(userName, password) ? logIn : null,
                  )
                ]
              ),
            )
          );
        }
      ),
    );
  }
}

bool _canLogIn(String username, String password) {
  return username.isNotEmpty && password.isNotEmpty;
}

double _columnWidth(BoxConstraints constraints) =>
  constraints.maxWidth * 0.5;

const _spacing = 32.0;

double _imageHeight(BoxConstraints constraints) =>
  constraints.maxWidth / 7;

