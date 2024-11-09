import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';
import 'add_product_page.dart';
import 'edit_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategory;
  double? minPrice;
  double? maxPrice;
  bool? inStock;
  double? minRating;
  bool newer = true;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.filterProducts(
      category: selectedCategory,
      minPrice: minPrice,
      maxPrice: maxPrice,
      inStock: inStock,
      minRating: minRating,
      newer: newer,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _openFilterDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(
              products[i].name,
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 18,
                color: Colors.purple[900],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price: \$${products[i].price}',
                  style: TextStyle(fontFamily: 'RobotoMono', color: Colors.purple[700]),
                ),
                Text(
                  'Category: ${products[i].category}',
                  style: TextStyle(fontFamily: 'RobotoMono', color: Colors.purple[700]),
                ),
                Text(
                  'Rating: ${products[i].rating}',
                  style: TextStyle(fontFamily: 'RobotoMono', color: Colors.purple[700]),
                ),
                Text(
                  'In Stock: ${products[i].inStock ? 'Yes' : 'No'}',
                  style: TextStyle(fontFamily: 'RobotoMono', color: Colors.purple[700]),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.purple[700]),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EditProductPage(productId: products[i].id),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.purple[700]),
                  onPressed: () {
                    productProvider.deleteProduct(products[i].id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _openFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Filter Products', style: TextStyle(fontFamily: 'RobotoMono')),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category filter
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: Colors.purple)),
                items: const [
                  DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                  DropdownMenuItem(value: 'Clothing', child: Text('Clothing')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              // Price range filters
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Min Price',
                    labelStyle: TextStyle(color: Colors.purple)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    minPrice = double.tryParse(value);
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Max Price',
                    labelStyle: TextStyle(color: Colors.purple)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    maxPrice = double.tryParse(value);
                  });
                },
              ),
              // Stock availability filter
              SwitchListTile(
                title: const Text('In Stock Only', style: TextStyle(color: Colors.purple)),
                value: inStock ?? false,
                onChanged: (value) {
                  setState(() {
                    inStock = value;
                  });
                },
              ),
              // Rating filter
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Min Rating',
                    labelStyle: TextStyle(color: Colors.purple)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    minRating = double.tryParse(value);
                  });
                },
              ),
              // Date sort order filter
              SwitchListTile(
                title: const Text('Newer First', style: TextStyle(color: Colors.purple)),
                value: newer,
                onChanged: (value) {
                  setState(() {
                    newer = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Apply Filters', style: TextStyle(color: Colors.purple[700])),
          ),
        ],
      ),
    );
  }
}