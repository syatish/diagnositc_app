import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostic_app/models/diagnostic_tests.dart';
import 'package:diagnostic_app/widgets/add_new_product.dart';
import 'package:diagnostic_app/widgets/diagonstic_item.dart';
import 'package:diagnostic_app/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = '/product-screen';

  void _addNewProduct(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddNewProduct(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[Text('data')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("products")
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Loading(
                        indicator: BallGridPulseIndicator(),
                        size: 100,
                        color: Theme.of(context).primaryColor,
                      );
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading...');
                      default:
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot products =
                                snapshot.data.documents[index];

                            return DiagonsticItem(DiagnosticTests(
                              id: products.documentID,
                              b2b_rate: products['b2b_rate'],
                              mrp: products['mrp'],
                              rep_time: products['rep_time'],
                              specimen: products['specimen'],
                              test: products['test'],
                              test_code: products['test_code'],
                            ));
                          },
                        );
                    }
                  }),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewProduct(context),
        tooltip: 'Add Products',
        child: Icon(Icons.add),
      ),
    );
  }
}
