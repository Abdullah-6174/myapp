import 'package:flutter/material.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void editProduct(String id, Product newProduct) {
    final index = _products.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _products[index] = newProduct;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((prod) => prod.id == id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  List<Product> filterProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? inStock,
    double? minRating,
    bool? newer,
  }) {
    List<Product> filteredProducts = _products;

    if (category != null && category.isNotEmpty) {
      filteredProducts = filteredProducts.where((prod) => prod.category == category).toList();
    }

    if (minPrice != null) {
      filteredProducts = filteredProducts.where((prod) => prod.price >= minPrice).toList();
    }

    if (maxPrice != null) {
      filteredProducts = filteredProducts.where((prod) => prod.price <= maxPrice).toList();
    }

    if (inStock != null) {
      filteredProducts = filteredProducts.where((prod) => prod.inStock == inStock).toList();
    }

    if (minRating != null) {
      filteredProducts = filteredProducts.where((prod) => prod.rating >= minRating).toList();
    }

    if (newer != null) {
      if (newer) {
        filteredProducts.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
      }
    }

    return filteredProducts;
  }
}