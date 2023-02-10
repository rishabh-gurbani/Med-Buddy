import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Future<void> listExample() async {
//   firebase_stor result =
//   await firebase_storage.FirebaseStorage.instance.ref().listAll();
//
//   result.items.forEach((firebase_storage.Reference ref) {
//     print('Found file: $ref');
//   });
//
//   result.prefixes.forEach((firebase_storage.Reference ref) {
//     print('Found directory: $ref');
//   });
// }

class Prescriptions extends StatefulWidget {
  const Prescriptions({Key? key}) : super(key: key);

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescriptions'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            CupertinoButton(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple,
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
                      child: Text(
                        'Upload Prescription',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                ),
                onPressed: (){}),
            Image.network("https://firebasestorage.googleapis.com/v0/b/health-test-a7b49.appspot.com/o/pres%2Fpres.png?alt=media&token=ecbf6035-3206-49ab-9ea4-ce7e7df32014")
          ],
        )),
      ),
    );
  }
}
