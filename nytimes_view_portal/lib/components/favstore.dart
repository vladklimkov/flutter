library favstore;

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nytimes_view_portal/models/score.dart';

class FavstoreController {
  /// The Hive box used to store cart items.
  final Box<Articles> _cartBox =
      Hive.box<Articles>('cartBox');

  /// A [ValueListenable] for the cart box, allowing widgets to listen for changes in the cart.
  ValueListenable<Box<Articles>> get cartListenable =>
      _cartBox.listenable();

    /// Adds a [Articles] to the shopping cart.
    /// If the product is already in the cart, it updates the quantity. If not, it adds a new instance.
    void addToCart(Articles item) {
        print(item);
        print(item.id);
        print(item.title);
        // Retrieve the existing item using the product ID as the key
        Articles? existingItem = _cartBox.get(item.id!);
        if (existingItem == null) {
            // add a new instance
            _cartBox.put(item.id!, Articles.clone(item));
        }
    }

    /// Removes a product from the shopping cart.
    /// Returns `true` if the product is successfully removed, `false` if the product is not found in the cart.
    bool removeFromCart(int productId) {
        if (_cartBox.keys.contains(productId)) {
            _cartBox.delete(productId);
            return true;
        }
        return false; // not found in the cart
    }

    /// Gets the total number of items in the shopping cart.
    int getCartItemCount() {
        return _cartBox.length;
    }

    /// Checks if a product with the given [productId] exists in the shopping cart.
    bool isItemExistsInCart(int productId) {
        return _cartBox.keys.contains(productId);
    }

    /// Removes a product from the cart using the [productId].
    /// Returns `true` if the product is successfully removed, `false` if the product is not found in the cart.
    bool removeProduct(int productId) {
        if (_cartBox.keys.contains(productId)) {
            _cartBox.delete(productId);
            return true;
        }
        return false; // not found in the cart
    }

    /// Retrieves a list of [Articles] from the shopping cart.
    List<Articles> getCartItems() {
        List<Articles> cartItems = [];
        for (var i = 0; i < _cartBox.length; i++) {
            Articles item = _cartBox.getAt(i)!;
            cartItems.add(item);
        }
        return cartItems;
    }

    /// Clears all items from the shopping cart.
    void clearCart() {
        _cartBox.clear();
    }
}

// Extension method for Iterable class
extension IterableExtensions<T> on Iterable<T> {
    T? firstWhereOrNull(bool Function(T) test) {
        for (final element in this) {
            if (test(element)) {
                return element;
            }
        }
        return null;
    }
}

/// The main class for interacting with the persistent shopping cart.
class PersistentFavstore {
    /// Initializes Hive and opens the cart box.
    Future<void> init() async {
        await Hive.initFlutter();
        // Register the adapters
        Hive.registerAdapter(ArticlesAdapter());
        //open cart box
        await Hive.openBox<Articles>('cartBox');
    }

    /// Adds a [Articles] to the shopping cart.
    Future<void> addToCart(Articles cartItem) async {
        FavstoreController().addToCart(cartItem);
        log('CartItem added to Hive box: ${cartItem.toJson()}');
    }

    /// Removes a product from the shopping cart.
    Future<bool> removeFromCart(int productId) async {
        bool removed = FavstoreController().removeFromCart(productId);
        if (removed) {
            log('CartItem removed from Hive box: $productId');
        } else {
            log('Product not found in the cart: $productId');
        }
        return removed;
    }

    /// Gets the total number of items in the shopping cart.
    int getCartItemCount() {
        return FavstoreController().getCartItemCount();
    }

    /// Clears all items from the shopping cart.
    void clearCart() {
        FavstoreController().clearCart();
    }

    List<Articles> getCartData() {
        final favstoreController = FavstoreController();
        List<Articles> cartItems = favstoreController.getCartItems();
        return cartItems;
    }

    /// Displays the current cart item count using the provided widget builder.
    Widget showCartItemCountWidget(
        {required Widget Function(int itemCount) cartItemCountWidgetBuilder}) {
        return ValueListenableBuilder<Box<Articles>>(
            valueListenable: FavstoreController().cartListenable,
            builder: (context, box, child) {
                var itemCount = FavstoreController().getCartItemCount();
                return cartItemCountWidgetBuilder(itemCount);
            },
        );
    }
}
