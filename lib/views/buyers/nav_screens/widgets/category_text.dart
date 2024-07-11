import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categoryLabel = ['food', 'vegetable', 'egg', 'tea'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabel.length,
                    itemBuilder: (context, index) {
                      return ActionChip(
                        backgroundColor: Colors.yellow.shade900,
                        onPressed: () {},
                        label: Center(
                          child: Text(
                            _categoryLabel[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
