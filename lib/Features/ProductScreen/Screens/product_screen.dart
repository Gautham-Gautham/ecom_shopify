import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/Core/Common/custom_snackbar.dart';
import 'package:ecom_app/Features/ProductScreen/sq_flight.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../../Models/category_model.dart';
import '../../../Models/product_model.dart';
import '../../ProductDetails/product_details.dart';
import '../Controller/product_controller.dart';
import 'package:path/path.dart';

List<Product> addCart = [];
List<Product> products = [];

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.watch(sqflightProvider).createDatabase();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ref.watch(fetchProductProvider).when(
          data: (data) {
            products = data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: products.map((e) {
                    return Container(
                      child: Image.network(e.image, fit: BoxFit.cover),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: h / 3.5,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    reverse: false,
                    viewportFraction: 1.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 235.0,
                    maxCrossAxisExtent: 300.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    //   return gridProductBuilder(
                    //   products[index],
                    //   context,
                    //   () {
                    //
                    //   },
                    // );

                    // bool cart = false;
                    final cartprovider = StateProvider<bool>(
                      (ref) => false,
                    );
                    Product product = products[index];

                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        for (var i in addCart) {
                          if (i.id == product.id) {
                            // If the item is already in the cart, update its cart value and remove it
                            product.cart = 1;
                            // cart = true;
                            ref.read(cartprovider.notifier).update(
                                  (state) => true,
                                );
                            break; // Exit the loop
                          }
                        }
                      },
                    );
                    return Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                product: product,
                                              ),
                                            ));
                                      },
                                      child: Image.network(
                                        product.image,
                                        height: 150.0,
                                        width: double.infinity,
                                      ),
                                    ),
                                    // if (product.price != product.oldPrice)
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            )),
                                        child: Text(
                                          'Sale',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //favorites button
                                Consumer(
                                  builder: (context, ref, child) {
                                    return InkWell(
                                      onTap: () {
                                        var addCartCopy = List.from(
                                            addCart); // Create a copy of addCart
                                        bool isItemAlreadyInCart = false;

                                        for (var i in addCartCopy) {
                                          if (i.id == product.id) {
                                            // If the item is already in the cart, update its cart value and remove it
                                            product.cart = 0;
                                            addCart.removeWhere((element) =>
                                                element.id == product.id);
                                            ref
                                                .watch(sqflightProvider)
                                                .deleteData(id: product.id);
                                            customSnackbar(context, 'removed');
                                            // cart = false;
                                            ref
                                                .read(cartprovider.notifier)
                                                .update(
                                                  (state) => false,
                                                );
                                            isItemAlreadyInCart =
                                                true; // Set the flag to true
                                            break; // Exit the loop
                                          }
                                        }

                                        if (!isItemAlreadyInCart) {
                                          product.cart = 1;
                                          addCart.add(product);
                                          ref
                                              .watch(sqflightProvider)
                                              .insertData(product: product);
                                          // cart = true;
                                          ref
                                              .read(cartprovider.notifier)
                                              .update(
                                                (state) => true,
                                              );
                                          customSnackbar(context, 'added');
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.8),
                                        radius: 16.0,
                                        child: Icon(
                                          // cart == true
                                          ref.watch(cartprovider)
                                              ? CupertinoIcons.cart_fill
                                              : CupertinoIcons.cart,
                                          color: ref.watch(cartprovider) == true
                                              ? Colors.orange
                                              : HexColor('CEBBAC'),
                                          size: 19.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${product.price}\$',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15.0,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            );
          },
          error: (error, stackTrace) {
            return const Text("Something Went Wrong");
          },
          loading: () {
            return SizedBox(
              height: h,
              width: w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
