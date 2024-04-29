import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/Features/ProductDetails/product_details.dart';
import 'package:ecom_app/Features/ProductScreen/Screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../Models/add_cart_model.dart';
import '../../../Models/product_model.dart';
import '../../../main.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  // late GetCartModel getFavoriteModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(addCart.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          addCart.isEmpty
              ? SizedBox(
                  width: w,
                  height: h * 0.6,
                  child: Center(
                    child: Text(
                      "Cart is Empty",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      int count = 1;
                      return Material(
                        borderRadius: BorderRadius.circular(20.0),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          color: Colors.white,
                          height: h / 4.5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Image.network(
                                  addCart[index].image,
                                  height: h * 0.5,
                                  fit: BoxFit.fill,
                                  width: w * 0.3,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                            product: addCart[index]),
                                      ));
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, right: 30.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetails(
                                                                  product:
                                                                      addCart[
                                                                          index]),
                                                        ));
                                                  },
                                                  child: Text(
                                                    addCart[index].title,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 19.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     InkWell(
                                    //       onTap: () {
                                    //         print("object");
                                    //         setState(() {
                                    //           count--;
                                    //           // lastAmt = widget.product.price * count;
                                    //         });
                                    //         // if (ref.watch(infProvider1) > 0) {
                                    //         //   ref
                                    //         //       .read(infProvider1.notifier)
                                    //         //       .update((state) => state - 1);
                                    //         // }
                                    //       },
                                    //       child: Container(
                                    //         width: w * 0.15,
                                    //         height: h * 0.04,
                                    //         decoration: BoxDecoration(
                                    //             border: Border.all(
                                    //                 color: Colors.orange),
                                    //             // color: Colors.red,
                                    //             borderRadius: BorderRadius.only(
                                    //                 topLeft: Radius.circular(
                                    //                     w * 0.05),
                                    //                 bottomLeft: Radius.circular(
                                    //                     w * 0.05))),
                                    //         child: Center(
                                    //           child: Text("-",
                                    //               style: GoogleFonts.poppins(
                                    //                   fontSize: w * 0.06,
                                    //                   color: Colors.black,
                                    //                   fontWeight:
                                    //                       FontWeight.w500)),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Container(
                                    //       width: w * 0.15,
                                    //       height: h * 0.04,
                                    //       decoration: const BoxDecoration(
                                    //         // color: Colors.red,
                                    //         border: Border(
                                    //             top: BorderSide(
                                    //                 color: Colors.orange),
                                    //             bottom: BorderSide(
                                    //                 color: Colors.orange)),
                                    //       ),
                                    //       child: Center(
                                    //         child: Text(count.toString(),
                                    //             style: GoogleFonts.poppins(
                                    //                 fontSize: w * 0.06,
                                    //                 color: Colors.black,
                                    //                 fontWeight:
                                    //                     FontWeight.w500)),
                                    //       ),
                                    //     ),
                                    //     InkWell(
                                    //       onTap: () {
                                    //         setState(() {
                                    //           count++;
                                    //           // lastAmt = widget.product.price * count;
                                    //         });
                                    //         // if (ref.read(adtProvider1) >
                                    //         //     ref.read(infProvider1)) {
                                    //         //   ref
                                    //         //       .read(infProvider1.notifier)
                                    //         //       .update((state) => state + 1);
                                    //         // }
                                    //       },
                                    //       child: Container(
                                    //           width: w * 0.15,
                                    //           height: h * 0.04,
                                    //           decoration: BoxDecoration(
                                    //               border: Border.all(
                                    //                   color: Colors.orange),
                                    //               // color: Colors.red,
                                    //               borderRadius:
                                    //                   BorderRadius.only(
                                    //                       topRight:
                                    //                           Radius.circular(
                                    //                               w * 0.05),
                                    //                       bottomRight:
                                    //                           Radius.circular(
                                    //                               w * 0.05))),
                                    //           child: Center(
                                    //             child: Text("+",
                                    //                 style: GoogleFonts.poppins(
                                    //                     fontSize: w * 0.06,
                                    //                     color: Colors.black,
                                    //                     fontWeight:
                                    //                         FontWeight.w500)),
                                    //           )),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //     bottom: 10.0,
                                    //   ),
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.center,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.end,
                                    //     children: [
                                    //       Text(
                                    //         '${(count * addCart[index].price).toString()}\$',
                                    //         style: GoogleFonts.poppins(
                                    //             color: Colors.orange,
                                    //             fontSize: w * 0.05,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5.0,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: h * 0.03,
                                    ),
                                    Text(
                                      '${(count * double.parse(addCart[index].price)).toStringAsFixed(2)}\$',
                                      style: GoogleFonts.poppins(
                                          color: Colors.orange,
                                          fontSize: w * 0.05,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      return favoriteItemBuilder(addCart[index], context);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.0,
                    ),
                    itemCount: addCart.length,
                  ),
                ),
        ],
      ),
    );
  }
}

Widget favoriteItemBuilder(Product product, context) {
  double screenHeight = MediaQuery.of(context).size.height;

  return Material(
    borderRadius: BorderRadius.circular(20.0),
    clipBehavior: Clip.hardEdge,
    child: Container(
      color: Colors.white,
      height: screenHeight / 4.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.image,
            height: screenHeight / 4.5,
            width: screenHeight / 4.5,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0, right: 30.0),
                            child: Text(
                              product.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${product.price.toString()}\$',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
