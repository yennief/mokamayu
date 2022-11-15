import 'package:flutter/material.dart';
import 'package:mokamayu/screens/outfits/outfits_add_screen.dart';
import 'package:mokamayu/services/photo_tapped.dart';
import 'package:provider/provider.dart';

import '../../models/wardrobe/clothes.dart';

class CustomDialogBox {
  static outfitsDialog(
      BuildContext context, Future<List<Clothes>>? clothesList) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 232, 217),
      title: const Text('Create a look'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (_) => PhotoTapped(),
                          child: CreateOutfitPage(clothesList: clothesList),
                        )));
          },
          child: const Text('By yourself'),
        ),
        SimpleDialogOption(
          onPressed: () {
            //TODO in the future
          },
          child: const Text('With applied filters'),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
