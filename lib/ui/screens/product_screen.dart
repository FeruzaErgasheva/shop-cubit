import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson76_bloc_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:lesson76_bloc_cubit/cubits/product_cubit/product_state.dart';
import 'package:lesson76_bloc_cubit/data/models/product_model.dart';
import 'package:lesson76_bloc_cubit/ui/widgets/product_box.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<ProductCubit>().getProducts();
    });
  }

  void openProductBox({ProductModel? product}) async {
    dynamic? data = await showDialog(
      context: context,
      builder: (context) {
        return ProductBox(
          product: product != null ? product : null,
        );
      },
    );

    ///cunmadim nme context.read context.watchmas

    if (data != null && product == null) {
      context.read<ProductCubit>().addProduct(
            data['name'],
            data['price'],
          );
    }
    if (data != null && product != null) {
      context.read<ProductCubit>().editProduct(
            product,
            data["name"],
            data['price'],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final productCubit = context.watch<ProductCubit>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: openProductBox,
            icon: const Icon(Icons.add),
          ),
        ],
        centerTitle: true,
        title: const Text("Products"),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text("Malumot hali yuklanmadi"),
            );
          }

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          final products = (state as LoadedState).products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index].name),
                subtitle: Text(
                  products[index].price.toString(),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<ProductCubit>()
                            .changeStatus(products[index]);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: products[index].isFavourite
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        openProductBox(product: products[index]);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.teal,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<ProductCubit>()
                            .deleteProduct(products[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
