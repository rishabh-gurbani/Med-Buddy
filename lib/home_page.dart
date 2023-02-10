import 'package:flutter/material.dart';
import 'package:health_test/prescriptions.dart';
import 'comparison.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  // final List<Widget> _pages = [
  //   PredictScreen(),
  //   HistoryPage(),
  //   UserInfoPage()
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: IndexedStack(
        children: const <Widget>[Comparison(), Prescriptions()],
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigateBottomBar,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.compare), label : "Compare"),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file_rounded), label : "Prescriptions"),
          // BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label : "User"),
      ],

      ),
    );
  }
}

