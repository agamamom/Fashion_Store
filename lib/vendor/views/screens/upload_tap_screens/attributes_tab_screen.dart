import 'package:flutter/material.dart';
import 'package:multi_fashion_store/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AttributesTabScreen extends StatefulWidget {
  const AttributesTabScreen({super.key});

  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen> {
  bool _entered = false;
  final TextEditingController _sizeController = TextEditingController();

  List<String> _sizeList = [];

  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Brand';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              _productProvider.getFormData(brandName: value);
            },
            decoration: const InputDecoration(
              labelText: 'Brand',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Size';
                      } else {
                        return null;
                      }
                    },
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                ),
              ),
              _entered == true
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900),
                      child: const Text('Add'),
                    )
                  : const Text('')
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizeList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _sizeList.removeAt(index);
                            _productProvider.getFormData(sizeList: _sizeList);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _sizeList[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(sizeList: _sizeList);
                setState(() {
                  _isSave = true;
                });
              },
              child: Text(
                _isSave ? 'Saved' : 'Save',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 3),
              ),
            )
        ],
      ),
    );
  }
}
