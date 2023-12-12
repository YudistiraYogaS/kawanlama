import 'package:flutter/material.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/presentation/components/app_dialog.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:kawanlama/utilities/utilities.dart';

class FavoriteItemWidgets extends StatelessWidget {
  final ItemDTO item;

  const FavoriteItemWidgets({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await AppDialog.showInfoInMd(context, info: item.description),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text(getInitial(item.name))),
          title: Text(item.name),
          subtitle: Text(item.type),
          trailing: IconButton.outlined(onPressed: () async => getIt<ItemController>().deleteFavorite(item), icon: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}
