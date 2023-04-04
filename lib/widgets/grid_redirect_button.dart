import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridRedirectButton extends StatelessWidget {
  final Widget? pageToRedirect;
  final String text;
  final IconData iconData;
  final bool exit;

  const GridRedirectButton({
    Key? key,
    this.pageToRedirect,
    required this.text,
    required this.iconData,
    this.exit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
          onPressed: () {
            if (exit) {
              SystemNavigator.pop();
              return;
            }
            final pageToPush =
                MaterialPageRoute(builder: (_) => pageToRedirect!);
            Navigator.of(context).push(pageToPush);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  iconData,
                  size: 44,
                ),
              ),
              Text(text),
            ],
          )),
    );
  }
}
