import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/models/food.dart';

class DetailScreen extends StatefulWidget {
  final Food food;

  const DetailScreen({
    super.key,
    required this.food,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: foodDetailWidget(context),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.redAccent,
        height: 80,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'q',
              backgroundColor: const Color.fromARGB(109, 140, 94, 91),
              elevation: 0,
              onPressed: () {},
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: 'w',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {},
              child: Text(
                '0',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'q',
              backgroundColor: const Color.fromARGB(109, 140, 94, 91),
              elevation: 0,
              onPressed: () {},
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                heroTag: 't',
                backgroundColor: const Color.fromARGB(109, 140, 94, 91),
                elevation: 0,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IDR ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Add to cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  foodDetailWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.food.imagePath.toString(),
            child: Container(
              height: 300,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.food.imagePath.toString()),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.food.name.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.food.price} IDR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 38,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.star_fill,
                          size: 14,
                          color: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.food.rating.toString(),
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

                // Icon Favorite
                Icon(
                  CupertinoIcons.heart,
                  size: 34,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.food.description.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
