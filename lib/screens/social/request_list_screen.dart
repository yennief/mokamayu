import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mokamayu/constants/colors.dart';
import 'package:mokamayu/constants/text_styles.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/services/services.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:mokamayu/services/managers/managers.dart';
import 'package:mokamayu/constants/assets.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<UserData> requestList = [];
  List<UserData> _foundRequests = [];
  late UserData currentUser;
  bool searching = false;

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileManager>(context, listen: false).getCurrentUserData()
        .then((UserData? temp){
      setState(() => currentUser = temp!);
      Provider.of<FriendsManager>(context, listen: false).readRequestsOnce(currentUser)
          .then((List<UserData> temp){
        setState(() => requestList = temp);
        setState(() => _foundRequests = requestList );
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    List<UserData> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = requestList;
    } else {
      results = requestList
          .where((user) =>
      user.profileName != null
          ? user.username.toLowerCase().contains(enteredKeyword.toLowerCase())
          || user.email.toLowerCase().contains(enteredKeyword.toLowerCase())
          || user.profileName!.toLowerCase().contains(enteredKeyword.toLowerCase())
          : user.username.toLowerCase().contains(enteredKeyword.toLowerCase())
          || user.email.toLowerCase().contains(enteredKeyword.toLowerCase())
      )
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundRequests = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      context: context,
      type: 'your friend invitations',
      body: Stack(
        children: [
          Column(
            children: [
              Column(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,

                    child: TextField(
                        onChanged: (value) {
                          _runFilter(value);
                          value.isNotEmpty
                              ? searching = true
                              : searching = false;
                        },
                        decoration: const InputDecoration(
                          hintText: "Find friend",
                        ))
                ),
                const SizedBox(height: 15),
              ]),
              Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text("Found ${_foundRequests.length} results")
              ),
              Expanded(
                child: _foundRequests.isNotEmpty
                    ? buildList()
                    : buildEmpty(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _foundRequests.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              context.pushNamed(
                "profile",
                queryParams: {
                  'uid': _foundRequests[index].uid,
                },
              );
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(color: ColorsConstants.whiteAccent, borderRadius: BorderRadius.circular(14)),
                child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14), // Image border
                        child: SizedBox.fromSize(
                          size: Size.square(MediaQuery.of(context).size.height*0.1),
                          child: _foundRequests[index].profilePicture != null
                              ? Image.network(_foundRequests[index].profilePicture!,
                              fit: BoxFit.fill)
                              : Image.asset(Assets.avatarPlaceholder,
                              fit: BoxFit.fill),
                        ),
                      ),
                      _foundRequests[index].profileName != null
                          ? Text(_foundRequests[index].profileName!, style: TextStyles.paragraphRegularSemiBold18(Colors.black),)
                          : Text("@${_foundRequests[index].username}", style: TextStyles.paragraphRegularSemiBold18(Colors.black)),
                    ]
                )
            )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildEmpty(){
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        searching
            ? Text(
          "No pending invitations \n from such user",
          style: TextStyles.paragraphRegularSemiBold20(ColorsConstants.grey),
          textAlign: TextAlign.center,
        )
            : Text(
          "No pending invitations",
          style: TextStyles.paragraphRegularSemiBold20(ColorsConstants.grey),
          textAlign: TextAlign.center,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mountains.png"),
                fit: BoxFit.fitWidth,
                opacity: 0.5
            ),
          ),
        ),
      ],
    );
  }
}



