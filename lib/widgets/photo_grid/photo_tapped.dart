import 'package:flutter/foundation.dart';
import 'package:mokamayu/widgets/drag_target_container.dart';

class PhotoTapped extends ChangeNotifier {
  Map<String, ContainerList> map = {};
  Map<String, ContainerList> get getMap => map;

  void addToMap(String id) {
    !map.containsKey(id)
        ? map.addAll({
            id: ContainerList(
              height: 100.0,
              width: 100.0,
              rotation: 0.0,
              scale: 1.0,
              xPosition: 0.1,
              yPosition: 0.1,
            )
          })
        : null;
    notifyListeners();
  }
}