import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/circle_image.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/collecting_title.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FocusNode phoneNumberNode;
  File image;
  @override
  void initState() {
    super.initState();
    phoneNumberNode = FocusNode();
  }

  @override
  void dispose() {
    phoneNumberNode.dispose();
    super.dispose();
  }

  void showSimpleDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select Image'),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 15),
                    Text('Camera'),
                  ],
                ),
                onPressed: () {
                  getImage(true);
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.filter),
                    SizedBox(width: 15),
                    Text('Gallery'),
                  ],
                ),
                onPressed: () {
                  getImage(false);
                },
              ),
            ],
          );
        });
  }

  void getImage(bool isCamera) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: (isCamera) ? ImageSource.camera : ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 9,
            child: Column(
              children: [
                CollectingTitle(
                    'Welcome', 'Afew Steps To Complete Your Profile'),
                SizedBox(height: 40),
                Stack(
                  children: [
                    CircleImage.fromFile(image),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: InkWell(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          showSimpleDialog();
                        },
                      ),
                    ),
                  ],
                ),
                Form(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    margin: EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (vlaue) {
                            phoneNumberNode.requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'ex: Ahmed Selem',
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          focusNode: phoneNumberNode,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'ex: ####225',
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
