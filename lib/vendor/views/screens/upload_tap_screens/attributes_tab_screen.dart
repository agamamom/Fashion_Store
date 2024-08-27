import 'package:flutter/material.dart';

class AttributesTabScreen extends StatelessWidget {
  const AttributesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
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
                    decoration: const InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900),
                child: const Text('Add'),
              )
            ],
          )
        ],
      ),
    );
  }
}
