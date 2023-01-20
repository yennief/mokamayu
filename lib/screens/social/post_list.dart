import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/constants/constants.dart';
import 'package:mokamayu/screens/screens.dart';
import 'package:mokamayu/services/authentication/auth.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../services/managers/managers.dart';

class PostList extends StatefulWidget {
  final List<Post> postList;
  final List<UserData> userList;

  const PostList({
    Key? key,
    required this.postList,
    required this.userList,
  }) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late List<TextEditingController> myController;
  @override
  void initState() {
    myController =
        List.generate(widget.postList.length, (_) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.postList.isNotEmpty ? buildFeed(context) : buildEmpty();
  }

  Widget buildFeed(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
                color: ColorsConstants.whiteAccent,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildUserAvatar(index),
                      buildNameAndDate(index),
                      buildLikeButton(index)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  buildPostBody(index),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextField(
                    controller: myController[index],
                    onSubmitted: (String comment) {
                      print("add comment");
                      widget.postList[index].comments!.add({
                        "author": AuthService().getCurrentUserID(),
                        "content": comment
                      });
                      Provider.of<PostManager>(context, listen: false)
                          .commentPost(
                              widget.postList[index].reference!,
                              widget.postList[index].createdFor,
                              widget.postList[index].comments!);
                      myController[index].clear();
                      setState(() {});
                      if (AuthService().getCurrentUserID() !=
                          widget.postList[index].createdBy) {
                        CustomNotification notif = CustomNotification(
                            sentFrom: AuthService().getCurrentUserID(),
                            type: NotificationType.COMMENT.toString(),
                            creationDate:
                                DateTime.now().millisecondsSinceEpoch);
                        Provider.of<NotificationsManager>(context,
                                listen: false)
                            .addNotificationToFirestore(
                                notif, widget.postList[index].createdBy);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Comment post",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorsConstants.darkBrick,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PostScreen(
                                    post: widget.postList[index],
                                    user: widget.userList.singleWhere(
                                        (element) =>
                                            element.uid ==
                                            widget.postList[index].createdBy),
                                    userList: widget.userList,
                                  )));
                    },
                    child: Text(
                      " View comments",
                      style: TextStyles.paragraphRegular12(
                          ColorsConstants.darkBrick),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: widget.postList.length);
  }


  Widget buildPostBody(int index){
    return ExtendedImage.network(
      widget.postList[index].cover,
      fit: BoxFit.fill,
      cache: true,
      enableMemoryCache: false,
      enableLoadState: true,
    );
  }


  Widget buildLikeButton(int index){
    return Row(
      children: [
        Text(widget.postList[index].likes!.length.toString(),
            style: TextStyles.paragraphRegular14(
                ColorsConstants.grey)),
        widget.postList[index].likes!
            .contains(AuthService().getCurrentUserID())
            ? IconButton(
            onPressed: () {
              widget.postList[index].likes!.remove(
                  AuthService().getCurrentUserID());
              Provider.of<PostManager>(context,
                  listen: false)
                  .likePost(
                  widget.postList[index].reference!,
                  widget.postList[index].createdFor,
                  widget.postList[index].likes!);
              setState(() {});
            },
            icon: const Icon(
              Icons.favorite,
              color: ColorsConstants.darkBrick,
            ))
            : IconButton(
            onPressed: () {
              widget.postList[index].likes!
                  .add(AuthService().getCurrentUserID());
              Provider.of<PostManager>(context,
                  listen: false)
                  .likePost(
                  widget.postList[index].reference!,
                  widget.postList[index].createdFor,
                  widget.postList[index].likes!);
              setState(() {});
              if (AuthService().getCurrentUserID() !=
                  widget.postList[index].createdBy) {
                CustomNotification notif =
                CustomNotification(
                    sentFrom: AuthService()
                        .getCurrentUserID(),
                    type: NotificationType
                        .LIKE
                        .toString(),
                    creationDate: DateTime.now()
                        .millisecondsSinceEpoch);
                Provider.of<NotificationsManager>(context,
                    listen: false)
                    .addNotificationToFirestore(notif,
                    widget.postList[index].createdBy);
              }
            },
            icon: const Icon(
              Icons.favorite_border,
              color: ColorsConstants.darkBrick,
            ))
      ],
    );
  }


  Widget buildNameAndDate(int index){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.postList[index].createdFor ==
            widget.postList[index].createdBy
            ? GestureDetector(
          onTap: () {
            context.pushNamed(
              "profile",
              queryParams: {
                'uid': widget.postList[index].createdBy,
              },
            );
          },
          child: Text(
              widget.userList
                  .singleWhere((element) =>
              element.uid ==
                  widget.postList[index]
                      .createdBy)
                  .profileName !=
                  null
                  ? widget.userList
                  .singleWhere((element) =>
              element.uid ==
                  widget.postList[index]
                      .createdBy)
                  .profileName!
                  : widget.userList
                  .singleWhere((element) =>
              element.uid ==
                  widget.postList[index]
                      .createdBy)
                  .username,
              style: TextStyles
                  .paragraphRegularSemiBold16()),
        )
            : Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  "profile",
                  queryParams: {
                    'uid': widget
                        .postList[index].createdBy,
                  },
                );
              },
              child: Text(
                  widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdBy)
                      .profileName !=
                      null
                      ? widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdBy)
                      .profileName!
                      : widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdBy)
                      .username,
                  style: TextStyles
                      .paragraphRegularSemiBold16()),
            ),
            Text(" for ",
                style: TextStyles.paragraphRegular16()),
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  "profile",
                  queryParams: {
                    'uid': widget
                        .postList[index].createdFor,
                  },
                );
              },
              child: Text(
                  widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdFor)
                      .profileName !=
                      null
                      ? widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdFor)
                      .profileName!
                      : widget.userList
                      .singleWhere((element) =>
                  element.uid ==
                      widget.postList[index]
                          .createdFor)
                      .username,
                  style: TextStyles
                      .paragraphRegularSemiBold16()),
            ),
          ],
        ),
        Text(
            "Posted ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.fromMillisecondsSinceEpoch(widget.postList[index].creationDate))}",
            style: TextStyles.paragraphRegular14(
                ColorsConstants.grey)),
      ],
    );
  }

  Widget buildUserAvatar(int index){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5), // Image border
      child: SizedBox.fromSize(
        size: const Size.square(50),
        child: widget.userList
            .singleWhere((element) =>
        element.uid ==
            widget.postList[index].createdBy)
            .profilePicture !=
            null
            ? Image.network(
            widget.userList
                .singleWhere((element) =>
            element.uid ==
                widget.postList[index].createdBy)
                .profilePicture!,
            fit: BoxFit.fill)
            : Image.asset(Assets.avatarPlaceholder,
            width:
            MediaQuery.of(context).size.width * 0.7),
      ),
    );
  }


  Widget buildEmpty() {
    return Container(
        decoration: BoxDecoration(
            color: ColorsConstants.mint.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Icon(
                Ionicons.sad_outline,
                size: 25,
                color: Colors.grey,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Text(S.of(context).empty_feed,
                      textAlign: TextAlign.center,
                      style: TextStyles.paragraphRegular14(Colors.grey)))
            ])));
  }
}
