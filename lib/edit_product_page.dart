// edit_product_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'product_provider.dart';

class EditProductPage extends StatefulWidget {
  final String productId;

  const EditProductPage({super.key, required this.productId});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late double price;
  late String category;
  late bool inStock;
  late double rating;

  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final product =
        productProvider.products.firstWhere((p) => p.id == widget.productId);

    // Initializing form fields with product values
    name = product.name;
    price = product.price;
    category = product.category;
    inStock = product.inStock;
    rating = product.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
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
                initialValue: name,
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
                initialValue: price.toString(),
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
                  // Additional categories can be added here
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
                initialValue: rating.toString(),
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
                  textStyle: const TextStyle(fontFamily: 'RobotoMono', fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<ProductProvider>(context, listen: false)
                        .editProduct(
                      widget.productId,
                      Product(
                        id: widget.productId,
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
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontFamily: 'RobotoMono', fontSize: 16),
                ),
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteProduct(widget.productId);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
