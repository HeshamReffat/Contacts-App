import 'package:contacts_app/providers/Database.dart';
import 'package:contacts_app/screens/AddNewContact.dart';
import 'package:contacts_app/screens/ViewContact.dart';
import 'package:contacts_app/shared/components/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  List<Map> list;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = DataBase();
    db.createDatabase().then((value) {
      if (value != null) {
        data = value;
        db.getData(value).then((value) {
          //print(value);
          setState(() {
            list = value;
          });
        });
      } else {
        Fluttertoast.showToast(
            msg: 'There is no Contact', timeInSecForIosWeb: 5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Icon(Icons.account_circle,color: Colors.black,size: 40,),
        ),
        backgroundColor: Colors.white,
        title: Container(
          height: 40.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: customFormField(
              controller: searchController,
              type: TextInputType.text,
              hint: 'Search Contacts',
              changed: (s) {
                var database = DataBase();
                database.searchContact(data, s).then((value) {
                  setState(() {
                    list = value;
                  });
                });
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddContact(
                    db: data,
                  )),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                //physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) => list != null
                    ? buildItem(list[i])
                    : Center(child: CircularProgressIndicator()),
                separatorBuilder: (ctx, i) => Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: list?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(Map data) {
    var db = this.data;
    return InkWell(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ViewContact(
            info: data,
            db: db,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  '${data['image']}',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${data['name']}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
