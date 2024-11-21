import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_batch_2/models/food.dart';
import 'package:flutter_course_batch_2/provider/cart.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/cart_screen.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/detail_screen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Food> foods = [];

  Future<void> getFoods() async {
    String dataFoodJson = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = json.decode(dataFoodJson);

    setState(() {
      foods = jsonMap.map((e) => Food.fromJson(e)).toList();
    });

    debugPrint(foods[0].name);
  }

  void goToDetailFood(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          food: foods[index],
        ),
      ),
    );
  }

  void goToCart() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sushiman',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location_fill,
                  size: 14,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              size: 30,
            ),
          ),
          Consumer<Cart>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        goToCart();
                      },
                      icon: Icon(
                        CupertinoIcons.bag,
                        size: 30,
                      ),
                    ),
                    Visibility(
                      visible: value.cart.isNotEmpty ? true : false,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.yellow,
                        child: Center(
                          child: Text(
                            value.cart.length.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BANNER PROMO
          bannerPromoWidget(context),

          // BEST SELLER
          bestSellerWidget(context),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
              'Popular Food',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: foods.length,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    goToDetailFood(index);
                  },
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(right: 16),
                    height: 140,
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: foods[index].imagePath.toString(),
                          child: Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(foods[index].imagePath.toString()),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          foods[index].name.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '${foods[index].price} IDR',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              size: 14,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              foods[index].rating.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bestSellerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Seller ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              goToDetailFood(2);
            },
            child: Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(foods[2].imagePath.toString()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(
                      foods[2].name.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${foods[2].price} IDR',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 28,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bannerPromoWidget(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/images/sushi_nigiri.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ListTile(
            title: Text(
              'Get 78% off ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'for Sushi Nigiri',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.arrow_right,
              size: 40,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
