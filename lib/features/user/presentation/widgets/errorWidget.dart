import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final double topPadding;

  const ErrorMessageWidget({
    super.key,
    required this.message,
    this.topPadding = 0.3, // default to 30% of screen height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * topPadding),
      child: Center(child: Text(message, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center)),
    );
  }
}
