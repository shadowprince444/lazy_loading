import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/utils/enums/general_enums.dart';

class InternetConnectivityController extends GetxController {
  // var _previousState = ConnectionStatusEnum.loading.obs;
  var isLoading = false.obs;
  // ignore: prefer_final_fields
  var _internetConnectionStatus = ConnectionStatusEnum.loading.obs;

  Rx<ConnectionStatusEnum> get internetConnectionStatus => _internetConnectionStatus;

  setLoading() {
    isLoading.value = true;
  }

  setUnloading() {
    isLoading.value = false;
  }

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  Future getConnectionType() async {
    ConnectivityResult connectivityResult = ConnectivityResult.none;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
      return _updateState(connectivityResult);
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  _updateState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      debugPrint("Both wifi and mobile data is turned off !!!");

      _internetConnectionStatus.value = ConnectionStatusEnum.internetConnectionNotAvailable;
      update();
    } else {
      _internetConnectionStatus.value = ConnectionStatusEnum.loading;
      update();
      dnsLookUp();
    }
  }

  dnsLookUp() async {
    debugPrint("trying to reach DNS");
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _internetConnectionStatus.value = ConnectionStatusEnum.internetConnectionAvailable;
        update();
      } else {
        _internetConnectionStatus.value = ConnectionStatusEnum.internetConnectionNotAvailable;
        update();
      }
    } on SocketException catch (_) {
      _internetConnectionStatus.value = ConnectionStatusEnum.internetConnectionNotAvailable;
      update();
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
