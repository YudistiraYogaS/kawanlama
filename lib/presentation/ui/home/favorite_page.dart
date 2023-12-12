import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/presentation/ui/home/components/favorite_item_widgets.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ItemController _itemController = getIt<ItemController>();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _itemController.getFavorites,
      showChildOpacityTransition: false,
      child: Obx(() {
        if (_itemController.favoritesItems.isEmpty) {
          return const Center(
            child: Text('Empty Data'),
          );
        } else {
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) => FavoriteItemWidgets(item: _itemController.favoritesItems[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: _itemController.favoritesItems.length);
        }
      }),
    );
  }
}
