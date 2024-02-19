import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_blog/feature/cart_screen/data/manage_cart.dart';
import 'package:demo_blog/feature/product_screen/data/product.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductScreen extends StatelessWidget {
  final List<Product> products = List.generate(
    10,
    (index) => Product(
      id: 'prod_${index + 1}',
      title: 'Product ${index + 1}',
      brand: 'Brand ${(Random().nextDouble() * 100).floor()}',
      price: (Random().nextDouble() * 100).toDouble(),
      imageUrl:
          'https://prd.place/400/600?id=${index}', // Placeholder image URL
      description: 'This is a detailed description of Product ${index + 1}.',
      category: 'Category ${(Random().nextInt(5) + 1)}',
      stockQuantity: Random().nextInt(50) + 1,
      rating: Random().nextDouble() * 5,
      creationDate: DateTime.now(),
      discountedPrice: Random().nextBool() ? Random().nextDouble() * 50 : null,
      isFeatured: Random().nextBool(),
      tags: ['Tag1', 'Tag2', 'Tag3'],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // Navigator.push to product details page if necessary
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image, size: 50),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${product.brand} - ${product.category}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'BDT ${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        CartManager.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item added to cart'),
                          ),
                        );
                      },
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
