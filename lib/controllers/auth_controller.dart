import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Upload Ảnh đã chọn lên firestore
  Future<String> _uploadProfileImageToStorage(
      Uint8List? image, String filename) async {
    if (image == null) {
      throw Exception("Image is null");
    }

    // Determine the MIME type based on the file name
    String? mimeType = lookupMimeType(filename);
    if (mimeType == null) {
      throw Exception("Could not determine MIME type");
    }

    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    // Set metadata to specify the content type
    SettableMetadata metadata = SettableMetadata(contentType: mimeType);

    // Start the upload task with the specified metadata
    UploadTask uploadTask = ref.putData(image, metadata);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Chọn ảnh đại diện khi đăng ký tài khoản
  Future<Map<String, dynamic>> pickProfileImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file == null) {
      throw Exception("No image selected");
    }

    // return await _file.readAsBytes();
    Uint8List imageData = await file.readAsBytes();
    String filePath = file.path;

    return {'data': imageData, 'path': filePath};
  }

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List? image, String fileName) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageUrl =
            await _uploadProfileImageToStorage(image, fileName);

        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user!.uid,
          'address': '',
          'profileImage': profileImageUrl
        });
        res = 'success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {}
    return res;
  }

  loginUsers(String email, String password) async {
    String res = 'something went wrong';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
