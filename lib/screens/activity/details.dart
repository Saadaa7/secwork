import 'package:flutter/material.dart' hide badge;

class details extends StatelessWidget {
  const details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(child: Text('Details')),
    );
  }
}
