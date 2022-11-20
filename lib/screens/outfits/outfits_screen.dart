import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:mokamayu/services/services.dart';
import 'package:mokamayu/constants/constants.dart';
import 'create_outfit_dialog.dart';

class OutfitsScreen extends StatefulWidget {
  const OutfitsScreen({Key? key}) : super(key: key);

  @override
  State<OutfitsScreen> createState() => _OutfitsScreenState();
}

class _OutfitsScreenState extends State<OutfitsScreen> {
  Future<List<Clothes>>? clothesList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          clothesList = Provider.of<ClothesManager>(context, listen: false)
              .getClothesList;
        }));
    return Scaffold(
        body: Stack(children: [
      Column(children: [
        Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                child: PhotoGrid(clothesList: clothesList)))
      ]),
      FloatingButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox.outfitsDialog(context, clothesList);
                });
          },
          icon: const Icon(Icons.add),
          backgroundColor: ColorsConstants.primary,
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 30),
          alignment: Alignment.bottomRight)
    ]));
  }
}
