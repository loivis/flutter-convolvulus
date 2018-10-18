import 'package:convvls/screen/favorite.dart';
import 'package:convvls/screen/rank.dart';
import 'package:convvls/screen/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://github.com/felipecarvalho/flutterstarter/blob/master/lib/main.dart

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  int _activeTab = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBNB(),
      drawer: _buildDrawer(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.portrait, size: 30.0),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(_tabs[_activeTab].title),
    );
  }

  PageView _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: <Widget>[
        FavoritePage(),
        SearchPage(),
        RankPage(),
      ],
    );
  }

  Widget _buildBNB() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        currentIndex: _activeTab,
        onTap: _onTap,
        items: _tabs.map((tab) {
          return BottomNavigationBarItem(
            title: Text(tab.title),
            icon: Icon(tab.icon),
          );
        }).toList(),
      );
    }
    return BottomNavigationBar(
      currentIndex: _activeTab,
      onTap: _onTap,
      items: _tabs.map((tab) {
        return BottomNavigationBarItem(
          title: Text(tab.title),
          icon: Icon(tab.icon),
        );
      }).toList(),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Center(
                child: FlutterLogo(
                  colors: Theme.of(context).primaryColor,
                  size: 75.0,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/settings');
              }),
          ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/about');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _onPageChanged(int tab) {
    setState(() {
      this._activeTab = tab;
    });
  }

  void _onTap(int tab) {
    _pageController.jumpToPage(tab);
  }
}

class _PageTab {
  const _PageTab({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<_PageTab> _tabs = const <_PageTab>[
  _PageTab(title: '收藏', icon: Icons.favorite_border),
  _PageTab(title: '搜索', icon: Icons.search),
  _PageTab(title: '排行', icon: Icons.library_books),
];
