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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlassPlate'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Today, You Saved',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildStatCard('$co2Saved of CO2', 'CO2 Saved'),
            _buildStatCard('$waterSaved of scarce water', 'Water Saved'),
            _buildPerformanceIndicator('$percentageSaved', 'Less than Last Week'),
            Spacer(),
            _buildScanButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Card(
      child: ListTile(
        title: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(label),
      ),
    );
  }

  Widget _buildPerformanceIndicator(String percentage, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(percentage, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        Text(description),
      ],
    );
  }

  Widget _buildScanButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          print('Navigate to camera screen');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CameraScreen()),
          );
        },
        child: Text('Food Multi-scan\nKnow the impact of your plate', textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
      ),
    );
  }
}
