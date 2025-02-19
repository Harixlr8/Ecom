import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_wishlist/wishlist_bloc.dart';

class WishlistScreen extends StatefulWidget {
  final WishlistBloc wishlistBloc;
  const WishlistScreen({super.key, required this.wishlistBloc});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    super.initState();
      widget.wishlistBloc.add(WishlistFetchEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false,title: Text("Wishlist",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        bloc: widget.wishlistBloc,
        builder: (context, state) {
          print("State is here $state");
          if(state is WishlistInitial){
            return Center(child: CircularProgressIndicator(),);
          }
         else if (state is WishlistFetchSucces) {
            return Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75),
                  itemCount: state.products!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                      state.products![index].featuredImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '\u{20B9}${state.products![index].mrp.toString()}',
                                        style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '\u{20B9}${state.products![index].salePrice.toString()}',
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
                                        state.products![index].avgRating
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
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    state.products![index].caption,
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
                      ],
                    );
                  },
                )),
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
