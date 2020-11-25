import 'package:contacts_app/providers/Database.dart';
import 'package:contacts_app/screens/AddNewContact.dart';
import 'package:contacts_app/screens/ViewContact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  List<Map> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = DataBase();
    db.createDatabase().then((value) {
      if (value != null) {
        data = value;
        db.getData(value).then((value) {
          list = value;
          //print(value);
          setState(() {});
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
        title: Text('Contacts'),
        leading: Icon(Icons.account_circle),
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
      body: ListView.separated(
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
    );
  }

  Widget buildItem(Map data) {
    var db = this.data;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ViewContact(
              info: data,
              db: db,
            ),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                '${data['image']}',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${data['name']}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
