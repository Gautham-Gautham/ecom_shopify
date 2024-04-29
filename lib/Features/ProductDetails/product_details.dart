import 'package:ecom_app/Models/product_model.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/Common/custom_snackbar.dart';
import '../ProductScreen/Screens/product_screen.dart';
import '../ProductScreen/sq_flight.dart';

class ProductDetails extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  int count = 1;
  final countProvider = StateProvider(
    (ref) => 1,
  );
  double lastAmt = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Shopify",
              style: GoogleFonts.poppins(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              width: w,
              height: h,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: h * 0.4,
                      width: w,
                      child: Image.network(widget.product.image),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Text(
                      widget.product.title,
                      style: GoogleFonts.poppins(
                          fontSize: w * 0.06, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (count > 1) {
                                  count--;
                                  ref.read(countProvider.notifier).update(
                                        (state) => count,
                                      );
                                  lastAmt = double.parse(widget.product.price) *
                                      ref.watch(countProvider).toDouble();
                                }
                                // if (ref.watch(infProvider1) > 0) {
                                //   ref
                                //       .read(infProvider1.notifier)
                                //       .update((state) => state - 1);
                                // }
                              },
                              child: Container(
                                width: w * 0.15,
                                height: h * 0.04,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange),
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(w * 0.05),
                                        bottomLeft: Radius.circular(w * 0.05))),
                                child: Center(
                                  child: Text("-",
                                      style: GoogleFonts.poppins(
                                          fontSize: w * 0.06,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            Container(
                              width: w * 0.15,
                              height: h * 0.04,
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                border: Border(
                                    top: BorderSide(color: Colors.orange),
                                    bottom: BorderSide(color: Colors.orange)),
                              ),
                              child: Center(
                                child: Text(ref.watch(countProvider).toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: w * 0.06,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                count++;
                                ref.read(countProvider.notifier).update(
                                      (state) => count,
                                    );
                                lastAmt = double.parse(widget.product.price) *
                                    count.toDouble();

                                // if (ref.read(adtProvider1) >
                                //     ref.read(infProvider1)) {
                                //   ref
                                //       .read(infProvider1.notifier)
                                //       .update((state) => state + 1);
                                // }
                              },
                              child: Container(
                                  width: w * 0.15,
                                  height: h * 0.04,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.orange),
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(w * 0.05),
                                          bottomRight:
                                              Radius.circular(w * 0.05))),
                                  child: Center(
                                    child: Text("+",
                                        style: GoogleFonts.poppins(
                                            fontSize: w * 0.06,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                  )),
                            ),
                            const Spacer(),
                            Text(
                              '${(count * double.parse(widget.product.price)).toStringAsFixed(2)}\$',
                              style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontSize: w * 0.05,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Text(
                      widget.product.description,
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            var addCartCopy =
                                List.from(addCart); // Create a copy of addCart
                            bool isItemAlreadyInCart = false;

                            if (widget.product.cart == 1) {
                              for (var i in addCartCopy) {
                                if (i.id == widget.product.id) {
                                  // If the item is already in the cart, update its cart value and remove it
                                  // product.cart = 0;
                                  addCart.removeWhere((element) =>
                                      element.id == widget.product.id);
                                  ref
                                      .watch(sqflightProvider)
                                      .deleteData(id: widget.product.id);
                                  customSnackbar(context, 'removed');
                                  // cart = false;

                                  isItemAlreadyInCart =
                                      true; // Set the flag to true
                                  break; // Exit the loop
                                }
                              }
                            } else {
                              if (!isItemAlreadyInCart) {
                                widget.product.cart = 1;
                                addCart.add(widget.product);
                                ref
                                    .watch(sqflightProvider)
                                    .insertData(product: widget.product);
                                // cart = true;

                                customSnackbar(context, 'added');
                              }
                            }
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(w * 0.8, h * 0.06)),
                          child: Text(
                            widget.product.cart == 0
                                ? 'Add To Cart'
                                : 'Remove From Cart',
                            style: GoogleFonts.poppins(
                                fontSize: w * 0.05,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
