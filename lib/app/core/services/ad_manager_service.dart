import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../widgets/ad_floting_card.dart';

enum AdType { login, contactUs, rateApp, upgradePlan }

class AdManager extends GetxService {
  static AdManager get to => Get.find();

  final _storage = GetStorage();

  // Simple click tracking
  final clickCount = 0.obs;
  static const int clicksBeforeAd = 10;

  Future<AdManager> init() async {
    await _loadAdData();

    developer.log(
      'AdManager initialized',
      name: 'AdManager',
      error: {'clicks': clickCount.value},
    );

    return this;
  }

  Future<void> _loadAdData() async {
    clickCount.value = _storage.read('click_count') ?? 0;
  }

  void incrementClick() {
    clickCount.value++;
    _storage.write('click_count', clickCount.value);
    developer.log('Click count: ${clickCount.value}', name: 'AdManager');
  }

  Future<bool> shouldShowAd({AdType? preferredType}) async {
    developer.log(
      'Checking if should show ad',
      name: 'AdManager',
      error: {'clicks': clickCount.value, 'preferredType': preferredType?.name},
    );

    // Don't show login ad if already logged in
    if (preferredType == AdType.login && isUserLoggedIn()) {
      developer.log('User already logged in', name: 'AdManager');
      return false;
    }

    // Don't show rate app if already rated
    if (preferredType == AdType.rateApp && hasUserRated()) {
      developer.log('User already rated app', name: 'AdManager');
      return false;
    }

    // Check if 10 clicks reached
    if (clickCount.value >= clicksBeforeAd) {
      developer.log('10 clicks reached, ad approved', name: 'AdManager');
      return true;
    }

    developer.log('Not enough clicks: ${clickCount.value}', name: 'AdManager');
    return false;
  }

  Future<AdType?> getNextAdToShow() async {
    developer.log('Getting next ad to show', name: 'AdManager');

    if (!await shouldShowAd()) {
      developer.log('No ad should be shown', name: 'AdManager');
      return null;
    }

    // Priority 1: Show login ad if user not logged in
    if (!isUserLoggedIn()) {
      if (await shouldShowAd(preferredType: AdType.login)) {
        developer.log('Returning login ad', name: 'AdManager');
        return AdType.login;
      }
    }

    // Priority 2: Show rate app if not rated
    if (!hasUserRated()) {
      if (await shouldShowAd(preferredType: AdType.rateApp)) {
        developer.log('Returning rate app ad', name: 'AdManager');
        return AdType.rateApp;
      }
    }

    // Rotate between other ad types
    final lastShownType = _storage.read<String>('last_ad_type');

    if (lastShownType != AdType.contactUs.name) {
      developer.log('Returning contact us ad', name: 'AdManager');
      return AdType.contactUs;
    } else if (lastShownType != AdType.upgradePlan.name && isUserLoggedIn()) {
      developer.log('Returning upgrade plan ad', name: 'AdManager');
      return AdType.upgradePlan;
    }

    developer.log('Returning contact us ad (default)', name: 'AdManager');
    return AdType.contactUs;
  }

  Future<void> markAdAsShown(AdType type) async {
    await _storage.write('last_ad_type', type.name);

    // Reset click count to 0 after showing ad
    clickCount.value = 0;
    await _storage.write('click_count', 0);

    developer.log(
      'Ad marked as shown: ${type.name}, clicks reset',
      name: 'AdManager',
    );
  }

  Future<void> dismissAd(AdType type) async {
    developer.log('Ad dismissed: ${type.name}', name: 'AdManager');
    // Reset click count even on dismiss
    clickCount.value = 0;
    await _storage.write('click_count', 0);
  }

  // Public methods for checking user status
  bool isUserLoggedIn() {
    return _storage.read<bool>('is_logged_in') ?? false;
  }

  bool hasUserRated() {
    return _storage.read<bool>('has_rated_app') ?? false;
  }

  Future<void> markUserAsLoggedIn() async {
    await _storage.write('is_logged_in', true);
    developer.log('User marked as logged in', name: 'AdManager');
  }

  Future<void> markAppAsRated() async {
    await _storage.write('has_rated_app', true);
    developer.log('App marked as rated', name: 'AdManager');
  }

