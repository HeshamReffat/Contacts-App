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
        title: Text('Add New Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _form,
            child: Card(
              color: Colors.grey[100],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customFormField(
                    controller: imageController,
                    type: TextInputType.url,
                    hint: 'Enter image Url',
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
                  SizedBox(
                    height: 20,
                  ),
                  customFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    hint: 'Enter Name',
                    isPassword: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customFormField(
                    controller: number1Controller,
                    type: TextInputType.number,
                    hint: 'Enter Number',
                    isPassword: false,
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a number';
                      }
                      if (value == null) {
                        return 'Please enter a valid number';
                      }
                      if (value.length < 12) {
                        return 'Please enter a Complete phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customFormField(
                    controller: number2Controller,
                    type: TextInputType.number,
                    hint: 'Add Home number',
                    isPassword: false,
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a number';
                      }
                      if (value == null) {
                        return 'Please enter a valid number';
                      }
                      if (value.length < 12) {
                        return 'Please enter a Complete phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customFormField(
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
                  SizedBox(
                    height: 20,
                  ),
                  customButton(
                      text: 'Add',
                      function: () {
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
                              msg: 'Contact Added Successfully',backgroundColor: Colors.green);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  customButton(
                    text: 'Cancel',
                    function: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    ),
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
