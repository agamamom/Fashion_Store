import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/vendor/models/vendor_register_models.dart';
import 'package:multi_fashion_store/vendor/views/screens/main_vendor_screen.dart';

import '../auth/vendor_registration_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: vendorsStream.doc(auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          if (!snapshot.data!.exists) {
            return const VendorRegistrationScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return const MainVendorScreen();
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  vendorUserModel.storeImage.toString(),
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                vendorUserModel.bussinessName.toString(),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Your application has been sent to shop admin\n Admibn will get back to you soon',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  await auth.signOut();
                },
                child: const Text('Sign Out'),
              )
            ],
          ));
        },
      ),
    );
  }
}
