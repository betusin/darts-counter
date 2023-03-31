import 'package:flutter/material.dart';

class GridRedirectButton extends StatelessWidget {
  final Widget pageToRedirect;
  final String text;
  final IconData iconData;

  const GridRedirectButton(
      {Key? key,
      required this.pageToRedirect,
      required this.text,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
          onPressed: () {
            final pageToPush =
                MaterialPageRoute(builder: (_) => pageToRedirect);
            Navigator.of(context).push(pageToPush);
          },
          child: Center(
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
          )),
    );
  }
}
