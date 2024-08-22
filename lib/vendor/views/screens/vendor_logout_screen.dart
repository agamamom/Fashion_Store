import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatelessWidget {
  VendorLogoutScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        _auth.signOut();
      },
      child: const Text('Signout'),
    );
  }
}
