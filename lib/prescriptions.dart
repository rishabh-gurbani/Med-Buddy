import 'package:flutter/material.dart';
import 'package:health_test/prescriptions.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({Key? key}) : super(key: key);

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prescription'),),
      body: Prescriptions(),
    );
  }
}
