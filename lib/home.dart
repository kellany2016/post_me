import 'package:flutter/material.dart';
import './profile.dart';
//import './the_main_page.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String appBarTitle = 'الرئيسيه';
  String mainPage = 'الرئيسيه';
  String profilePage = 'حسابي';

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
            return mainPage == label ? _buildMainPage() : _buildProfile();
          }).toList(),
        ),
      ),
    );
  }

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

  Widget _buildMainPage() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Color(0xFF39796b),
        onPressed: null,// implement the add posts code function.
      ),
    );
  }
}
