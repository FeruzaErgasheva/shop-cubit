

// ! Initial state
// !\ Loading state
// ! Loaded state
// ! Error state


import 'package:lesson76_bloc_cubit/data/models/product_model.dart';

sealed class ProductState{}
class InitialState extends  ProductState{

}

final class LoadingState extends  ProductState{}

final class LoadedState extends  ProductState{
  List<ProductModel> products=[];
  LoadedState(this.products);
}

final class ErrorState extends  ProductState{
  String message;
  ErrorState(this.message);

}