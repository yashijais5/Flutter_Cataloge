import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cataloge/core/store.dart';
import 'package:flutter_cataloge/models/cart.dart';
import 'package:flutter_cataloge/models/catalog.dart';
import 'package:flutter_cataloge/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Items catalog;
  AddToCart({required this.catalog, super.key});

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    
    return VxBuilder(
      mutations: {AddMutation},
      builder: (context, _, __) {
        bool isInCart = _cart.item.contains(catalog);
        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              AddMutation(catalog);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
            shape: MaterialStateProperty.all(const StadiumBorder()),
          ),
          child: isInCart
              ? const Icon(Icons.done)
              : const Icon(
                  CupertinoIcons.cart_badge_plus,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}
