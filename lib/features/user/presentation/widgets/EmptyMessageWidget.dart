import 'package:flutter/material.dart';

class EmptyMessageWidget extends StatelessWidget {
  final String message;
  final double topPadding;

  const EmptyMessageWidget({
    super.key,
    this.message = 'No data available.',
    this.topPadding = 0.00001, // 30% of screen height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * topPadding,
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
