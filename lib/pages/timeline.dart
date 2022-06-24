// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pic_share/models/user.dart';
import 'package:pic_share/pages/home.dart';
import 'package:pic_share/pages/search.dart';
import 'package:pic_share/widgets/header.dart';
import 'package:pic_share/widgets/post.dart';
import '../widgets/progress.dart';
import '../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User? currentUser;

  Timeline({required this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
   List<Post> posts = [];
  List<String> followingList = [];

  @override
  void initState() {
    super.initState();
    getTimeline();
    getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .doc(widget.currentUser!.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .get();
    List<Post> posts =
        snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .doc(currentUser!.id)
        .collection('userFollowing')
        .get();
    setState(() {
      followingList = snapshot.docs.map((doc) => doc.id).toList();
    });
  }

  buildTimeline() {
    if (posts == null) {
      return circularProgress();
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      return ListView(children: posts);
    }
  }

  buildUsersToFollow() {
   return StreamBuilder<QuerySnapshot>(
      stream:
         usersRef.orderBy('timestamp', descending: true).limit(30).snapshots(),
          builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data!.docs.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser!.id == user.id;
         bool isFollowingUser = followingList.contains(user.id);
          // remove auth user from recommended list
          if (isAuthUser) {
            return;
          } if (isFollowingUser) {
            return;
          }
           else {
            UserResult userResult = UserResult(user);
            userResults.add(userResult);
          }
        });
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person_add,
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Follow Suggestions",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            Column(children: userResults),
          ],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
       key: _scaffoldKey,
        appBar: header(context, isAppTitle: true, titleText: ''),
        body: SingleChildScrollView(
          child: RefreshIndicator(
              onRefresh: () => getTimeline(), child: buildTimeline()),
        ));
  }
}
