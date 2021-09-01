import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InitializingView extends StatelessWidget {
  const InitializingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
