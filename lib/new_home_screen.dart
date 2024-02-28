import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlassPlate Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$co2Saved CO2 saved', style: TextStyle(fontSize: 18)),
                  Text('$waterSaved of scarce water', style: TextStyle(fontSize: 18)),
                  Text('$percentageSaved less than last week', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Beating the average US resident by $beatingUSAverage', style: TextStyle(fontSize: 18)),
                  Text('Because you choose food rated at $foodRating', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: 60.0,
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    // TODO: Navigate to camera screen
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
