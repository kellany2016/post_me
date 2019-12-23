import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './profile.dart';
import './list_item.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String mainPage = 'الرئيسيه';
  String profilePage = 'حسابي';
  String textFieldContent = '';
  TextEditingController controller = new TextEditingController();
  List<Card> cards = [];

  File _image;
  String tabName;

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: 'حسابي'),
      Tab(text: 'الرئيسيه'),
    ];

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 12.0),
              child: Text(
                tabName == mainPage ? mainPage : profilePage,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.menu,
                size: 30.0,
              ),
            ),
          ],
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            final String label = tab.text;
            tabName = tab.text;
            return mainPage == label
                ? _buildMainPage(context)
                : _buildProfile();
          }).toList(),
        ),
      ),
    );
  }

// صفحة حسابي
  Widget _buildProfile() {
    IconData icon1 = Icons.star;
    IconData icon2 = Icons.settings;
    IconData icon3 = Icons.edit;
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        buildCoverImage(screenSize),
        SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize.height / 6.4),
              buildProfileImage(),
              buildName(),
              buildEmail(),
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildRowItems(icon1, 'المفضله'),
                    buildRowItems(icon2, 'الإعدادات'),
                    buildRowItems(icon3, 'تعديل بياناتي'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

// الرئيسيه
  Widget _buildMainPage(BuildContext myContext) {
    AlertDialog blogDialog = AlertDialog(
      content: buildDialog(),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.green,
            child: Text(
              'نشر',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                cards.add(buildListItem(textFieldContent, _image));
              });
              Navigator.of(myContext).pop();
              _image = null;
              controller.clear();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 60.0),
          child: FlatButton(
            child: Text('تجاهل'),
            onPressed: () {
              Navigator.of(myContext).pop();
              controller.clear();
              _image = null;
            },
          ),
        )
      ],
    );
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF39796b),
            onPressed: () => showDialog(
                context: myContext, builder: (myContext) => blogDialog)),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (myContext, int index) {
                    return cards[index];
                  }),
            ),
          ],
        ));
  }

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
    Toast.show('لقد تم التقاط صورتك ، اترك تعليق ثم اضغط نشر', context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
    Toast.show('لقد تم التقاط صورتك ، اترك تعليق ثم اضغط نشر', context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green);
  }

  Widget buildDialog() {
    Size screenSize = MediaQuery.of(context).size;
    SimpleDialog photoDialog = SimpleDialog(
      title: Text('Pick a photo'),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                'التقط صوره',
                textDirection: TextDirection.rtl,
              ),
              onPressed: getImageFromCam,
            ),
            FlatButton(
              child: Text(
                'صوره من الهاتف',
                textDirection: TextDirection.rtl,
              ),
              onPressed: getImageFromGallery,
            )
          ],
        ),
      ],
    );
    return Container(
      height: screenSize.height / 3.0,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) => photoDialog);
            },
            child: Container(
              color: Colors.black12,
              height: 150.0,
              width: double.infinity,
              child: _image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_camera,
                          color: Colors.grey,
                        ),
                        Text(
                          'Upload Photo',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        )
                      ],
                    )
                  : Image.file(_image),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'اكتب تعليقا حول الصوره',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              )
            ],
          ),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: controller,
              maxLines: 3,
              maxLength: 200,
              autocorrect: true,
              autofocus: true,
              cursorColor: Colors.black26,
              onChanged: (val) {
                setState(() {
                  textFieldContent = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
