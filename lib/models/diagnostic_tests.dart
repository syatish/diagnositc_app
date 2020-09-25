import 'package:flutter/foundation.dart';

class DiagnosticTests {
  final String id;
  final num b2b_rate;
  final num mrp;
  final String rep_time;
  final String specimen;
  final String test;
  final String test_code;

  const DiagnosticTests({
    @required this.id,
    @required this.b2b_rate,
    @required this.mrp,
    @required this.rep_time,
    @required this.specimen,
    @required this.test,
    @required this.test_code,
  });
}
