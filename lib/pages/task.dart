import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_project/components/customButton.dart';

// Product Model
class Product {
  final String code;
  final String name;
  final int quantity;
  final double price;
  final String description;

  Product({
    required this.code,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      description: json['description'] ?? 'No description provided',
    );
  }
}

class ProductService {
  final String baseUrl = 'http://119.10.255.198:8000/api/products/';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      List<dynamic> productList = jsonResponse['products']['data'];
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}



// Task Widget to display the product list
class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    // Fetch the products when the widget initializes
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Product List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.cabin().fontFamily,
                  ),
                ),
                SizedBox(width: 10),
                SvgPicture.asset('assets/images/vector1.svg'),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomButton(
                      width: 50, height: 30, text: 'All', onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 120,
                      height: 30,
                      text: 'Quantity',
                      onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 80, height: 30, text: 'Price', onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 120, height: 30, text: 'Low Stocks', onPressed: () {}),
                ],
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list, size: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products available'));
                  }

                  List<Product> products = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: products.map((product) {
                        return Column(
                          children: [
                            Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          product.description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '7 weeks ago',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.blueAccent,
                                    child: Text(
                                      product.code,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