  // Reset for testing purposes
  Future<void> resetAdData() async {
    await _storage.remove('click_count');
    await _storage.remove('last_ad_type');
    await _storage.remove('is_logged_in');
    await _storage.remove('has_rated_app');
    clickCount.value = 0;
    developer.log('Ad data reset', name: 'AdManager');
  }
}

class AdOverlayManager {
  static OverlayEntry? _currentOverlay;
  static BuildContext? _overlayContext;
  static List<AdType> _adQueue = [];
  static bool _isShowingAd = false;

  // Call this from your main screen to set the context
  static void setContext(BuildContext context) {
    _overlayContext = context;
    developer.log('Overlay context set', name: 'AdOverlayManager');
  }

  static Future<void> tryShowAd() async {
    developer.log('Attempting to show ad', name: 'AdOverlayManager');

    if (_isShowingAd) {
      developer.log('Ad already showing, skipping', name: 'AdOverlayManager');
      return;
    }

    // Get all available ads to show
    _adQueue = await _getAdQueue();

    if (_adQueue.isEmpty) {
      developer.log('No ads to show', name: 'AdOverlayManager');
      return;
    }

    developer.log(
      'Ad queue prepared: ${_adQueue.length} ads',
      name: 'AdOverlayManager',
    );

    // Start showing ads in sequence
    _showNextAdInQueue();
  }

  static Future<List<AdType>> _getAdQueue() async {
    final List<AdType> queue = [];

    // Check if we should show ads at all
    final shouldShow = await AdManager.to.shouldShowAd();
    if (!shouldShow) {
      return queue;
    }

    final isLoggedIn = AdManager.to.isUserLoggedIn();
    final hasRated = AdManager.to.hasUserRated();

    // Add login ad if user is not logged in
    if (!isLoggedIn) {
      queue.add(AdType.login);
      developer.log('Added login ad to queue', name: 'AdOverlayManager');
    }

    // Add rate app ad if user hasn't rated
    if (!hasRated) {
      queue.add(AdType.rateApp);
      developer.log('Added rate app ad to queue', name: 'AdOverlayManager');
    }

    // Always add contact us ad
    queue.add(AdType.contactUs);
    developer.log('Added contact us ad to queue', name: 'AdOverlayManager');

    // Add upgrade plan if user is logged in
    if (isLoggedIn) {
      queue.add(AdType.upgradePlan);
      developer.log('Added upgrade plan ad to queue', name: 'AdOverlayManager');
    }

    return queue;
  }

  static void _showNextAdInQueue() {
    if (_adQueue.isEmpty) {
      developer.log('All ads shown, queue empty', name: 'AdOverlayManager');
      _isShowingAd = false;
      // Mark ad cycle as complete
      if (_adQueue.isEmpty) {
        AdManager.to.markAdAsShown(AdType.contactUs); // Reset clicks
      }
      return;
    }

    final adType = _adQueue.removeAt(0);
    developer.log(
      'Showing ad ${adType.name} (${_adQueue.length} remaining)',
      name: 'AdOverlayManager',
    );

    _isShowingAd = true;
    _showOverlay(adType);
  }

  static void _showOverlay(AdType adType) {
    if (_overlayContext == null || !_overlayContext!.mounted) {
      developer.log(
        'Overlay context not available',
        name: 'AdOverlayManager',
        error: 'Context is null or not mounted',
      );
      _isShowingAd = false;
      return;
    }

    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: FloatingAdCard(
            adType: adType,
            onDismiss: () => _dismissOverlay(adType),
          ),
        ),
      ),
    );

    try {
      Overlay.of(_overlayContext!).insert(_currentOverlay!);
      developer.log(
        'Ad overlay inserted successfully: ${adType.name}',
        name: 'AdOverlayManager',
      );
    } catch (e) {
      developer.log(
        'Error inserting overlay',
        name: 'AdOverlayManager',
        error: e,
      );
      _currentOverlay = null;
      _isShowingAd = false;
    }
  }

  static void _dismissOverlay(AdType adType) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    developer.log(
      'Ad overlay dismissed: ${adType.name}',
      name: 'AdOverlayManager',
    );

    // Wait a bit before showing next ad
    Future.delayed(const Duration(milliseconds: 500), () {
      _showNextAdInQueue();
    });
  }

  // Force clear everything (for testing)
  static void clearAll() {
    _currentOverlay?.remove();
    _currentOverlay = null;
    _adQueue.clear();
    _isShowingAd = false;
    developer.log('All ads cleared', name: 'AdOverlayManager');
  }
}
