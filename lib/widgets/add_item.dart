//widget to add a new items  throughout the app

import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  int addItemIndex = 0;
  int reduceItemIndex = 0;
  int itemCount = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Column(
        children: [
          Text('Item Count: $itemCount'),
        ],
      ),
    );
  }
}