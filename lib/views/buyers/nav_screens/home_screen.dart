import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        WelcomeText(),
        SizedBox(
          height: 14,
        ),
        SeachInputWidget(),
        BannerWidget()
      ],
    );
  }
}
