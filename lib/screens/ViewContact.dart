import 'package:contacts_app/providers/Database.dart';
import 'package:contacts_app/screens/HomeScreen.dart';
import 'package:contacts_app/shared/components/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddNewContact.dart';

class ViewContact extends StatelessWidget {
  ViewContact({this.info, this.db});

  var info;
  var db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => updateContact(context),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Contact'),
                        content:
                            Text('Are You Sure Delete Contact ${info['name']}'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              var delete = DataBase();
                              delete.deleteContact(
                                  database: db, name: '${info['name']}');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => HomeScreen()));
                            },
                            child: Text('Yes'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    });
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Card(
                elevation: 8,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          '${info['image']}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[100],
                                ),
                                child: Center(
                                    child: Text(
                                  '${info['name']}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Phone : ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[100],
                                ),
                                child: Center(
                                    child: Text(
                                  '${info['number1']}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Home: ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[100],
                                ),
                                child: Center(
                                    child: Text(
                                  '${info['number2']}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Email: ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey[100],
                                ),
                                child: Center(
                                    child: Text(
                                  '${info['address']}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateContact(BuildContext context) {
    var database = DataBase();
    final _form = GlobalKey<FormState>();
    TextEditingController imageController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController number1Controller = TextEditingController();
    TextEditingController number2Controller = TextEditingController();
    TextEditingController addressController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Contact'),
            content: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                          text: 'Update',
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
                            String oldName = info['name'];
                            if (image.isEmpty ||
                                name.isEmpty ||
                                number1.isEmpty ||
                                address.isEmpty) {
                              Fluttertoast.showToast(msg: 'please complete fields');
                              return;
                            }
                            database
                                .updateContact(
                              database: db,
                              image: image,
                              name: name,
                              number1: int.parse(number1),
                              number2: int.parse(number2),
                              address: address,
                              oldName: oldName,
                            )
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: 'Contact Updated Successfully',
                                  backgroundColor: Colors.green);
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
          );
        });
  }
}
