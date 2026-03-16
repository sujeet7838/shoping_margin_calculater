import 'package:flutter/material.dart';

class SubscriptionScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Required'),
      ),
      body: Center(
        child: Text(
          'You have reached the maximum number of calculations. Please subscribe to continue.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

}