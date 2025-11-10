import 'package:flutter/material.dart';

void main() {
  runApp(const BillingSystem());
}

class BillingSystem extends StatefulWidget {
  const BillingSystem({super.key});

  @override
  State<BillingSystem> createState() => _BillingSystemState();
}

class _BillingSystemState extends State<BillingSystem> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _quantityController = TextEditingController();

  String _result = "";

  void _calculateBill() {
    if (_formKey.currentState!.validate()) {
      String name = _productNameController.text;
      double price = double.tryParse(_productPriceController.text) ?? 0.0;
      double quantity = double.tryParse(_quantityController.text) ?? 0.0;

      double subtotal = price * quantity;
      double gst = 0.0;

      // Apply GST if subtotal exceeds ₹1000
      if (subtotal > 1000) {
        gst = subtotal * 0.05;
      }

      double total = subtotal + gst;

      setState(() {
        _result =
            "Product: $name\nSubtotal: ₹${subtotal.toStringAsFixed(2)}\n"
            "GST: ₹${gst.toStringAsFixed(2)}\n"
            "Total Amount: ₹${total.toStringAsFixed(2)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Billing System',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product Billing System'),
          backgroundColor: const Color.fromARGB(255, 155, 39, 176),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter Product Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 15),

                // Product Name
                TextFormField(
                  controller: _productNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Enter the product name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product name";
