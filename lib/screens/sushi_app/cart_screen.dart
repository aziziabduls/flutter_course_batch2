import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/models/cart_model.dart';
import 'package:flutter_course_batch_2/provider/cart_provider.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/dashboard.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/payment_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool showLoader = true;
  double price = 0;
  double totalPrice = 0;
  double taxAndService = 0;
  double totalPayment = 0;

  deleteItem(CartModel food) {
    context.read<CartProvider>().deleteItemCart(food);
    if (context.read<CartProvider>().cart.isEmpty) {
      setState(() {
        price = 0;
        totalPrice = 0;
        taxAndService = 0;
        totalPayment = 0;
      });
    } else {
      context.read<CartProvider>();
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        showLoader = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        for (var cartModel in value.cart) {
          price = int.parse(cartModel.quantity.toString()) * int.parse(cartModel.price.toString()).toDouble();
          totalPrice += double.parse(price.toString());
          taxAndService = (totalPrice * 0.11).toDouble();
          totalPayment = (totalPrice + taxAndService).toDouble();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            actions: [
              Visibility(
                visible: value.cart.isNotEmpty ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      value.clearCart();
                      setState(() {
                        price = 0;
                        totalPrice = 0;
                        taxAndService = 0;
                        totalPayment = 0;
                      });
                    },
                    icon: Row(
                      children: const [
                        Text('Clear Cart'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: showLoader
              ? Center(
                  child: SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Text(
                        'Loading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : value.cart.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cart is empty',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          CupertinoButton(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(50),
                            child: Text('Add Some Food'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Dashboard()),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.cart.length,
                          itemBuilder: (context, index) {
                            final food = value.cart[index];
                            return Slidable(
                              key: ValueKey(index),
                              endActionPane: ActionPane(
                                extentRatio: 0.25,
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 2,
                                    onPressed: (context) => deleteItem(food),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: CupertinoIcons.trash,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    color: Colors.yellow,
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      food.imagePath.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  food.nama.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      'IDR ${food.price} x ${food.quantity}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 80),
                        CupertinoButton(
                          child: Text('Add Some Food?'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Dashboard()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
          bottomNavigationBar: (showLoader)
              ? null
              : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'IDR $totalPrice',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax and Service',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'IDR $taxAndService',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'IDR $totalPayment',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(50),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Pay Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Urbanist',
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(CupertinoIcons.arrow_right),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  totalPayment: totalPayment.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
