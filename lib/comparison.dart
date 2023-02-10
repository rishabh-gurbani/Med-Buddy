import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Prices {
  Prices({required this.A, required this.P, required this.T});

  final A, P, T;

  factory Prices.fromJson(Map<String, dynamic> json) {
    var fetched = [json['Apollo'], json['PharmEasy'], json['Tata']];
    return Prices(A: fetched[0], P: fetched[1], T: fetched[2]);
  }
}

class Comparison extends StatefulWidget {
  const Comparison({Key? key}) : super(key: key);

  @override
  State<Comparison> createState() => _ComparisonState();
}

class _ComparisonState extends State<Comparison> {

  var names = ['Apollo', 'PharmEasy', 'Tata1MG'];
  var paths = ['unnamed (1).png', 'unnamed.jpg', 'unnamed.png'];

  var price;

  StreamController streamController = StreamController();

  TextEditingController controller = TextEditingController();

  var prices = [];

  bool showPrices = false;

  Future checkPrices(String name) async {
    Map<String, dynamic> map = {'med': name};
    print('hi');

    final response =
    await http.post(Uri.parse('https://meds-prices-scraping.onrender.com/prices'), body: map);
    var pricesList = Prices.fromJson(jsonDecode(response.body));
    setState(() {
      prices.add(pricesList.A);
      prices.add(pricesList.P);
      prices.add(pricesList.T);
      showPrices = true;
    });
    print("${pricesList.A}, ${pricesList.P}, ${pricesList.T}");
    return pricesList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[0],
      appBar: AppBar(
        title: Text("Meds Comparison"),
        actions: [IconButton(onPressed:() => FirebaseAuth.instance.signOut(), icon: Icon(Icons.exit_to_app))],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      showPrices = false;
                      prices = [];
                    });
                  },
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: "Enter Medicine Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      showPrices = false;
                      prices = [];
                    });

                    await checkPrices(controller.text.trim());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15),
                      child: Text('Check', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
              if (showPrices)
                Expanded(
                  child: FutureBuilder<Map<String, dynamic>>(
                      future: price,
                      builder: (context, snapshot) {
                        {
                          return ListView.builder(
                              itemCount: prices.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      String url = prices[index][1];
                                      var urllaunchable =
                                      await canLaunchUrl(Uri.parse(url));
                                      print(urllaunchable);
                                      if (urllaunchable) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        print("URL can't be launched.");
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.purple,
                                              width: 2
                                            ),
                                            color: Colors.grey[100],
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                            'assets/img/${paths[index]}'),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            .0),
                                                        child: Text(
                                                            (names[index]),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                13)),
                                                      ),
                                                    ],
                                                  ),
                                                  const Expanded(
                                                    flex: 5,
                                                    child: SizedBox(
                                                      width: 50,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      "₹${prices[index][0]}",
                                                      style:
                                                      const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              });
                        }
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
