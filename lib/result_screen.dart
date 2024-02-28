import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ResultScreen extends StatefulWidget {
  final String? imagePath;

  const ResultScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  final openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);

  // State variables
  String foodName = 'N/A';
  String portion = 'N/A';
  String co2Emissions = 'N/A';
  String scarceWater = 'N/A';
  String seasonRating = 'N/A';
  String overallRating = 'N/A';
  String alternativeFood = 'N/A';

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      encodeImageToJsonlFile(widget.imagePath!);
    }
  }

  Future<void> encodeImageToJsonlFile(String imagePath) async {
    try {
      String base64Image = await encodeImageToBase64(imagePath);
      String jsonlFilePath = await createJsonlFile(base64Image);
      // Use jsonlFilePath as needed, for example, to upload to an API
      print("Encoded successfully!");
      print(jsonlFilePath);
    } catch (e) {
      // Handle exceptions
      print('Error encoding image: $e');
    }
  }

  Future<String> encodeImageToBase64(String imagePath) async {
    File file = File(imagePath);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  Future<String> createJsonlFile(String base64Image) async {
    Directory tempDir = await getTemporaryDirectory();
    String jsonlFilePath = '${tempDir.path}/image_data.jsonl';
    File jsonlFile = File(jsonlFilePath);
    String jsonLine = jsonEncode({"image": base64Image});
    await jsonlFile.writeAsString('$jsonLine\n');
    return jsonlFilePath;
  }

  // Future<String> encodeImageToBase64(String imagePath) async {
  //   File file = File(imagePath);
  //   List<int> imageBytes = await file.readAsBytes();
  //   return base64Encode(imageBytes);
  // }
  //
  // Future<String> createJsonlFile(String base64Image, String jsonlFilePath) async {
  //   final Directory extDir = await getApplicationDocumentsDirectory();
  //   final String dirPath = '${extDir.path}/Pictures/flutter_test';
  //   await Directory(dirPath).create(recursive: true);
  //
  //   // Create a unique file name with the current timestamp
  //   final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jsonl';
  //
  //   File jsonlFile = File(filePath);
  //   String jsonLine = jsonEncode({"image": base64Image});
  //   await jsonlFile.writeAsString('$jsonLine\n', mode: FileMode.append);
  //   return jsonlFile.path;
  // }

  void uploadFile(filePath) async {
    // var base64Image = await encodeImageToBase64(widget.imagePath!);
    // var jsonlFilePath = await createJsonlFile(base64Image, 'image.jsonl');
    // print(jsonlFilePath);

    // print(widget.imagePath!);
    // print(widget.imagePath.toString());

    final request = UploadFile(file: FileInfo('/data/user/0/org.glassplate.app.glass_plate/cache/', 'image_data.jsonl'), purpose: 'fine-tune');
    final response = await openAI.file.uploadFile(request).then((value) {
      print("File uploaded successfully");
      chatComplete();
    }).catchError((error) {
      print(error);
    });
    print(response);
  }

  void chatComplete() async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": 'Please describe what the uploaded image is.'})
    ], maxToken: 200, model: Gpt4ChatModel());

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.imagePath != null)
              Image.file(File(widget.imagePath!)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildInfoRow('Food Name', foodName),
                  _buildInfoRow('Portion', portion),
                  _buildInfoRow('CO2 Emissions', co2Emissions),
                  _buildInfoRow('Scarce Water', scarceWater),
                  _buildInfoRow('Season Rating', seasonRating),
                  _buildInfoRow('Overall Rating', overallRating),
                  _buildInfoRow('Alternative Food', alternativeFood),
                  ElevatedButton(
                    onPressed: () {
                      uploadFile('image_data.jsonl');
                    }, child: Text('Test')
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String fieldName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fieldName, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
