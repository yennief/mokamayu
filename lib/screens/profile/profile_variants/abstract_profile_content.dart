import 'package:flutter/material.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/services/services.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';

abstract class AbstractProfileContent extends StatefulWidget {
  final String? uid;

  const AbstractProfileContent({Key? key, required this.uid}) : super(key: key);
}

abstract class AbstractProfileContentState
    extends State<AbstractProfileContent> {
  Future<UserData?>? userDataFuture;
  Future<List<WardrobeItem>>? itemList;
  Future<List<Outfit>>? outfitsList;
  UserData? userData;

  void loadData();

  String getLeftButtonType();

  Widget buildButtons();

  Map<String, Widget>? getTabs();

  Widget buildCreateOutfitForFriendButton() => Container();

  @override
  Widget build(BuildContext context) {
    userDataFuture = Provider.of<ProfileManager>(context, listen: false)
        .getUserData(widget.uid);

    if (widget.uid != null) {
      itemList = Provider.of<WardrobeManager>(context, listen: false)
          .readWardrobeItemsForUser(widget.uid!);
      outfitsList = Provider.of<OutfitManager>(context, listen: false)
          .readOutfitsForUser(widget.uid!);
    }

    loadData();

    return BasicScreen(
      type: S.of(context).profile,
      leftButtonType: getLeftButtonType(),
      context: context,
      isFullScreen: true,
      body: Stack(children: [
        const BackgroundImage(
            imagePath: "assets/images/mountains.png", imageShift: 160),
        Positioned(
          bottom: 0,
          child: BackgroundCard(
            context: context,
            height: 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildUserCard(context),
                buildProfileGallery(context),
              ],
            ),
          ),
        ),
        buildCreateOutfitForFriendButton(),
      ]),
    );
  }

  Widget buildUserCard(BuildContext context) {
    return Consumer<ProfileManager>(
        builder: (context, manager, _) => (FutureBuilder<UserData?>(
            future: userDataFuture,
            builder: (context, snapshot) {
              userData = snapshot.data;
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(25, 20, 5, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.square(110),
                        child: snapshot.data?.profilePicture != null
                            ? Image.network(snapshot.data!.profilePicture!,
                                fit: BoxFit.fill)
                            : Image.asset(Assets.avatarPlaceholder,
                                fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                              snapshot.data?.profileName ??
                                  snapshot.data?.username ??
                                  'Profile name',
                              style: TextStyles.h5()),
                          Text('@${snapshot.data?.username ?? 'username'}',
                              style: TextStyles.paragraphRegular16(
                                  ColorsConstants.grey)),
                          buildButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })));
  }

  Widget buildProfileGallery(BuildContext context) {
    List<Tab>? tabs = getTabs()
        ?.keys
        .map((label) => Tab(child: Text(label, textAlign: TextAlign.center)))
        .toList();
    return tabs == null
        ? Container()
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: DefaultTabController(
                length: tabs.length,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      labelPadding: const EdgeInsets.all(10),
                      indicatorColor: ColorsConstants.darkBrick,
                      labelStyle: TextStyles.paragraphRegular16(),
                      labelColor: ColorsConstants.darkBrick,
                      unselectedLabelColor: ColorsConstants.grey,
                      tabs: tabs,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: getTabs()!
                            .values
                            .map((widget) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: widget))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
