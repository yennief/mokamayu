import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mokamayu/constants/colors.dart';
import 'package:mokamayu/widgets/photo_grid/photo_tapped.dart';
import 'package:mokamayu/models/models.dart';
import 'package:provider/provider.dart';

class CustomDialogBox {
  static outfitsDialog(
      BuildContext context, Future<List<WardrobeItem>>? itemList) {
    return SizedBox.expand(
        child: Stack(
      children: [
        Positioned(
            child: Opacity(
                opacity: 0.4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset("assets/images/full_background.png",
                      fit: BoxFit.fill),
                ))),
        Positioned(
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                    height: 260,
                    width: 310,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 25,
                                    color: Colors.grey,
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: dialogCard("Create outfit by yourself!",
                                    () {
                                  Provider.of<PhotoTapped>(context,
                                          listen: false)
                                      .setMap({});
                                  context.goNamed("create-outfit-page",
                                      extra: itemList!);
                                  Navigator.of(context).pop();
                                }, 18, secondText: "Use your creativity!")),
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: dialogCard("Generate Outfit!", () {
                                  //TO DO
                                }, 85))
                          ],
                        )))))
      ],
    ));
  }
}

Widget dialogCard(String text, Function onTap, double pad,
    {String secondText = ""}) {
  return Container(
    width: 280,
    height: 65,
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsConstants.whiteAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/empty_dot.png",
              fit: BoxFit.fitWidth,
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: secondText == ""
                        ? Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    secondText,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ))
                            ],
                          ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: pad),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey,
                )),
          ],
        )),
  );
}
