import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mokamayu/constants/colors.dart';
import 'package:mokamayu/widgets/buttons/button_darker_orange.dart';

import '../fundamental/background_image.dart';

class PhotoPicker extends StatefulWidget {
  File? photo;
  String? photoPath;
  final ImagePicker picker = ImagePicker();
  final double width;
  final double height;

  PhotoPicker({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: widget.photo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                widget.photo!,
                height: widget.height,
                fit: BoxFit.fill,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: ColorsConstants.whiteAccent,
                  borderRadius: BorderRadius.circular(20)),
              width: double.maxFinite,
              height: widget.height,
              child: const Icon(Icons.camera_alt),
            ),
    );
  }

  Future pickImage(ImageSource source) async {
    final pickedFile =
        await widget.picker.pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        widget.photoPath = pickedFile.path;
        widget.photo = File(pickedFile.path);
      } else {
        //TODO SNACK BAR
      }
    });
  }

  Future removeImage() async {
    setState(() {
      widget.photo = null;
    });
  }

  void _showPicker(
    context,
  ) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          GestureDetector(
              onTap: () => context.pop(),
              child: Stack(children: const [
                BackgroundImage(
                    imagePath: "assets/images/full_background.png",
                    imageShift: 0,
                    opacity: 0.5),
              ])),
          Container(
            padding: EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: widget.photo == null
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.height * 0.35,
            // color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Ionicons.close_outline,
                              size: 25,
                              color: Colors.grey,
                            )),
                      )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.photo == null
                            ? Container()
                            : buildSourceElement(context, "Remove photo", null),
                        buildSourceElement(
                            context, "Gallery", ImageSource.gallery),
                        buildSourceElement(
                            context, "Camera", ImageSource.camera),
                      ])
                ],
              ),
            ),
          )
        ]);
      },
    );
  }

  Widget buildSourceElement(
      BuildContext context, String title, ImageSource? source) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ButtonDarker(
            context,
            title,
            source != null
                ? () {
                    pickImage(source);
                    Navigator.of(context).pop();
                  }
                : () {
                    removeImage();
                    Navigator.of(context).pop();
                  },
            shouldExpand: false,
            height: 0.06,
            width: 0.8,
            margin: const EdgeInsets.all(0)));
  }

  File? get getPhoto {
    return widget.photo;
  }
}