import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_event.dart';
import 'package:test_zybo/data/bloc/bloc_search/search_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_search/search_event.dart';
import 'package:test_zybo/data/bloc/bloc_search/search_state.dart';


class SearchScreen extends StatelessWidget {
  final ProductBloc productBloc;

  const SearchScreen({super.key, required this.productBloc});
  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true, // Automatically focus on the search bar
          decoration: InputDecoration(
            hintText: "Search for products...",
            border: InputBorder.none,
          ),
          onChanged: (query) {
            searchBloc.add(SearchQueryChanged(query));
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchSuccess) {
            if (state.products.isEmpty) {
              return Center(child: Text("No products found"));
            }
            return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.75),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            elevation: 5,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    width: double.infinity,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        state.products[index].featuredImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9}${state.products[index].mrp.toString()}',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '\u{20B9}${state.products[index].salePrice.toString()}',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber),
                                        SizedBox(width: 5),
                                        Text(
                                          state.products[index].avgRating
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      state.products[index].caption,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.purple,
                                  size: 28,
                                ),
                                onPressed: () {
                                  productBloc.add(ProductWishlistEvent(
                                      id: state.products[index].id.toString()));
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
            //////////////
            // return ListView.builder(
            //   itemCount: state.products.length,
            //   itemBuilder: (context, index) {
            //     final product = state.products[index];
            //     return ListTile(
            //       title: Text(product.name), // Update based on your model
            //       // subtitle: Text("\$${product.price}"), // Example
            //     );
            //   },
            // );
          } else if (state is SearchFailure) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text("Type to search"));
        },
      ),
    );
  }
}
