import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_event.dart';
import 'package:test_zybo/data/bloc/bloc_product/product_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_zybo/layers/home/screen/home/search/search_result.dart';
import 'package:test_zybo/data/service/api_service.dart';

import '../../../../data/bloc/bloc_search/search_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductBloc productBloc = ProductBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc.add(FetchProducts());
  }

  // final TextEditingController _searchController = TextEditingController();

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(),
      body: BlocConsumer<ProductBloc, ProductState>(
        bloc: productBloc,
        listener: (context, state) {
          if (state is ProductAddedOrRemovedWishlistState) {
            if (state.response == "Product added to favorites") {
              _showMessage(state.response, Colors.green);
            } else {
              _showMessage(state.response, Colors.red);
            }
          }
        },
        builder: (context, state) {
          if (state is ProductLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to SearchScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SearchBloc(ApiService()),
                            child: SearchScreen(productBloc: productBloc,),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("Search...",
                              style: TextStyle(color: Colors.grey)),
                          Row(
                            children: [
                              SizedBox(height: 15,
                              width: 3,
                                child: VerticalDivider(color: Colors.grey,)),
                                SizedBox(width: 10,),
                              Icon(Icons.search, color: Colors.grey),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                CarouselSlider(
                  items: state.bannerProducts.map((slider) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(slider.image),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              slider.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                  ),
                ),
                Expanded(
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
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
