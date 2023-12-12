import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawanlama/application/item_controller.dart';
import 'package:kawanlama/presentation/ui/home/components/contact_item_widgets.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
import 'package:kawanlama/utilities/injection/injection.dart';
import 'package:kawanlama/utilities/utilities.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

@RoutePage()
class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ItemController _itemController = getIt<ItemController>()..fetchItem().onError((error, stackTrace) => showError(error));

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _itemController.fetchItem,
      showChildOpacityTransition: false,
      child: Obx(() {
        if (_itemController.items.isEmpty) {
          return Center(
            child: Text(I10n.current.empty_data),
          );
        } else {
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) => ContactItemWidgets(item: _itemController.items[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: _itemController.items.length);
        }
      }),
    );
  }
}
