import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth/Widgets/catergory_card.dart';
import 'package:flutter_auth/Widgets/bottom_navigation.dart';
import '';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Happy Journey \n Pera!",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .95,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Nearby Accidents",
                          svgSrc: "assets/images/cara.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Traffic Signs Activation",
                          svgSrc: "assets/images/signs.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Feature 3",
                          svgSrc: "assets/images/cara.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return MapScreen();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Feature 4",
                          svgSrc: "assets/images/cara.png",
                          press: () {},
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
    );
  }
}
