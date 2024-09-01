import 'package:expense_manager/common/database/database_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'api_service/dio_client.dart';
import 'common/constants/color_constants.dart';
import 'common/constants/font_constants.dart';
import 'common/remote_repository/api_repository.dart';
import 'pages/splash/splash_binding.dart';
import 'routes/app_pages.dart';

Future<void> main(main) async {
  WidgetsFlutterBinding.ensureInitialized();


  await initServices();
  runApp(const MyApp());
}


// Function to initialize the database
Future<void> initServices() async {

  DatabaseUtil dbUtil = DatabaseUtil(); // Create an instance of DatabaseUtil
  await dbUtil.initDB(); // Initialize the database
  Get.put<DatabaseUtil>(dbUtil);

  // dio client
  await Get.putAsync<DioClient>(() => DioClient().init());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        systemNavigationBarColor: ColorConstants.blackColor,
        systemNavigationBarDividerColor: ColorConstants.dividerColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
        // statusBarBrightness: Brightness.light,
      ),
    );

    return GetMaterialApp(
      title: "Expense-Manager",
      enableLog: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: FontConstants.font_14,
            fontWeight: FontWeightConstants.regular,
          ),
        ),
        primaryColor: ColorConstants.primaryColor,
        colorScheme: const ColorScheme.highContrastLight(
          primary: ColorConstants.primaryColor,
        ),
        canvasColor: ColorConstants.whiteColor,
        focusColor: ColorConstants.whiteColor,
      ),

      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,


    );
  }


}

