import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/invoice_model.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(InvoiceModelAdapter());

  await Hive.openBox<InvoiceModel>("invoices");
  await Hive.openBox("settings");
  await Hive.openBox("company");

  runApp(const InvoiceGeneratorApp());
}


class InvoiceGeneratorApp extends StatelessWidget {

  const InvoiceGeneratorApp({super.key});


  @override
  Widget build(BuildContext context) {

    final settingsBox = Hive.box("settings");


    return ValueListenableBuilder(

      valueListenable: settingsBox.listenable(),

      builder: (context, box, _) {

        bool isDark = box.get(
          "darkMode",
          defaultValue: false,
        );


        return MaterialApp(

          debugShowCheckedModeBanner: false,

          title: "Invoice Generator",


          theme: ThemeData(

            useMaterial3: true,

            brightness: Brightness.light,


            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff667eea),
            ),


            scaffoldBackgroundColor:
            const Color(0xfff6f7fb),


            appBarTheme: const AppBarTheme(

              centerTitle: true,

              elevation: 0,

              backgroundColor: Colors.transparent,

              foregroundColor: Colors.black,

              titleTextStyle: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

                color: Colors.black,

              ),

            ),



            cardTheme: CardThemeData(

              elevation: 3,

              shadowColor: Colors.black12,

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),

              ),

            ),



            inputDecorationTheme: InputDecorationTheme(

              filled: true,

              fillColor: Colors.white,


              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),


              border: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(14),

                borderSide: BorderSide.none,

              ),



              enabledBorder: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(14),

                borderSide: BorderSide.none,

              ),



              focusedBorder: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(14),

                borderSide: const BorderSide(

                  color: Color(0xff667eea),

                  width: 2,

                ),

              ),

            ),



            elevatedButtonTheme:
            ElevatedButtonThemeData(

              style: ElevatedButton.styleFrom(

                backgroundColor:
                const Color(0xff667eea),

                foregroundColor: Colors.white,


                padding:
                const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),


                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(14),

                ),

                textStyle:
                const TextStyle(

                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),


          ),



          darkTheme: ThemeData(

            useMaterial3: true,

            brightness: Brightness.dark,

          ),



          themeMode:
          isDark
              ? ThemeMode.dark
              : ThemeMode.light,


          home: const DashboardScreen(),

        );

      },

    );

  }

}