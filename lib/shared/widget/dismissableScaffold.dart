import 'package:flutter/material.dart';

import '../app_constants/app_numbers.dart';
import 'common_appbar.dart';

class DismissableScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const DismissableScaffold({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, title),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppNumbers.horizontalPadding, 0, AppNumbers.horizontalPadding, 12),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: child,
            ),
          ),
        ));
  }
}
