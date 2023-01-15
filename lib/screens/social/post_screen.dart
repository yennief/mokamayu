import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/constants/constants.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../services/authentication/auth.dart';
import '../../services/managers/managers.dart';

class PostScreen extends StatefulWidget {
  Post post;
  UserData user;
  List<UserData> userList;

  PostScreen({
    Key? key,
    required this.post,
    required this.user,
    required this.userList,
  }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.userList.isEmpty) {
      widget.userList =
          Provider.of<UserListManager>(context, listen: false).getUserList;
    }
    return BasicScreen(
      context: context,
      type: "post-screen",
      rightButtonType: null,
      isFullScreen: true,
      body: Stack(children: [
        const BackgroundImage(
          imagePath: "assets/images/mountains.png",
          imageShift: 220,
          opacity: 0.5,
        ),
        Positioned(
          bottom: 0,
          child: BackgroundCard(
            context: context,
            height: 0.8,
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.square(50),
                          child: widget.user.profilePicture != null
                              ? Image.network(widget.user.profilePicture!,
                                  fit: BoxFit.fill)
                              : Image.asset(Assets.avatarPlaceholder,
                              width: MediaQuery.of(context).size.width * 0.7),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.post.createdFor == widget.post.createdBy
                          ? GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                "profile",
                                queryParams: {
                                  'uid': widget.post.createdBy,
                                },
                              );
                            },
                            child: Text(
                                widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).profileName != null
                                    ? widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).profileName!
                                    : widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).username,
                                style: TextStyles.paragraphRegularSemiBold16()),
                          )
                          : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    "profile",
                                    queryParams: {
                                      'uid': widget.post.createdBy,
                                    },
                                  );
                                },
                                child: Text(widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).profileName != null
                                    ? widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).profileName!
                                    : widget.userList.singleWhere((element) => element.uid == widget.post.createdBy).username,
                                    style: TextStyles.paragraphRegularSemiBold16()),
                              ),
                              Text(" for ", style: TextStyles.paragraphRegular16()),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    "profile",
                                    queryParams: {
                                      'uid': widget.post.createdFor,
                                    },
                                  );
                                },
                                child:Text(widget.userList.singleWhere((element) => element.uid == widget.post.createdFor).profileName != null
                                    ? widget.userList.singleWhere((element) => element.uid == widget.post.createdFor).profileName!
                                    : widget.userList.singleWhere((element) => element.uid == widget.post.createdFor).username,
                                    style: TextStyles.paragraphRegularSemiBold16()),
                              ),
                            ],
                          ),
                          Text("Posted ${
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .format(DateTime.fromMillisecondsSinceEpoch(widget.post.creationDate))}",
                              style: TextStyles.paragraphRegular14(ColorsConstants.grey)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.post.likes!.length.toString(),
                              style: TextStyles.paragraphRegular14(
                                  ColorsConstants.grey)),
                          widget.post.likes!.contains(AuthService().getCurrentUserID())
                          ? IconButton(
                            onPressed: (){
                              widget.post.likes!.remove(AuthService().getCurrentUserID());
                              Provider.of<PostManager>(context, listen: false).likePost(widget.post.reference!, widget.post.createdFor, widget.post.likes!);
                              setState(() {});
                              },
                            icon: const Icon(Icons.favorite, color: ColorsConstants.darkBrick,))
                          : IconButton(
                            onPressed: (){
                              widget.post.likes!.add(AuthService().getCurrentUserID());
                              Provider.of<PostManager>(context, listen: false).likePost(widget.post.reference!, widget.post.createdFor, widget.post.likes!);
                              setState(() {});
                              if(AuthService().getCurrentUserID() != widget.post.createdBy) {
                                  CustomNotification notif =
                                      CustomNotification(
                                          sentFrom: AuthService().getCurrentUserID(),
                                          type: NotificationType.COMMENT.toString(),
                                          creationDate: DateTime.now()
                                              .millisecondsSinceEpoch);
                                  Provider.of<NotificationsManager>(context,
                                          listen: false)
                                      .addNotificationToFirestore(
                                          notif, widget.post.createdBy);
                                }
                              },
                            icon: const Icon(Icons.favorite_border, color: ColorsConstants.darkBrick,))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Image.network(widget.post.cover, fit: BoxFit.fill),
                  widget.post.comments != null
                  ? Expanded(
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(widget.userList.singleWhere((element) => element.uid == widget.post.comments![index]['author']!).profileName != null
                                      ? widget.userList.singleWhere((element) => element.uid == widget.post.comments![index]['author']!).profileName!
                                          : widget.userList.singleWhere((element) => element.uid == widget.post.comments![index]['author']!).username,
                                      style: TextStyles.paragraphRegularSemiBold16()),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: widget.userList.singleWhere((element) => element.uid == widget.post.comments![index]['author']!).profilePicture != null
                                            ? Image.network(widget.userList.singleWhere((element) => element.uid == widget.post.comments![index]['author']!).profilePicture!,
                                            height: 20)
                                            : Image.asset(Assets.avatarPlaceholder,
                                            height: 20),
                                      ),
                                    ]
                                  ),
                                  Text(widget.post.comments![index]['content']!, style: TextStyles.paragraphRegular14(),)
                                ],
                              )
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                          itemCount: widget.post.comments!.length))
                  : SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  TextField(
                    controller: myController,
                    onSubmitted: (String comment){
                      print("add comment");
                      widget.post.comments!.add({
                        "author": AuthService().getCurrentUserID(),
                        "content": comment
                      });
                      Provider.of<PostManager>(context, listen: false)
                          .commentPost(widget.post.reference!,
                              widget.post.createdFor, widget.post.comments!);
                      myController.clear();
                      setState(() {});

                      if(AuthService().getCurrentUserID() != widget.post.createdBy){
                        CustomNotification notif = CustomNotification(
                            sentFrom: AuthService().getCurrentUserID(),
                            type: NotificationType.COMMENT.toString(),
                            creationDate:
                                DateTime.now().millisecondsSinceEpoch);
                        Provider.of<NotificationsManager>(context,
                                listen: false)
                            .addNotificationToFirestore(
                                notif, widget.post.createdBy);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Comment post",
                      filled: true,
                      fillColor: ColorsConstants.whiteAccent,
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorsConstants.darkBrick,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
