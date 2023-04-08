import 'package:android/views/tab_bars/camera_recorder.dart';
import 'package:android/views/tab_bars/pick_file.dart';
import 'package:android/views/tab_bars/search.dart';
import 'package:android/views/tab_bars/settings.dart';
import 'package:android/views/video%20feed%20page/video_feed_player.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController cont;
  @override
  void initState() {
    cont = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        indicatorColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        controller: cont,
        tabs: const [
          SizedBox(
            height: 50,
            child: Icon(
              Icons.home,
            ),
          ),
          SizedBox(
            height: 50,
            child: Icon(Icons.search),
          ),
          SizedBox(
            height: 50,
            child: Icon(Icons.camera),
          ),
          SizedBox(
            height: 50,
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: TabBarView(
        controller: cont,
        children:const  [
           VideoFeed(),
           Search(),
           PickFile(),
           Settings(),
        ],
      ),
    );
  }
}
