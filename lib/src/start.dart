

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrine/src/hot.dart';
import 'package:shrine/src/myProfile.dart';
import 'package:shrine/src/home.dart';

import 'addPost.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedPage = 0;
  File? _image;
  final _pageOptions = [
    HomesPage(),
    HotPage(),
    myProfile()
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: TextButton(
              style: TextButton.styleFrom(),
              child: const Text('Yori \n Jori',
                  style: TextStyle(color: Color(0xFF961D36), fontFamily: 'Yrsa')),
              onPressed: () {}),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey,
                  semanticLabel: 'filter',
                ),
                onPressed: () async{

                  bool check = await getImageFromGallery(ImageSource.gallery);

                  if(check==true){
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => addPostPage(image: _image)));
                  }}) ,

            Builder(
              builder: (context) => IconButton(
                color: Colors.black,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const Padding(
                child: Text('Yori  Jori',
                    style: TextStyle(color: Color(0xFF961D36), fontFamily: 'Yrsa',fontSize: 30)),
                padding: EdgeInsets.only(top: 40, left: 10),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(
                  Icons.people,
                  color: Color(0xFF961D36),
                ),
                title: const Text(
                  'Subscribers',
                  style: TextStyle(color: Color(0xFF961D36)),
                ),
                onTap: ()  async {

                  Navigator.pushNamed(context, '/viewSubscribers');
                },

              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_filter_outlined,
                  color: Colors.black,
                ),
                title: const Text('Posts'),
                onTap: () {
                  // Navigator.pushNamed(context, '/friendlist');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Color(0xFF961D36),
                ),
                title: const Text('Settings'),
                onTap: () {},
              ),


            ],
          ),
        ),

        body: _pageOptions[selectedPage],

        bottomNavigationBar: BottomNavigationBar(

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Hot'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'profile'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.addchart), label: 'Ranking'),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF961D36),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: selectedPage,
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        )
    );

  }
  Future<bool> getImageFromGallery(ImageSource imageSource) async {
    var image = await ImagePicker.platform
        .pickImage(source: imageSource, maxWidth: 650, maxHeight: 100);
    setState(() {
      _image = File(image!.path);
    });
    if (image != null) {
      return true;
    } else {
      return false;
    }
  }

}