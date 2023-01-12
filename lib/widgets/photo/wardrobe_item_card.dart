import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mokamayu/constants/constants.dart';
import 'package:mokamayu/models/models.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/calendar_event.dart';
import '../../services/managers/app_state_manager.dart';
import '../../services/managers/calendar_manager.dart';
import '../../services/managers/photo_tapped_manager.dart';

class WardrobeItemCard extends StatelessWidget {
  WardrobeItemCard(
      {Key? key, this.wardrobItem, this.outfit, required this.size, this.event})
      : super(key: key);
  final WardrobeItem? wardrobItem;
  final Outfit? outfit;
  String? photoUrl = "";
  String? name = "";
  double size = 50;
  Event? event;
  Map<List<dynamic>, OutfitContainer>? getMap = {};

  @override
  Widget build(BuildContext context) {
    if (wardrobItem != null) {
      photoUrl = wardrobItem!.photoURL;
      name = wardrobItem!.name;
    }

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      color: ColorsConstants.whiteAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            buildPhoto(),
            wardrobItem != null
                ? buildEditCard(context)
                : buildAddCard(context),
          ],
        ),
      ),
    );
  }

  Widget buildAddCard(BuildContext context) {
    return Column(children: [
      TextButton(
          child: Text(
            S.of(context).see_details,
            style: const TextStyle(
                color: ColorsConstants.darkBrick, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          onPressed: () => {
                Provider.of<PhotoTapped>(context, listen: false)
                    .setObject(outfit),
                outfit!.map!.forEach((key, value) {
                  Map<String, dynamic> contList = json.decode(value);
                  OutfitContainer list = OutfitContainer(
                      height: contList["height"],
                      rotation: contList["rotation"],
                      scale: contList["scale"],
                      width: contList["width"],
                      xPosition: contList["xPosition"],
                      yPosition: contList["yPosition"]);
                  getMap!.addAll({json.decode(key): list});
                }),
                GoRouter.of(context)
                    .pushNamed("outfit-add-attributes-screen", extra: getMap)
              }),
      GestureDetector(
          onTap: () {
            //remove selected outfit
            if (event == null) {
              Provider.of<CalendarManager>(context, listen: false)
                  .selectOutfit(outfit, true);
              Provider.of<CalendarManager>(context, listen: false)
                  .removeOutfit(outfit);
            } else {
              //delete outfit from calendar event
              Provider.of<CalendarManager>(context, listen: false)
                  .removeEvent(event!);
              Map<DateTime, List<Event>> events =
                  Provider.of<CalendarManager>(context, listen: false)
                      .getEvents;
              Provider.of<CalendarManager>(context, listen: false)
                  .setSelectedEvents(events);
              Map<String, String> encodedEvents = encodeMap(events);

              Provider.of<AppStateManager>(context, listen: false)
                  .cacheEvents(encodedEvents);
            }
          },
          child: Image.asset(
            "assets/images/trash.png",
            fit: BoxFit.fitWidth,
            height: 35,
          ))
    ]);
  }

  buildEditCard(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: TextStyles.paragraphRegularSemiBold18(),
                  textAlign: TextAlign.right,
                ),
                TextButton(
                    child: Text(
                      S.of(context).see_details,
                      style: TextStyles.paragraphRegularSemiBold14(
                          ColorsConstants.darkBrick),
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () => {
                          context.pushNamed('wardrobe-item', extra: wardrobItem)
                        }),
              ],
            )));
  }

  Widget buildPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox.fromSize(
          size: Size.fromRadius(size),
          child: wardrobItem != null
              ? Image.network(photoUrl!, fit: BoxFit.fill)
              : Image.network(outfit!.cover, fit: BoxFit.fill)),
    );
  }
}

Map<String, String> encodeMap(Map<DateTime, List<Event>> map) {
  Map<String, String> newMap = {};
  List<String> eventList = [];
  map.forEach((key, value) {
    for (var element in value) {
      eventList.add(json.encode(element));
    }
    newMap[key.toString()] = json.encode(eventList);
    eventList = [];
  });
  return newMap;
}
