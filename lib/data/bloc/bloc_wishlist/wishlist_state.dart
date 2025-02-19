part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class WishlistFetchSucces extends WishlistState {
  final List<Product>? products;

  const WishlistFetchSucces({required this.products});

}

final class WishlistFetchError extends WishlistState {}
