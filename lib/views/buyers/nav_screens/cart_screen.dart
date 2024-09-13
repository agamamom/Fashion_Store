import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/providers/cart_provider.dart';
import 'package:multi_fashion_store/views/buyers/inner_screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: const Text(
          'Cart Screen',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cartProvider.removeAllItem();
            },
            icon: const Icon(CupertinoIcons.delete),
          )
        ],
      ),
      body: cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              cartData.imageUrl[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 140,
                                  child: Text(
                                    maxLines:
                                        1, // Limit the text to only one line
                                    overflow: TextOverflow
                                        .ellipsis, // Adds the "..." if the text overflows
                                    cartData.productName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                  ),
                                ),
                                Text(
                                  '\$' ' ' + cartData.price.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Colors.yellow.shade900),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(cartData.productSize),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 115,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow.shade900),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: cartData.quantity == 1
                                                ? null
                                                : () {
                                                    cartProvider
                                                        .decreament(cartData);
                                                  },
                                            icon: const Icon(
                                              CupertinoIcons.minus,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            cartData.quantity.toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: cartData
                                                        .productQuantity ==
                                                    cartData.quantity
                                                ? null
                                                : () {
                                                    cartProvider
                                                        .increament(cartData);
                                                  },
                                            icon: const Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cartProvider
                                            .removeItem(cartData.productId);
                                      },
                                      icon: const Icon(
                                          CupertinoIcons.cart_badge_minus),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your Shopping Cart is Empty',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'CONTINUE SHOPPING',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CheckoutScreen();
                      },
                    ),
                  );
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cartProvider.totalPrice == 0.00
                  ? Colors.grey
                  : Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '\$${cartProvider.totalPrice.toStringAsFixed(2)} CHECKOUT',
                style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 3,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
