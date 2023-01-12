import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/models/user.dart';
import 'package:web_dashboard_app_tut/widgets/catergorycard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<User> list = [];
  late Map<dynamic, dynamic> map;
  bool isLoaded = false;

  Future<int> _getUserCounts() async {
    if (isLoaded == false) {
      print("karan1");
      DatabaseReference ref = FirebaseDatabase.instance.ref("UserDetails");
      print("karan2");
      map = new Map();
      if (map.isEmpty) print("it is empty");
      // DatabaseReference   stream = ref.onValue;
      print("karan3");

      // print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print("karan3");
      DatabaseEvent event = await ref.once();

      // print('Snapshot: ${event.snapshot.value}');
      final extractData = event.snapshot.value; // DataSnapshot
      print("karan4");
      print(extractData);
      map = event.snapshot.value as dynamic;
      print("Str");
      print(map.keys.length);

      int count = 0;
      print("SRK");
      print(map);
      print("srk is mass");

      map.forEach((key, value) {
        print(count);
        list.add(new User(
            fname: value['FirstName'].toString(),
            lname: value['LastName'].toString(),
            Enumber: value['Enumber'].toString(),
            Qrcode: value['QRcode'].toString()));
        // print(list[count]);
        // print(value);
        // print(value['FirstName']);
        // print(value['LastName']);
        // print(value['Enumber']);
        // print(value['QRcode']);
        count++;

        // List<Object?> map1 = event.snapshot.value as dynamic;
        // list.clear();
        //  for (int i = 0; i < map1.length; i++) {
        //    print(map1[i]);
        //   final mapCreated = Map.from(map1[i] as Map<Object?, Object?>);
        //   print(mapCreated.keys);
        //   print('working');
        //   print(mapCreated['lat']);
        //   _latlong.add(LatLng(double.parse(mapCreated['lat'].toString()),
        //       double.parse(mapCreated['long'].toString())));
        //}
        //list = map.values.toList();
        //print(extractData.toString().length);
        ;

        // for (int i = 0; i < _latlong.length; i++) print(_latlong[i]);
        // loadData();
      });

      print("count");
      print(count);
      print("mass maha");
      print(map.keys.length);
      print(map.keys.length);
    }

    setState(() {
      isLoaded = true;
    });

    return await map.keys.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //setting the expansion function for the navigation rail
  bool isExpanded = false;
  List<String> imgSrc = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDRJm7ESct3Z4JnFvTCJ2lRLAPwxGb93_J7g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_XvdkYjYVoBrHM9O6xZJV3qQ-t6hrrWu8XA&usqp=CAU',
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_square_w_320,q_50/lsci/db/PICTURES/CMS/316400/316489.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgaT_VQCF7y6SvWuwZGjzI9N3prVwWyfKeUw&usqp=CAU',
    'data:image/jpeg;base64,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',
    'data:image/jpeg;base64,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'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Let's start by adding the Navigation Rail
          NavigationRail(
              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400,
              unselectedIconTheme:
                  IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme:
                  IconThemeData(color: Colors.deepPurple.shade900),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.troubleshoot),
                  label: Text("Troubleshoot"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.admin_panel_settings),
                  label: Text("Profile"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text("Settings"),
                ),
              ],
              selectedIndex: 0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //let's add the navigation menu for this project
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              //let's trigger the navigation expansion
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            icon: Icon(Icons.menu),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtbyxX9EOcpyHH6w854Dw00Xc5rYTRx5EdTes6OEKUxNpU-mnNqsUf3y9mBMCsQ1jdd3I&usqp=CAU"),
                            radius: 26.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Now let's start with the dashboard main rapports
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.dangerous_rounded,
                                          size: 26.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Accidents",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "24 Accidents",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          size: 26.0,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Comments",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 26.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "+32 Comments",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 26.0,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          "Active Users",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    FutureBuilder<int>(
                                      future: _getUserCounts(),
                                      // You can set a default value here.
                                      builder: (context, snapshot) {
                                        return snapshot.data == null
                                            ? CircularProgressIndicator()
                                            : Text(
                                                snapshot.data.toString(),
                                                style: TextStyle(
                                                  fontSize: 36,
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Now let's set the article section
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "6 Accidents",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "3 new Accidents",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                            width: 300.0,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search by Place/ User",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),

                      //let's set the filter section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.deepPurple.shade400,
                            ),
                            label: Text(
                              "User Details",
                              style: TextStyle(
                                color: Colors.deepPurple.shade400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              DropdownButton(
                                  hint: Text("Filter by"),
                                  items: [
                                    DropdownMenuItem(
                                      value: "Date",
                                      child: Text("Date"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Comments",
                                      child: Text("Comments"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Views",
                                      child: Text("Views"),
                                    ),
                                  ],
                                  onChanged: (value) {}),
                              SizedBox(
                                width: 20.0,
                              ),
                              DropdownButton(
                                  hint: Text("Order by"),
                                  items: [
                                    DropdownMenuItem(
                                      value: "Date",
                                      child: Text("Date"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Comments",
                                      child: Text("Comments"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Views",
                                      child: Text("Views"),
                                    ),
                                  ],
                                  onChanged: (value) {}),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),

                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return // CategoryCard(
                                  //     svgSrc:
                                  //         'https://storage.googleapis.com/kaggle-avatars/images/7505528-kg.jpeg',
                                  //     title: list[index].fname);

                                  Container(
                                height: 80,
                                child: Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    height: 100,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: ListTile(
                                      focusColor: Colors.amber,
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 1.0,
                                                    color: Colors.white24))),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(imgSrc[index]),
                                          radius: 28.0,
                                        ),
                                      ),
                                      title: Row(
                                        children: <Widget>[
                                          Text(
                                            list[index].fname,
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(list[index].lname,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(list[index].Enumber,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              Text(
                                                  index == 1
                                                      ? "Offline"
                                                      : "Online",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor: index == 1
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      //Now let's add the Table

                      //Now let's set the pagination
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "1",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "2",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "3",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
      //let's add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,
      ),
    );
  }
}
