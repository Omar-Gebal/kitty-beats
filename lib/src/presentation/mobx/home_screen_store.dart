import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
part 'home_screen_store.g.dart';

class HomeScreenStore = HomeScreenStoreBase with _$HomeScreenStore;

abstract class HomeScreenStoreBase with Store {
  //inputs
  @observable
  String url = '';

  @observable
  bool isValidUrl = true;
}
