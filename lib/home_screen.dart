import 'package:flutter/material.dart';
import 'class_1_page.dart';
import 'lkg_page.dart';
import 'ukg_page.dart';

class HomeScreen extends StatefulWidget {
  // static String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownValue = 'LKG';

  void navigateTo() {
    if (dropdownValue == 'LKG') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LKGVideoInfo()));
    } else if (dropdownValue == 'UKG') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UKGVideoInfo()));
    } else if (dropdownValue == 'Class 1') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Class1VideoInfo()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4D7482),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xFFF7F2D8),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4D7482),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 109,
            ),
            const Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('images/logo2.png'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
                child: Text(
              'Prince Convent School',
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  color: Colors.white,
                  fontSize: 30),
            )),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: Colors.black26,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                      color: Color(0xFFF7F2DB),
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: const Color(0xFF1A4048),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'LKG',
                      'UKG',
                      'Class 1',
                      'Class 2',
                      'Class 3',
                      'Class 4',
                      'Class 5'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
              ],
            ),
            const SizedBox(
              height: 303,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF7F2D8),
                  borderRadius: BorderRadius.circular(10)),
              height: 65,
              child: TextButton(
                onPressed: () {
                  navigateTo();
                },
                child: const Text(
                  'Ready to Learn',
                  style: TextStyle(color: Color(0xFF1A4048), fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }
}
