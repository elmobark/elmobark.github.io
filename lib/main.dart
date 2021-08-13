import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    GetMaterialApp(
      title: "Elmobark",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme()),
    ),
  );
}
