import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/icon_data.dart';

class ListTiless extends StatelessWidget {

  final IconData icondata;
   final   String title;
     final void Function()? taphandler;


      const ListTiless({
    required this.title,
    required this.icondata,
    required this.taphandler,
  });



  @override
  Widget build(BuildContext context) {
       return ListTile(
      leading: Icon(
        icondata,
        size: 22,
      ),
      title: Text(
        title,
           style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 15),
      ),
      onTap: taphandler,
    );
  }
}