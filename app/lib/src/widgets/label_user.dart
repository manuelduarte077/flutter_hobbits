import 'package:flutter/material.dart';

class LabelUsers extends StatelessWidget {
  const LabelUsers({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
      ),
      child: Text(user),
    );
  }
}
