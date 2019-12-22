import 'package:flutter/material.dart';
import './profile.dart';
import './list_item.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String appBarTitle = 'الرئيسيه';
  String mainPage = 'الرئيسيه';
  String profilePage = 'حسابي';
  String textFieldContent = '';
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: 'حسابي'),
      Tab(text: 'الرئيسيه'),
    ];

    TabController _tabController;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(vsync: this, length: myTabs.length);
    }

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 12.0),
              child: Text(
                appBarTitle,
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
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab) {
            final String label = tab.text;
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
    List<Card> cards = [];
    AlertDialog blogDialog = AlertDialog(
      content: buildDialog(),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
            color: Colors.green,
            height: 30.0,
            child: RaisedButton(
              elevation: 5.0,
              child: Text(
                'نشر',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  cards.add(buildListItem(textFieldContent));
                  print('${cards.length} from el nashr');
                });
                Navigator.of(myContext).pop();
                controller.clear();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 60.0),
          child: FlatButton(
            child: Text('تجاهل'),
            onPressed: () => Navigator.of(myContext).pop(),
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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (myContext, int Index) {
                      return ListTile(
                        title: cards[Index],
                      );
                    }),
              ),
            ],
          ),
        )
        );
  }

  Widget buildDialog() {
    return Container(
      height: 300.0,
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.black12,
              height: 150.0,
              width: double.infinity,
              child: Column(
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
              )),
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
          //Text('اكتب تعليقا حول الصوره'ئ, textDirection: TextDirection.rtl,),
          Expanded(
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: controller,
              maxLines: 3,
              maxLength: 200,
              autocorrect: true,
              autofocus: true,
              cursorColor: Colors.black26,
              onSubmitted: (val) {
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
