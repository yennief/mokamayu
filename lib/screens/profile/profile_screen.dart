import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokamayu/models/models.dart';
import 'package:mokamayu/services/services.dart';
import 'package:mokamayu/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<List<WardrobeItem>>? itemList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          itemList = Provider.of<WardrobeManager>(context, listen: false)
              .getWardrobeItemList;
        }));
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          userSummary(context, widget.user, imageRadius: 60),
          if (AuthService().getCurrentUserID() != widget.user?.uid) ...[
            Button(
                context,
                'Create outfit for ${widget.user?.displayName ?? widget.user?.email}',
                () => {
                      // TODO(karina)
                    })
          ],
          profileContent(context),
        ],
      ),
    );
  }

  Widget profileContent(BuildContext context) {
    List<Tab> tabs = <Tab>[
      Tab(text: S.of(context).wardorbe),
      Tab(text: S.of(context).outfits),
    ];
    return Expanded(
      child: DefaultTabController(
        length: tabs.length,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabBar(
                labelColor: Colors.black87,
                tabs: tabs,
              ),
              Expanded(
                child: TabBarView(children: [
                  PhotoGrid(itemList: itemList),
                  PhotoGrid(
                      itemList: itemList), //potem podmienie na outfity
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
