import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/presentation/components/app_button.dart';
import 'package:kawanlama/presentation/ui/home/components/favorite_item_widgets.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
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
    return Column(
      children: [
        Expanded(
          child: LiquidPullToRefresh(
            onRefresh: _itemController.getFavorites,
            showChildOpacityTransition: false,
            child: Obx(() {
              if (_itemController.favoritesItems.isEmpty) {
                return Center(
                  child: Text(I10n.current.empty_data),
                );
              } else {
                return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) => FavoriteItemWidgets(item: _itemController.favoritesItems[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: _itemController.favoritesItems.length);
              }
            }),
          ),
        ),
        Obx(() {
          if (_itemController.favoritesItems.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppButton.defaults(title: I10n.current.printing, onPressed: () async => await _itemController.print()),
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
