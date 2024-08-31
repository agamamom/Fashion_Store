import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_fashion_store/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  const ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<File> image = [];

  List<String> imageUrlList = [];

  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('no image picked');
    } else {
      setState(() {
        image.add(
          File(pickedFile.path),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 3),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          chooseImage();
                        },
                        icon: const Icon(Icons.add),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            image[index - 1],
                          ),
                        ),
                      ),
                    );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: 'Saving Images');
              for (var img in image) {
                Reference ref = _storage
                    .ref()
                    .child('productImage')
                    .child(const Uuid().v4());

                await ref.putFile(img).whenComplete(
                  () async {
                    await ref.getDownloadURL().then(
                      (value) {
                        setState(() {
                          imageUrlList.add(value);
                        });
                      },
                    );
                  },
                );
              }
              setState(() {
                productProvider.getFormData(imageUrlList: imageUrlList);
                EasyLoading.dismiss();
              });
            },
            child: image.isNotEmpty ? const Text('Upload') : const Text(''),
          )
        ],
      ),
    );
  }
}
