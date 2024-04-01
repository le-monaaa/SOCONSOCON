import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/firebase_options.dart';
import 'package:socon/routes/router.dart';
import 'package:socon/services/notifications/background_message_handler.dart';
import 'package:socon/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socon/utils/firebase_utils.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/viewmodels/boss_verification_view_model.dart';
import 'package:socon/viewmodels/notification_view_model.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // runApp을 호출하기 전 위젯 바인딩 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseUtils().setupFlutterNotifications();
  }

  NotificationViewModel _notificationViewModel = NotificationViewModel();

  var fcmToken = await _notificationViewModel.getFcmToken();
  print("fcmToken야. $fcmToken");
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // foreground에서 fcm 메세지 처리
    print("[포어그라운드] FCM 메세지를 받았는데요. 저는 집에 가고 싶네요. ${message.notification!.body}");
    FirebaseUtils().showFlutterNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler); // 백그라운드 메세지 설정

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BossVerificationViewModel()),
        ChangeNotifierProvider(create: (context) => LoginState()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        // routerDelegate: router.routerDelegate,
        // routeInformationParser: router.routeInformationParser,
        debugShowCheckedModeBanner: false,
        title: 'Socon',
        theme: ThemeData(
          fontFamily: 'Pretendard',
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
          primaryColor: AppColors.WHITE,
          // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
        ),
      ),
    );
  }
}
