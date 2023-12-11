import 'package:flutter/material.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/utilities/utilities.dart';

class ContactItemWidgets extends StatelessWidget {
  final ItemDTO item;

  const ContactItemWidgets({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        secondary: CircleAvatar(child: Text(getInitial(item.name))),
        title: Text(item.name),
        subtitle: Text(item.type),
        value: item.isFavorite,
        onChanged: (bool? value) {},
      ),
    );
  }
}
