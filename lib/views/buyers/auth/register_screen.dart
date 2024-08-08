import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_fashion_store/controllers/auth_controller.dart';
import 'package:multi_fashion_store/utils/show_snackBar.dart';
import 'package:multi_fashion_store/views/buyers/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String fullname;
  late String phoneNumber;
  late String password;
  Uint8List? _image;
  String? _imageFileName;
  bool _isLoading = false;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(
              email, fullname, phoneNumber, password, _image, _imageFileName!)
          .whenComplete(
        () {
          setState(() {
            _formKey.currentState!.reset();
            _isLoading = false;
          });
        },
      );
      return showSnack(
          context, 'Congratulations An Account Has Been Created For You');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please Fields must not be empty');
    }
  }

  selectGalleryImage() async {
    try {
      Map<String, dynamic> imageInfo =
          await _authController.pickProfileImage(ImageSource.gallery);

      Uint8List im = imageInfo['data'];
      String filePath = imageInfo['path'];
      String fileName = filePath.split('/').last;

      setState(() {
        _image = im;
        _imageFileName = fileName;
      });
    } catch (e) {
      print(e);
      // Handle the error, e.g., show a snackbar or alert
    }
  }

  selectCameraImage() async {
    try {
      Map<String, dynamic> imageInfo =
          await _authController.pickProfileImage(ImageSource.camera);

      Uint8List im = imageInfo['data'];
      String filePath = imageInfo['path'];
      String fileName = filePath.split('/').last;

      setState(() {
        _image = im;
        _imageFileName = fileName;
      });
    } catch (e) {
      print(e);
      // Handle the error, e.g., show a snackbar or alert
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Customer Account',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Stack(children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          backgroundImage: const NetworkImage(
                              'data:image/jpeg;base64,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'),
                        ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: const Icon(CupertinoIcons.photo),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(labelText: 'Enter Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Full Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullname = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Enter Full Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Enter Phone Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4),
                            ),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have An Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Login'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
