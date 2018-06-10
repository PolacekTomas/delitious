import 'package:flutter/material.dart';

import 'recipeGrid.dart';

class DelitiousApp extends StatelessWidget {
  DelitiousApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "deliTious",
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white), //TODO: needed?
        primaryIconTheme: IconThemeData(color: Colors.white),
      ),
      home: new AppLayout(),
    );
  }
}

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => new _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with SingleTickerProviderStateMixin {

  PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'deliTious',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        //TODO: actions: <Widget>[new PopupMenuButton<>(...)],
        //TODO: or add side menu?
      ),
      body: new PageView(
        children: <Widget>[
          new GridRecipeViewer("meat_dish"),
          new GridRecipeViewer("veggie_dish"),
          new GridRecipeViewer("dessert"),
        ],
        controller: _controller,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.fastfood),
            title: new Text("Meat Dish"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.landscape),
            title: new Text("Veggie Dish"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.cake),
            title: new Text("Dessert"),
          ),
        ],
        onTap: onNavigationTapped,
        currentIndex: _index,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._index = page;
    });
  }

  void onNavigationTapped(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}