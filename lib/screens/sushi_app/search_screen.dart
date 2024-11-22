import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_batch_2/models/food.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Food> foods = [];
  List<Food> _foundedFoods = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getFoods() async {
    String dataFoodJson = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = json.decode(dataFoodJson);

    setState(() {
      foods = jsonMap.map((e) => Food.fromJson(e)).toList();
      _foundedFoods = foods;
    });
  }

  onSearchFood(String query) {
    setState(() {
      _foundedFoods = foods.where((element) => element.name!.toLowerCase().contains(query.toLowerCase())).toList();
    });
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
        title: Text('Search Food'),
      ),
      body: Column(
        children: [
          // search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Food',
                contentPadding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                prefixIcon: Icon(CupertinoIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: Visibility(
                  visible: _foundedFoods.isEmpty ? true : false,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _foundedFoods = foods;
                        searchController.text = '';
                      });
                    },
                    icon: Icon(CupertinoIcons.clear_circled),
                  ),
                ),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  onSearchFood(value.toString());
                });
              },
            ),
          ),

          // list food
          _foundedFoods.isEmpty
              ? Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'No Food Found',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foundedFoods.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              food: foods[index],
                            ),
                          ),
                        );
                      },
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            _foundedFoods[index].imagePath.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        _foundedFoods[index].name.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text('IDR ${_foundedFoods[index].price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            size: 15,
                            color: Colors.green,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _foundedFoods[index].rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
