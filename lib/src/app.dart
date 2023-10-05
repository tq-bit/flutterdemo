import 'package:flutter/material.dart';
import 'package:namer_app/src/pages/GeneratorPage.dart';
import 'package:namer_app/src/pages/FavoritePage.dart';
import 'package:namer_app/src/pages/CameraPage.dart';
import 'package:namer_app/src/pages/GalleryPage.dart';

// Stateful component handling the root widget
class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

// Root widget handling page routing
class _AppState extends State<App> {
  var activePageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    switch (activePageIndex) {
      case 0:
        activePage = GeneratorPage();
        break;
      case 1:
        // activePage = FavoritePage();
        activePage = CameraPage();
        break;
      case 2:
        activePage = GalleryPage();
        break;
      default:
        throw UnimplementedError('No page for $activePageIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sandbox'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: activePage,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: activePageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.text_fields_outlined),
              label: 'Generator',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.favorite),
            //   label: 'Favorites',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Images',
            ),
          ],
          onTap: (index) {
            setState(() {
              activePageIndex = index;
            });
          }),
    );
  }
}
