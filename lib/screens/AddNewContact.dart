import 'package:contacts_app/providers/Database.dart';
import 'package:contacts_app/screens/HomeScreen.dart';
import 'package:contacts_app/shared/components/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContact extends StatelessWidget {
  AddContact({this.db});

  var database = DataBase();
  var db;
  final _form = GlobalKey<FormState>();
  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('New Contact',style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.blue,
              ),
              onPressed: () {
                final isValid = _form.currentState.validate();
                if (!isValid) {
                  return;
                }
                String image = imageController.text;
                String name = nameController.text;
                String number1 = number1Controller.text;
                String number2 = number2Controller.text;
                String address = addressController.text;
                if (image.isEmpty ||
                    name.isEmpty ||
                    number1.isEmpty ||
                    address.isEmpty) {
                  Fluttertoast.showToast(msg: 'please complete fields');
                  return;
                }
                database
                    .insertData(
                        database: db,
                        image: image,
                        name: name,
                        number1: int.parse(number1),
                        number2: int.parse(number2),
                        address: address)
                    .then((value) {
                  Fluttertoast.showToast(
                      msg: 'Contact Added Successfully',
                      backgroundColor: Colors.green);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: customFormField(
                          controller: imageController,
                          type: TextInputType.url,
                          hint: 'Image Url',
                          isPassword: false,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid image Form';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: customFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          hint: 'Full Name',
                          isPassword: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: customFormField(
                          controller: number1Controller,
                          type: TextInputType.number,
                          hint: 'Mobile Number',
                          isPassword: false,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a number';
                            }
                            if (value == null) {
                              return 'Please enter a valid number';
                            }
                            // if (value.length < 12) {
                            //   return 'Please enter a Complete phone number';
                            // }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: customFormField(
                          controller: number2Controller,
                          type: TextInputType.number,
                          hint: 'Home number',
                          isPassword: false,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a number';
                            }
                            if (value == null) {
                              return 'Please enter a valid number';
                            }
                            // if (value.length < 12) {
                            //   return 'Please enter a Complete phone number';
                            // }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alternate_email,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: customFormField(
                          controller: addressController,
                          type: TextInputType.emailAddress,
                          hint: 'Email address',
                          isPassword: false,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a Email';
                            }
                            if (value == null) {
                              return 'Please enter a valid Email';
                            }
                            if (!value.contains("@") &&
                                !value.contains('.com') &&
                                !value.contains('.net')) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
