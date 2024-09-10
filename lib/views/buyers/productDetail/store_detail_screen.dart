import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreDetailScreen extends StatelessWidget {
  const StoreDetailScreen({super.key, this.storeData});
  final dynamic storeData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          storeData['bussinessName'],
        ),
      ),
    );
  }
}
