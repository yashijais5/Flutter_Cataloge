import 'package:flutter/material.dart';
import 'package:flutter_cataloge/core/store.dart';
import 'package:flutter_cataloge/models/cart.dart';
import 'package:flutter_cataloge/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.center.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final CartModel _cart= (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "\$${_cart.totalPrice}".text.xl5.make(),
          30.widthBox,
          ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: "Buying not supported yet".text.make(),
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyTheme.darkBluishColor)),
                  child: "Buy".text.white.make())
              .w32(context)
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
     final CartModel _cart= (VxState.store as MyStore).cart;
    return _cart.item.isEmpty
        ? "Nothing to show".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.item?.length,
            itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.done),
                  trailing: IconButton(
                    onPressed: () =>
                     RemoveMutation(_cart.item[index]),
                      //setState(() {});
                    icon: Icon(Icons.remove_circle_outline),
                  ),
                  title: _cart.item[index].name.text.make(),
                ));
  }
}
