import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostic_app/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:diagnostic_app/models/diagnostic_tests.dart';

class DiagonsticItem extends StatelessWidget {
  final DiagnosticTests diagnositcTests;

  DiagonsticItem(this.diagnositcTests);

  Widget keyValueBuilder(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value == null ? " " : value)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.white70,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    keyValueBuilder('Test Name', diagnositcTests.test),
                    keyValueBuilder('Test Code', diagnositcTests.test_code),
                    keyValueBuilder(
                        'Test Description', diagnositcTests.specimen),
                    keyValueBuilder('Rep Time', diagnositcTests.rep_time),
                    keyValueBuilder(
                        'B2B Rate', diagnositcTests.b2b_rate.toString()),
                    keyValueBuilder('MRP', diagnositcTests.mrp.toString())
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  ProductEdit(diagnositcTests.id)));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Firestore.instance
                          .collection("products")
                          .document(diagnositcTests.id)
                          .delete();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
