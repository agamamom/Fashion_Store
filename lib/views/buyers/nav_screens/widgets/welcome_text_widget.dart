import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Howdy, What Are You\n Looking For 👀',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        Container(
          child: SvgPicture.asset('assets/icons/cart.svg'),
          width: 20,
        ),
      ],
    );
  }
}
