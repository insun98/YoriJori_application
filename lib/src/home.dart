
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shrine/src/HomeCard.dart';

import 'package:shrine/search.dart';
import 'dart:io';
import '../Provider/AuthProvider.dart';
import '../src/ItemCard.dart';
import 'package:image_picker/image_picker.dart';
import '../src/hot.dart';
import '../src/login.dart';
import '../src/myProfile.dart';

class HomesPage extends StatefulWidget {
  const HomesPage({Key? key}) : super(key: key);

  @override
  _HomesPageState createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> {

  int _selectedIndex = 0;
  //String profile = " ";
 // String ids = " ";
  bool _isFavorited  = false;



 final List<Widget> _children = [HomesPage(), HotPage(), HomesPage(),  HomesPage()];

  String kind = "한식";
  @override
  Widget build(BuildContext context) {
    ApplicationState postProvider = Provider.of<ApplicationState>(context);
    print("here is homepage");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: TextButton(
            style: TextButton.styleFrom(),
            child: Text('Yori \n Jori',
                style: TextStyle(color: Color(0xFF961D36), fontFamily: 'Yrsa')),
            onPressed: () {}),
        actions: <Widget>[

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF961D36),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/hot');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            default:
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Hot'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.addchart), label: 'Ranking'),
        ],
      ),
      body:Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF961D36),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      '양식',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState((){
                        kind = "양식";
                        postProvider.getTypePost(kind);
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      '한식',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState((){
                        kind = "한식";
                        postProvider.getTypePost(kind);
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      '중식',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState((){
                        kind = "중식";
                        postProvider.getTypePost(kind);
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      '일식',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState((){
                        kind = "일식";
                        postProvider.getTypePost(kind);
                      });
                    },
                  ),
                ],
              ),
            ),
            homeCard(
              posts: postProvider.MyPosts,
              profile: postProvider.profile,
            ),
          ],

        ),
      ),
    );
  }

}