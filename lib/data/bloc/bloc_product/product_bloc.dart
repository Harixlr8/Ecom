import 'package:bloc/bloc.dart';
import 'package:test_zybo/model/wishlist.dart';
import 'package:test_zybo/data/service/api_service.dart';

import 'package:test_zybo/data/bloc/bloc_product/product_event.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_state.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(fetchProducts);
    on<ProductWishlistEvent>(productWishlistEvent);
  }

  Future<void> productWishlistEvent(
      ProductWishlistEvent event, Emitter<ProductState> emit) async {
    try {
      emit(ProductAddingOrRemovingWishlistState());

      WishlistResponse? response = await ApiService().toggleWishlist(event.id);
      
      emit(ProductAddedOrRemovedWishlistState(response: response!.message));

      // **Trigger the FetchProducts event again**
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(error: "Failed to update wishlist"));
    }
  }

  Future<void> fetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    print("Fetching");

    try {
      final products = await ApiService().fetchProducts();
      final bannerProducts = await ApiService().fetchBanners();

      emit(ProductLoaded(products: products, bannerProducts: bannerProducts));
    } catch (e) {
      emit(ProductError(error: "Failed to fetch products"));
    }
  }
}
