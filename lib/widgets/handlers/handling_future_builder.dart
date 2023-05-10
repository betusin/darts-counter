import 'package:flutter/material.dart';

class HandlingFutureBuilder extends StatelessWidget {
  final Future future;
  final Widget Function(BuildContext context, AsyncSnapshot<dynamic> snapshot)
      builder;

  const HandlingFutureBuilder(
      {Key? key, required this.future, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error!}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return builder(context, snapshot);
      },
    );
  }
}
