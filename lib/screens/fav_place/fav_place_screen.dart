import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/provider/fav_place_provider.dart';
import 'package:flutter_course_batch_2/screens/fav_place/add_new_place.dart';
import 'package:provider/provider.dart';

class FavPlaceScreen extends StatefulWidget {
  const FavPlaceScreen({super.key});

  @override
  State<FavPlaceScreen> createState() => _FavPlaceScreenState();
}

class _FavPlaceScreenState extends State<FavPlaceScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Place'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewPlace()),
              );
            },
            icon: Icon(
              CupertinoIcons.add,
            ),
          ),
        ],
      ),
      body: Consumer<FavPlaceProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            reverse: value.favPlaceModel.length == 1 ? false : true,
            itemCount: value.favPlaceModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/id/237/200/300',
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'aziziabduls',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                value.favPlaceModel[index].location.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: Container(
                        height: 400,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(
                              base64Decode(
                                value.favPlaceModel[index].image.toString(),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                            child: Icon(
                              isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                              size: 30,
                              color: isLiked ? Colors.red : Colors.black,
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(
                            CupertinoIcons.chat_bubble,
                            size: 30,
                          ),
                          SizedBox(width: 15),
                          Icon(
                            CupertinoIcons.paperplane,
                            size: 30,
                          ),
                          Spacer(),
                          Icon(
                            CupertinoIcons.bookmark,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: "aziziabduls  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: value.favPlaceModel[index].name.toString(),
                              // text: 'Culpa sunt do aliquip veniam fugiat consectetur occaecat non exercitation ipsum.',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
