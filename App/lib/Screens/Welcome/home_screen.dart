import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/google_map_Screen.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth/Widgets/catergory_card.dart';
import 'package:flutter_auth/Widgets/bottom_navigation.dart';
import 'package:flutter_auth/Widgets/list_tile.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getsds() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("accident_check/user1");

// Get the Stream

    Stream<DatabaseEvent> stream = ref.onValue;

// Subscribe to the stream!

    stream.listen((DatabaseEvent event) async {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;

      print('Snapshot: ${event.snapshot.value}');
      final extractData = event.snapshot.value;
      print(extractData); // DataSnapshot
      Map<dynamic, dynamic> map = event.snapshot.value as dynamic;
      print("kcnkdwnc");
      print(map['check1'].runtimeType);
      print(map.values.last);
      bool isAccident = false;
      if (map['check1'] == true) {
        print("ssssss");
        await showDialog(
              //show confirm dialogue
              //the return value will be from "Yes" or "No" options
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Can I Call For Emergency'),
                content: Text('for you contact numbers ?'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kActiveIconColor,
                        elevation: 0,
                        minimumSize:
                            Size(100, 40) // put the width and height you want
                        ),
                    onPressed: () {
                      ref.child("check2").set(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    //return false when click on "NO"
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kActiveIconColor,
                        elevation: 0,
                        minimumSize:
                            Size(100, 40) // put the width and height you want
                        ),
                    onPressed: () async {
                      await ref.child("check2").set(true);
                      print("karn is boos");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    //return true when click on "Yes"
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false; //if showDialouge had returned null, then return false

      }
      // list.clear();
      // for (int i = 0; i < map1.length; i++) {
      //   print(map1[i].runtimeType);
      //   final mapCreated = Map.from(map1[i] as Map<Object?, Object?>);
      //   print(mapCreated.keys);
      //   print('working');
      //   print(mapCreated['lat']);
      //   _latlong.add(LatLng(double.parse(mapCreated['lat'].toString()),
      //       double.parse(mapCreated['long'].toString())));
      // }
      // //list = map.values.toList();
      // //print(extractData.toString().length);
      // ;

      // // print("nishani");

      // for (int i = 0; i < _latlong.length; i++) print(_latlong[i]);
      // loadData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getsds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kActiveIconColor,
                      elevation: 0,
                      minimumSize:
                          Size(100, 40) // put the width and height you want
                      ),
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kActiveIconColor,
                      elevation: 0,
                      minimumSize:
                          Size(100, 40) // put the width and height you want
                      ),
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFF5CEB8),
          ),
          drawer: const NavigationDrawer(),
          bottomNavigationBar: BottomNavBar(),
          body: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 45% of our total height
                height: size.height * .40,
                decoration: BoxDecoration(
                  color: Color(0xFFF5CEB8),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Hazard Hunter!",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .95,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          children: <Widget>[
                            CategoryCard(
                              title: "Nearby Accidents",
                              svgSrc: "assets/images/cara.png",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return GoogleMapScreen();
                                  }),
                                );
                              },
                            ),
                            CategoryCard(
                              title: "User Details",
                              svgSrc: "assets/images/sr.png",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MapScreen();
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFF5CEB8), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xFFE6E6E6),
              backgroundImage: AssetImage("assets/images/marker.png"),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Rasathurai Karan',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 15),
            ),

            SizedBox(
              height: 20,
            ),

            // Container(
            //   color: Colors.white,
            //   height: 100,
            //   width: double.infinity,
            //   padding: EdgeInsets.all(10),
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     "Cake Ready!!!",
            //     style: TextStyle(
            //         fontWeight: FontWeight.w900,
            //         fontSize: 32,
            //         color: Theme.of(context).primaryColor),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // CircleAvatar(
            //   radius: 40,
            //   backgroundImage: NetworkImage(user.photoURL!),
            // ),
            SizedBox(
              height: 20,
            ),

            ListTiless(
                title: 'Home',
                icondata: Icons.home,
                taphandler: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (Context) {
                    return HomeScreen();
                  }));
                }),
            ListTiless(
                title: 'Nearest Acidents',
                icondata: Icons.car_repair,
                taphandler: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (Context) {
                    return MapScreen();
                  }));
                }),

            ListTiless(
                title: 'Profile',
                icondata: Icons.person_outline,
                taphandler: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (Context) {
                    return MapScreen();
                  }));
                }),

            ListTiless(
                title: 'Logout',
                icondata: Icons.exit_to_app,
                taphandler: () {
                  FirebaseAuth.instance.signOut();

                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return AuthScreen();
                  // }));
                }),
          ],
        ),
      ),
    );
  }
}
