import 'package:flutter/foundation.dart';
import 'package:flutter_cataloge/core/store.dart';
import 'package:flutter_cataloge/models/catalog.dart';
import 'dart:convert';

import 'package:velocity_x/velocity_x.dart';

class CartModel {
  // catalog field
  late CatalogModel _catalog;

//Collection of IDs - store Ids of each item
  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get item in the cart
  List<Items> get item => _itemIds.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice => item.fold(0, (total, current) => total + current.price);

  void remove(Items item) {}
  void add(Items item) {}
}

class AddMutation extends VxMutation<MyStore> {
  final Items item;

  AddMutation(this.item);

  @override
  perform() {
    store!.cart.add(item);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Items item;

  RemoveMutation(this.item);

  @override
  perform() {
    store!.cart.remove(item);
  }
}
