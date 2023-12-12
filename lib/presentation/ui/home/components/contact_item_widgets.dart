import 'package:flutter/material.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
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
        enabled: !item.isFavorite,
        onChanged: (bool? value) async => await getIt<ItemController>().markAsFavorite(item),
      ),
    );
  }
}
