import 'package:flutter/material.dart';
import 'package:lesson76_bloc_cubit/data/models/product_model.dart';

class ProductBox extends StatefulWidget {
  ProductModel? product;
  ProductBox({super.key, this.product});

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  double price = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.product != null) {
      name = widget.product!.name;
      price = widget.product!.price;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context, {
        "name": name,
        "price": price,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("New product"),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.product == null
                    ? "Product name"
                    : widget.product!.name,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter product name properly";
                }
                return null;
              },
              onSaved: (newValue) {
                name = newValue!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.product == null
                    ? "Product price"
                    : widget.product!.price.toString(),
              ),
              validator: (value) {
                if (value == null ||
                    double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return "please enter product price appropriately";
                }
                return null;
              },
              onSaved: (newValue) {
                price = double.parse(newValue!);
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: submit,
          child: const Text("Save"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
