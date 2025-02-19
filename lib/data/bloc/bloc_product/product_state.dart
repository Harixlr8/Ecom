import 'package:test_zybo/model/product.dart';
import 'package:test_zybo/model/slider_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<SliderModel>bannerProducts;
  ProductLoaded( {required this.bannerProducts,required this.products});
}

// class BannerLoaded extends ProductState{
//   final List<SliderModel>bannerProducts;

//   BannerLoaded({required this.bannerProducts});
// }

class ProductError extends ProductState {
  final String error;
  ProductError({required this.error});
}
class ProductAddingOrRemovingWishlistState extends ProductState {}

class ProductAddedOrRemovedWishlistState extends ProductState {
  final String response;

  ProductAddedOrRemovedWishlistState({required this.response});
}