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
  PageController _pageController;
  int _activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_activePage].title),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBNB(),
    );
  }

  PageView _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: <Widget>[
        Favorite(),
        Search(),
        Rank(),
      ],
    );
  }

  Widget _buildBNB() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        currentIndex: _activePage,
        onTap: _onTap,
        items: _pages.map((page) {
          return BottomNavigationBarItem(
            title: Text(page.title),
            icon: Icon(page.icon),
          );
        }).toList(),
      );
    }
    return BottomNavigationBar(
      currentIndex: _activePage,
      onTap: _onTap,
      items: _pages.map((page) {
        return BottomNavigationBarItem(
          title: Text(page.title),
          icon: Icon(page.icon),
        );
      }).toList(),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      this._activePage = page;
    });
  }

  void _onTap(int page) {
    _pageController.jumpToPage(page);
  }
}

class _Page {
  const _Page({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<_Page> _pages = const <_Page>[
  _Page(title: 'Favorite', icon: Icons.favorite_border),
  _Page(title: 'Search', icon: Icons.search),
  _Page(title: 'Rank', icon: Icons.list),
];
