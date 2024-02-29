import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'camera_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String co2Saved = '300g';
  String waterSaved = '300L';
  String percentageSaved = '25%';
  String beatingUSAverage = '75%';
  String foodRating = '7/10';

  @override
  void initState() {
    super.initState();
    var rng = Random();

    co2Saved = '1842 grams'; // Random value between 0g to 499g
    waterSaved = '791 L'; // Random value between 0L to 999L
    percentageSaved = '32%'; // Random value between 0% to 99%
    beatingUSAverage = '47%!'; // Random value between 0% to 99%
    foodRating = '8/10'; // Random value between 1/10 to 10/10
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hey Camus! Today You Used'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 70,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center, // Centers the Text widget inside the Container
                      width: double.infinity, // Makes the Container as wide as the parent
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Color of the border
                          width: 2, // Width of the border
                        ),
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      ),
                      child: Text('$co2Saved in CO2', style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center, // Centers the Text widget inside the Container
                      width: double.infinity, // Makes the Container as wide as the parent
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Color of the border
                          width: 2, // Width of the border
                        ),
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      ),
                      child: Text('$waterSaved in scarce Water', style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('$percentageSaved', style: TextStyle(fontSize: 28)),
                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('Less than last Week', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 60,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('Beating the Average US Resident By', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Expanded(
                          flex: 40,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('$beatingUSAverage', style: TextStyle(fontSize: 28)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 60,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('Because you choose your plates rated at ≈', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Expanded(
                          flex: 40,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center, // Centers the Text widget inside the Container
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red, // Color of the border
                                width: 2, // Width of the border
                              ),
                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                            ),
                            child: Text('$foodRating', style: TextStyle(fontSize: 28)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: 100.0,
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    print("Test");
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  },
                ),
                Text('Food Multi-Scan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('Know the impact of your plate', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
