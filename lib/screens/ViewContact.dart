import 'package:contacts_app/providers/Database.dart';
import 'package:contacts_app/screens/HomeScreen.dart';
import 'package:contacts_app/shared/components/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddNewContact.dart';

class ViewContact extends StatefulWidget {
  ViewContact({this.info, this.db});

  var info;
  var database = DataBase();
  var db;

  @override
  _ViewContactState createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Contact Info',
          style: TextStyle(color: Colors.black),
        ),
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
              Icons.edit,
              color: Colors.green,
            ),
            onPressed: () => updateContact(context),
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Contact'),
                        content: Text(
                            'Are You Sure Delete Contact ${widget.info['name']}'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              var delete = DataBase();
                              delete.deleteContact(
                                  database: widget.db,
                                  name: '${widget.info['name']}');
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
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        '${widget.info['image']}',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  '${widget.info['name']}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone,
                              size: 40,
                              color: Colors.blue,
                            ),
                            Center(
                                child: Text(
                              ': ${widget.info['number1']}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.home,
                              size: 40,
                              color: Colors.blue,
                            ),
                            Center(
                                child: Text(
                              ': ${widget.info['number2']}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.alternate_email,
                              size: 40,
                              color: Colors.blue,
                            ),
                            Center(
                                child: Text(
                              ': ${widget.info['address']}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 10,
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
            title: Center(child: Text('Edit Contact')),
            content: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                              controller: imageController
                                ..text = '${widget.info['image']}',
                              type: TextInputType.url,
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
                              controller: nameController
                                ..text = '${widget.info['name']}',
                              type: TextInputType.name,
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
                              controller: number1Controller
                                ..text = '${widget.info['number1']}',
                              type: TextInputType.number,
                              isPassword: false,
                              valid: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a number';
                                }
                                if (value == null) {
                                  return 'Please enter a valid number';
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
                            Icons.home,
                            color: Colors.blue,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: customFormField(
                              controller: number2Controller
                                ..text = '${widget.info['number2']}',
                              type: TextInputType.number,
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
                              controller: addressController
                                ..text = '${widget.info['address']}',
                              type: TextInputType.emailAddress,
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
                      SizedBox(
                        height: 20,
                      ),
                      customButton(
                          text: 'Save',
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
                              Fluttertoast.showToast(
                                  msg: 'please complete fields');
                              return;
                            }
                            widget.database
                                .updateContact(
                              database: widget.db,
                              image: image,
                              name: name,
                              number1: int.parse(number1),
                              number2: int.parse(number2),
                              address: address,
                              id: widget.info['id'],
                            )
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: 'Contact Updated Successfully',
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()));
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      customButton(
                        text: 'Cancel',
                        function: () => Navigator.of(context).pop(),
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
