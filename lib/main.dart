// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shrine/Provider/AuthProvider.dart';
import 'package:shrine/Provider/PostProvider.dart';
import 'package:shrine/Provider/ProfileProvider.dart';
import 'package:shrine/src/comments.dart';
import 'Provider/CommentProvider.dart';
import 'app.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApplicationState>(
            create: (_) => ApplicationState()),
        ChangeNotifierProvider<PostProvider>(
            create: (_) => PostProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider()),
        ChangeNotifierProvider<CommentProvider>(
            create: (_) => CommentProvider ("")),
      ],
      child: ShrineApp(),
    );
  }
}
