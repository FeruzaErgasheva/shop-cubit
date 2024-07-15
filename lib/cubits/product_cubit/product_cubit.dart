import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson76_bloc_cubit/cubits/product_cubit/product_state.dart';
import 'package:lesson76_bloc_cubit/data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialState());

  Future<void> changeStatus(ProductModel product) async{
    List<ProductModel> products = [];
  if (state is LoadedState) {
    products = (state as LoadedState).products;
  }

  emit(LoadingState());
  await Future.delayed(Duration(seconds: 3));

  // Update the product in the list
  for (int i = 0; i < products.length; i++) {
    if (products[i].id == product.id) {
      products[i].isFavourite=!product.isFavourite;
      break;
    }
  }

  emit(LoadedState(products));
  }


  Future<void> deleteProduct(ProductModel product) async{
    List<ProductModel> products = [];
  if (state is LoadedState) {
    products = (state as LoadedState).products;
  }

  emit(LoadingState());
  await Future.delayed(Duration(seconds: 1));

  // Update the product in the list
  for (int i = 0; i < products.length; i++) {
    if (products[i].id == product.id) {
     products.remove(products[i]);
      break;
    }
  }
  emit(LoadedState(products));

  }

Future<void> editProduct(ProductModel product, String newName, double newPrice) async {
  List<ProductModel> products = [];
  if (state is LoadedState) {
    products = (state as LoadedState).products;
  }

  emit(LoadingState());
  await Future.delayed(Duration(seconds: 3));

  // Update the product in the list
  for (int i = 0; i < products.length; i++) {
    if (products[i].id == product.id) {
      products[i] = ProductModel(
        id: product.id,
        name: newName,
        price: newPrice,
        // Include other fields if necessary
      );
      break;
    }
  }

  emit(LoadedState(products));
}



  Future<void> addProduct(String name, double price) async{
    List<ProductModel> products=[];
    if(state is LoadedState){
      products=(state as LoadedState).products;
    }

    emit(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    products.add(ProductModel(id: UniqueKey().toString(), name: name, price: price));

    emit(LoadedState(products));

  }

  Future<void> getProducts() async {
    try {
      //sorov jonatilgandan keyin loading statega otadi va 2 soniya kutadi
      emit(LoadingState());
      await Future.delayed(
        const Duration(seconds: 2),
      );
      List<ProductModel> products = [
        ProductModel(id: UniqueKey().toString(), name: "olma", price: 2500),
        ProductModel(id: UniqueKey().toString(), name: "nok", price: 500),
        ProductModel(id: UniqueKey().toString(), name: "gilos", price: 800),
        ProductModel(id: UniqueKey().toString(), name: "behi", price: 1000),
        ProductModel(id: UniqueKey().toString(), name: "anjir", price: 400)
      ];

      emit(LoadedState(products));

      // throw("Rejalarni ololmadim");
    } catch (e) {
      print('Xatolik sodir boldi');
      emit(
        ErrorState(
          e.toString(),
        ),
      );
    }
  }
}
