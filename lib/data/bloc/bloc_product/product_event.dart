abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class ProductWishlistEvent extends ProductEvent {
  final String id;

  ProductWishlistEvent({required this.id});
}