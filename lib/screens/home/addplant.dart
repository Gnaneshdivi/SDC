import 'dart:io';

import 'package:PLANTIFY/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Addplant extends StatefulWidget {
  @override
  _AddplantState createState() => _AddplantState();
}

Color backgroundColor = Color.fromRGBO(130, 205, 113, 1);

class _AddplantState extends State<Addplant> {
  File _image2;
  File _image3;
  final picker = ImagePicker();
  File _image;
  String type = '';

  List _outputs;

  bool _loading = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        classifyImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      type = output[0]['label'];
      print(output[0]['label']);
    });
  }

  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.06),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        '<- Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide > 400
                                  ? 18
                                  : 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.08),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        children: [
                          Text(
                            'ADD  PLANT',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide > 400
                                      ? 25
                                      : 18,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: width * 0.2,
                            color: Colors.brown,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                getImage();
                              });
                              setState(() {});
                            },
                            child: Container(
                              child: _image == null
                                  ? Center(
                                      child: Text(
                                      ' PLANT IMAGE',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ))
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                      height: height * 0.08,
                                      width: width * 0.20,
                                    ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              height: height * 0.1,
                              width: width * 0.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                if (pickedFile != null) {
                                  _image2 = File(pickedFile.path);
                                } else {
                                  print('No image selected.');
                                }
                              });
                              setState(() {});
                            },
                            child: Container(
                              child: _image2 == null
                                  ? Center(
                                      child: Text(
                                      'PLANTING',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ))
                                  : Image.file(
                                      _image2,
                                      fit: BoxFit.cover,
                                      height: height * 0.08,
                                      width: width * 0.20,
                                    ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              height: height * 0.1,
                              width: width * 0.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                if (pickedFile != null) {
                                  _image3 = File(pickedFile.path);
                                } else {
                                  print('No image selected.');
                                }
                              });
                              setState(() {});
                            },
                            child: Container(
                              child: _image3 == null
                                  ? Center(
                                      child: Text(
                                      'LEAF',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ))
                                  : Image.file(
                                      _image3,
                                      fit: BoxFit.cover,
                                      height: height * 0.08,
                                      width: width * 0.20,
                                    ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              height: height * 0.1,
                              width: width * 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      " * Nick Name",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.grey),
                        onChanged: (value) {},
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "NICK NAME",
                          hintStyle:
                              TextStyle(color: Colors.green, fontSize: 10),
                          border: InputBorder.none,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: width * 0.5,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      " * Type",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.grey),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: type,
                          hintStyle:
                              TextStyle(color: Colors.green, fontSize: 10),
                          border: InputBorder.none,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: width * 0.5,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      " * ADD ANY STORY ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 28),
                          child: Row(
                            children: [
                              Container(
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                  onChanged: (value) {},
                                  cursorColor: Colors.blue,
                                  decoration: InputDecoration(
                                    hintText: "YOUR STORY HERE",
                                    hintStyle: TextStyle(
                                        color: Colors.green, fontSize: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: width * 0.6,
                                height: height * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: width * 0.5,
                        child: Center(
                            child: Text(
                          "PLANT",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.brown[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: -120,
              right: 0,
              child: Image.asset(
                'assets/plants4.png',
                height: height * 0.4,
              ))
        ],
      ),
    );
  }
}
