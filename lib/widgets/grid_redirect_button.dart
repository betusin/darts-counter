import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridRedirectButton extends StatelessWidget {
  final String text;
  final String routeName;
  final IconData iconData;

  const GridRedirectButton({
    Key? key,
    required this.text,
    required this.iconData,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () => context.push(routeName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                iconData,
                size: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
