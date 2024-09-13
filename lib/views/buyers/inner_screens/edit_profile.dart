import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userData});
  final dynamic userData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? address;
  @override
  void initState() {
    _fullNameController.text = widget.userData['fullName'];
    _emailController.text = widget.userData['email'];
    _phoneController.text = widget.userData['phoneNumber'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, letterSpacing: 6, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.yellow.shade900,
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.photo),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter full name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Enter email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Enter phone',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            address = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter address',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: InkWell(
              onTap: () async {
                EasyLoading.show(status: 'UPDATING');
                await _firestore
                    .collection('buyers')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'fullName': _fullNameController.text,
                  'email': _emailController.text,
                  'phoneNumber': _phoneController.text,
                  'address': address
                }).whenComplete(
                  () {
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, letterSpacing: 6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
