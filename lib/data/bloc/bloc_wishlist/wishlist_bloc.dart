import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_zybo/model/product.dart';
import 'package:test_zybo/data/service/api_service.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistFetchEvent>(wishlistfetch);
  }
  Future<void> wishlistfetch(
      WishlistFetchEvent event, Emitter<WishlistState> emit) async {
    try {
      emit(WishlistInitial());
      final product = await ApiService().fetchWishlist();
      
      emit(WishlistFetchSucces(products: product));
    } catch (e) {
      print("Wishlist fetch error in blc");
    }
  }
}
