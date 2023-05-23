import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Settings'),
      ),
      body: Center(child: Text('To be implemented')),
    );
  }
}
