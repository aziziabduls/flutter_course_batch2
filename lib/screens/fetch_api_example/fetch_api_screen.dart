// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/service_provider/error_notifier.dart';
import 'package:flutter_course_batch_2/service_provider/service_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FetchAPIScreen extends StatefulWidget {
  const FetchAPIScreen({super.key});

  @override
  State<FetchAPIScreen> createState() => _FetchAPIScreenState();
}

class _FetchAPIScreenState extends State<FetchAPIScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  createNewCategories() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await Provider.of<ServiceProvider>(context, listen: false).createCategory(
          nameController.text,
          imageController.text,
        );

        nameController.clear();
        imageController.clear();
      } catch (e) {
        Provider.of<ErrorNotifier>(context, listen: false).setErrorMessage('Failed to create category.');
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServiceProvider>(context, listen: false).fetchCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Urbanist',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.brown,
          ),
          body: value.isLoading
              // ? shimmerListTile()
              // ? Center(child: CircularProgressIndicator())
              ? Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'Loading',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : value.errorMessage != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_triangle,
                            color: Colors.red,
                            size: 50,
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Error',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            value.errorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 30),
                          CupertinoButton(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(30),
                            child: Text('Reload'),
                            onPressed: () {
                              value.fetchCategories();
                            },
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => value.fetchCategories(),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10, bottom: 100),
                        itemCount: value.categories.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  onPressed: (context) => value.deleteCategory(value.categories[index].id),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: CupertinoIcons.trash,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: value.categories[index].image.toString(),
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url, downloadProgress) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white.withOpacity(0.5),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          color: Colors.grey.shade300,
                                          child: Center(
                                            child: Icon(
                                              Icons.image_not_supported_outlined,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              title: Text(
                                value.categories[index].name.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          floatingActionButton: value.errorMessage != null
              ? null
              : FloatingActionButton(
                  onPressed: createNewCategories,
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }

  shimmerListTile() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 14,
                    width: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          subtitle: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: 14,
                width: 14,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
