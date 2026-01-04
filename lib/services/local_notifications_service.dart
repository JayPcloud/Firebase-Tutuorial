import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {

  LocalNotificationsService._();

  static final LocalNotificationsService _instance = LocalNotificationsService._();

  factory LocalNotificationsService.instance()=> _instance;

  //Main Plugin instance for handling notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

  final _iosInitializationSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final _androidChannel = const AndroidNotificationChannel(
    'channel_id', 
    'Channel name',
    description: 'Android push notification channel',
    importance: Importance.max,
    );

  
  bool _isFlutterLocalNotificationsInitialized = false;

  //Counter for generating unique notification IDs
  int _notificationIdCounter = 0;

  // Initializes the local notifications plugin for Android and iOS
  Future<void> init() async {
    // Check if already initialized to prevent redundant Setup
    if(_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // Create plugin instance
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Combine platform-specific settings
    final initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
      iOS: _iosInitializationSettings
    );

    // Initialize plugin with settings and callback for notification taps
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      //Handle notification tap in foreground
      print('Foreground notification had been tapped: ${response.payload}');
    },
    );

    //Create Android notification channel
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(_androidChannel);

    // Mark initialization as complete
    _isFlutterLocalNotificationsInitialized = true;
  }

  /// Show a local notification with the given title, body, and payload
  Future<void> showNotification(
    String? title,
    String? body,
    String? payload,
    ) async {
      // Android-specific notification details
      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        _androidChannel.id, 
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: Importance.max,
        priority: Priority.high
        );

        //iOS-specific notification details
        DarwinNotificationDetails iosDetails = const DarwinNotificationDetails();

        // COmbine platform-specific details
        final notificationDetails = NotificationDetails(
          android: androidDetails,
          iOS: iosDetails
        );

        // Display the notification
        await _flutterLocalNotificationsPlugin.show(
          _notificationIdCounter++, 
          title, 
          body, 
          notificationDetails,
          payload: payload,
          );
    }

}