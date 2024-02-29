import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:glass_plate/home_screen.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart' as gen_ai;

class ResultScreen extends StatefulWidget {
  final String? imagePath;

  const ResultScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  final apiKey = 'AIzaSyDZxuXqjDiMk9H4QwPrNoZ-7F_xwD87oUI';

  // State variables
  String foodName = 'N/A';
  String portion = 'N/A';
  String co2Emissions = 'N/A';
  String scarceWater = 'N/A';
  String seasonRating = 'N/A';
  String overallRating = 'N/A';
  String alternativeFood = 'N/A';
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFoodInfo();
  }

  // Assuming this function is inside a class
  void getFoodInfo() async {
    setState(() {
      _loading = true;
    });
    // For text-and-image input (multimodal), use the gemini-pro-vision model
    final model =
        gen_ai.GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
    final firstImage = await File(widget.imagePath!).readAsBytes();
    String promptDescription =
        'Please give me this information: foodName, co2Emissions,portion, '
        'scarceWater, seasonRating 1-10, overallRating from 1-10, alternativeFood '
        'as a json format.';
    final prompt = gen_ai.TextPart(promptDescription);
    final imageParts = [
      gen_ai.DataPart('image/jpeg', firstImage),
    ];
    final response = await model.generateContent([
      gen_ai.Content.multi([prompt, ...imageParts])
    ]);

    // Clean the response text by removing "```json" and "```"
    String cleanedResponse =
        response.text!.replaceAll('```json', '').replaceAll('```', '').trim();

    // Parse the cleaned response into a map
    Map<String, dynamic> foodInfo = jsonDecode(cleanedResponse);

    print(foodInfo);
    // Assign values to variables
    setState(() {
      _loading = false;
      foodName = '${foodInfo['foodName']}' ?? '';
      co2Emissions = '${foodInfo['co2Emissions']}' ?? '';
      portion = '${foodInfo['portion']}' ?? '';
      scarceWater = '${foodInfo['scarceWater']}' ?? '';
      seasonRating = '${foodInfo['seasonRating']}' ?? '';
      overallRating = '${foodInfo['overallRating']}' ?? '';
      alternativeFood = '${foodInfo['alternativeFood']}' ?? '';
    });

    // Now you can use these variables as needed in your application
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.imagePath != null)
                    Image.file(File(widget.imagePath!)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            _buildInfoRow('Food', foodName, Colors.black45),
                            _buildInfoRow('Amount', portion, Colors.black45),
                            _buildInfoRow('CO2 Emissions', co2Emissions, Colors.grey),
                            _buildInfoRow('Scarce Water', scarceWater, Colors.blue),
                            _buildInfoRow('Season Rating', seasonRating, Colors.lightGreen),
                            _buildInfoRow('Overall Rating', overallRating, Colors.pink),
                            _buildInfoRow('Alternative Food', alternativeFood, Colors.green),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //getFoodInfo();
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            child: Text('Okay'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String fieldName, String value, var valueColor) {
    return Row(
      children: [
        Expanded(
          flex: 60,
          child: Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center, // Centers the Text widget inside the Container
            padding: EdgeInsets.all(8), // Adjust padding as needed
            decoration: BoxDecoration(
              border: Border.all(
                color: valueColor, // Color of the border
                width: 2, // Width of the border
              ),
              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
            ),
            child: Text('$fieldName', style: TextStyle(fontSize: 20)),
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
                color: valueColor, // Color of the border
                width: 2, // Width of the border
              ),
              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
            ),
            child: Text('$value', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
