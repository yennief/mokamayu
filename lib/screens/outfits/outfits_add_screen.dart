import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mokamayu/widgets/buttons/back_button.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import '../../services/managers/managers.dart';

// ignore: must_be_immutable
class CreateOutfitPage extends StatelessWidget {
  CreateOutfitPage({Key? key, this.itemList, this.friendUid})
      : super(key: key) {
    isCreatingOutfitForFriend = friendUid != null;
  }

  Future<List<WardrobeItem>>? itemList;
  String? friendUid;
  late final bool isCreatingOutfitForFriend;
  Map<List<dynamic>, OutfitContainer> map = {};
  List<String> selectedChips = Tags.types;
  Future<List<WardrobeItem>>? futureItemListCopy;

  @override
  Widget build(BuildContext context) {
    map = Provider.of<PhotoTapped>(context, listen: true).getMapDynamic;

    itemList = isCreatingOutfitForFriend
        ? Provider.of<WardrobeManager>(context, listen: true)
            .getFriendWardrobeItemList
        : Provider.of<WardrobeManager>(context, listen: true)
            .getWardrobeItemList;

    futureItemListCopy = isCreatingOutfitForFriend
        ? Provider.of<WardrobeManager>(context, listen: true)
            .getFriendWardrobeItemListCopy
        : Provider.of<WardrobeManager>(context, listen: true)
            .getWardrobeItemListCopy;

    return BasicScreen(
        type: "outfit-create",
        rightButtonType: "",
        leftButton: BackArrowButton(context),
        context: context,
        isFullScreen: true,
        body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          Stack(children: const [
            BackgroundImage(
              imagePath: "assets/images/upside_down_background.png",
              imageShift: 150,
            ),
          ]),
          BackgroundCard(
            context: context,
            height: 0.87,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: SizedBox(
                        height: double.maxFinite,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    color: ColorsConstants.whiteAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: DragTargetContainer(map: map))),
                              SingleChildScrollView(
                                  child: Column(children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: buildFilters(context)),
                                SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.24,
                                    child: PhotoGrid(
                                      itemList: futureItemListCopy ?? itemList,
                                      scrollVertically: false,
                                    ))
                              ])),
                              ButtonDarker(context, "Next", () {
                                Provider.of<PhotoTapped>(context, listen: false)
                                    .setObject(null);
                                Provider.of<WardrobeManager>(context,
                                        listen: false)
                                    .nullListItemCopy();
                                Provider.of<WardrobeManager>(context,
                                        listen: false)
                                    .setTypes([]);
                                if (isCreatingOutfitForFriend) {
                                  context.pushNamed(
                                      "outfit-add-attributes-screen",
                                      extra: map,
                                      queryParams: {'friendUid': friendUid});
                                } else {
                                  context.pushNamed(
                                      "outfit-add-attributes-screen",
                                      extra: map);
                                }
                              },
                                  shouldExpand: false,
                                  width: 0.31,
                                  height: 0.05,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 0))
                            ])))),
          )
        ]));
  }

  Widget buildFilters(BuildContext context) {
    return MultiSelectChip(
      Tags.getLanguagesTypes(context),
      type: "type_main",
      chipsColor: ColorsConstants.darkPeach,
      usingFriendsWardrobe: isCreatingOutfitForFriend,
      onSelectionChanged: (selectedList) {
        selectedChips = selectedList.isEmpty ? Tags.types : selectedList;
      },
    );
  }
}
