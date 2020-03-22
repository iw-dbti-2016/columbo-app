import 'dart:convert';
import 'package:Columbo/widgets/columbo_scaffold.dart';
import 'package:crypto/crypto.dart';

import 'package:Columbo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColumboScaffold(
      child: Consumer<Auth>(
        builder: (_, auth, __) {
          final String gravatarHash =
              md5.convert(utf8.encode(auth.user.email)).toString();

          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                        'https://www.gravatar.com/avatar/$gravatarHash?s=400&r=pg&d=mp'),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
