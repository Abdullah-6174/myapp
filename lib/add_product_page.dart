import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'product_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  double price = 0;
  String category = 'Electronics'; // Default category
  bool inStock = true;
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style:
              TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[100],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.purple[700]),
                ),
                style: const TextStyle(fontFamily: 'RobotoMono'),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: Colors.purple[700]),
                ),
                style: const TextStyle(fontFamily: 'RobotoMono'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: Colors.purple[700]),
                ),
                value: category,
                items: const [
                  DropdownMenuItem(
                      value: 'Electronics', child: Text('Electronics')),
                  DropdownMenuItem(value: 'Clothing', child: Text('Clothing')),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value ?? 'Electronics';
                  });
                },
              ),
              SwitchListTile(
                title: Text('In Stock',
                    style: TextStyle(color: Colors.purple[700])),
                value: inStock,
                onChanged: (value) {
                  setState(() {
                    inStock = value;
                  });
                },
                activeColor: Colors.purple[300],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Colors.purple[700]),
                ),
                style: const TextStyle(fontFamily: 'RobotoMono'),
                keyboardType: TextInputType.number,
                onChanged: (value) => rating = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid rating';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[300],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle:
                      const TextStyle(fontFamily: 'RobotoMono', fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<ProductProvider>(context, listen: false)
                        .addProduct(
                      Product(
                        id: DateTime.now().toString(),
                        name: name,
                        price: price,
                        category: category,
                        inStock: inStock,
                        rating: rating,
                        dateAdded: DateTime.now(),
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}