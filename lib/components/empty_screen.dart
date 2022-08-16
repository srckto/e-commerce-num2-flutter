import 'package:flutter/material.dart';

import 'package:e_commerce_num2/components/custom_text.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    this.message,
  }) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: message ?? " Empty Screen "),
    );
  }
}
