import 'dart:developer' as developer;
import 'package:get/get.dart';
import '../../core/services/ad_manager_service.dart';


class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;

    // Increment click counter
    AdManager.to.incrementClick();

    developer.log('Page changed to index $index (clicks: ${AdManager.to.clickCount.value})', name: 'MainController');

    // Check if we should show ad (after 10 clicks)
    if (AdManager.to.clickCount.value >= 10) {
      developer.log('10 clicks reached, trying to show ad', name: 'MainController');
      _tryShowAd();
    }
  }

  Future<void> _tryShowAd() async {
    // Add slight delay so ad doesn't interrupt navigation
    await Future.delayed(const Duration(milliseconds: 500));
    await AdOverlayManager.tryShowAd();
  }

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = 0;
    developer.log('MainController initialized', name: 'MainController');
  }

  @override
  void onClose() {
    developer.log('MainController closed', name: 'MainController');
    super.onClose();
  }
}