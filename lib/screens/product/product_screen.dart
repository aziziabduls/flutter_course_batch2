import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/service_provider/service_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    Provider.of<ServiceProvider>(context, listen: false).getProductsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch All Product'),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.errorMessage != null) {
                showErrorDialog(context, value);
              }
            });
          } else {
            return productListWidget(value);
          }
          return SizedBox.fromSize();
        },
      ),
    );
  }

  showErrorDialog(BuildContext context, ServiceProvider value) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(value.errorMessage!),
          actions: [
            TextButton(
              onPressed: () {
                value.getProductsProvider();
                Navigator.pop(context);
              },
              child: Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                value.clearErrorMessage();
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  productListWidget(ServiceProvider value) {
    return RefreshIndicator(
      onRefresh: () => value.getProductsProvider(),
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 4.3,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      height: 170,
                      width: MediaQuery.sizeOf(context).width,
                      child: Image.network(
                        value.products[index].images![0],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image_not_supported);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.products[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_pound,
                              size: 18,
                              color: Colors.black,
                            ),
                            SizedBox(width: 2),
                            Text(
                              value.products[index].price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
