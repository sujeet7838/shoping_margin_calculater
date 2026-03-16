import 'package:calculater/model/subcripationModel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<DemoProduct> demoProducts = [
    DemoProduct(
      id: "monthly_subscription",
      title: "Monthly Premium",
      price: "₹199 / month",
    ),
    DemoProduct(
      id: "yearly_subscription",
      title: "Yearly Premium",
      price: "₹1499 / year",
    ),
  ];

  // final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  // late Stream<List<PurchaseDetails>> _subscription;

  // List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    // _initialize();
  }

  // Future<void> _initialize() async {

  //   final bool available = await _inAppPurchase.isAvailable();

  //   if (!available) return;

  //   const Set<String> ids = {'monthly_subscription'};

  //   ProductDetailsResponse response =
  //       await _inAppPurchase.queryProductDetails(ids);

  //   setState(() {
  //     _products = response.productDetails;
  //   });
  // }

  // void _buySubscription(ProductDetails product) {
  //   final PurchaseParam purchaseParam =
  //       PurchaseParam(productDetails: product);

  //   _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monthly Subscription")),
      body: ListView.builder(
        itemCount: demoProducts.length,
        itemBuilder: (context, index) {
          final product = demoProducts[index];

          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.price),
            trailing: ElevatedButton(
              onPressed: () {
                print("Buy ${product.id}");
                bool serviceAvailable = false;

                if (!serviceAvailable) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Service available nahi hai"),
                      duration: Duration(seconds: 5),
                    ),
                  );
                  return;
                }
              },
              child: Text("Subscribe"),
            ),
          );
        },
      ),
    );
  }
}
