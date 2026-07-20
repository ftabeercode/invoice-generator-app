import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/invoice_model.dart';
import 'company_info_screen.dart';


class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});


  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();

}



class _SettingsScreenState
    extends State<SettingsScreen> {


  void clearInvoices(){

    showDialog(

      context: context,

      builder: (context)=>AlertDialog(

        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(20),

        ),


        title:
        const Text(
          "Clear All Invoices",
        ),


        content:
        const Text(
          "Are you sure you want to delete all invoices?",
        ),


        actions:[


          TextButton(

            onPressed:(){

              Navigator.pop(context);

            },

            child:
            const Text(
              "Cancel",
            ),

          ),



          ElevatedButton(

            style:
            ElevatedButton.styleFrom(

              backgroundColor:
              Colors.red,

            ),


            onPressed:(){


              Hive.box<InvoiceModel>(
                  "invoices"
              ).clear();



              Navigator.pop(context);



              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(

                  content:
                  Text(
                    "All invoices deleted!",
                  ),

                ),

              );


              setState(() {});

            },


            child:
            const Text(
              "Delete",
            ),

          ),

        ],

      ),

    );

  }





  Widget settingCard({

    required IconData icon,

    required String title,

    required String subtitle,

    required VoidCallback onTap,

    Color color = Colors.indigo,

  }){


    return Card(

      elevation:3,


      shape:
      RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(18),

      ),


      child:
      ListTile(

        contentPadding:
        const EdgeInsets.all(15),


        leading:
        Container(

          padding:
          const EdgeInsets.all(12),


          decoration:
          BoxDecoration(

            color:
            color.withOpacity(.15),


            borderRadius:
            BorderRadius.circular(14),

          ),


          child:
          Icon(

            icon,

            color:
            color,

          ),

        ),


        title:
        Text(

          title,

          style:
          const TextStyle(

            fontWeight:
            FontWeight.bold,

          ),

        ),


        subtitle:
        Text(
          subtitle,
        ),


        trailing:
        const Icon(
          Icons.arrow_forward_ios,
          size:16,
        ),


        onTap:
        onTap,


      ),

    );

  }






  @override
  Widget build(BuildContext context) {


    final settingsBox =
    Hive.box("settings");


    final invoiceBox =
    Hive.box<InvoiceModel>(
        "invoices"
    );



    return Scaffold(


      appBar:
      AppBar(

        title:
        const Text(
          "Settings",
        ),

      ),



      body:
      ListView(

        padding:
        const EdgeInsets.all(16),


        children:[




          Container(

            padding:
            const EdgeInsets.all(25),


            decoration:
            BoxDecoration(

              gradient:
              const LinearGradient(

                colors:[

                  Color(0xff667eea),

                  Color(0xff764ba2),

                ],

              ),


              borderRadius:
              BorderRadius.circular(25),

            ),



            child:
            Column(

              children:[


                const CircleAvatar(

                  radius:45,


                  backgroundColor:
                  Colors.white,


                  child:
                  Text(

                    "TF",

                    style:
                    TextStyle(

                      fontSize:30,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Colors.deepPurple,

                    ),

                  ),

                ),



                const SizedBox(
                  height:15,
                ),



                const Text(

                  "Invoice Generator",

                  style:
                  TextStyle(

                    color:
                    Colors.white,

                    fontSize:25,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),



                const SizedBox(
                  height:5,
                ),



                const Text(

                  "Professional Invoice Management App",

                  style:
                  TextStyle(

                    color:
                    Colors.white70,

                  ),

                ),



                const SizedBox(
                  height:5,
                ),



                const Text(

                  "Version 1.0.0",

                  style:
                  TextStyle(

                    color:
                    Colors.white70,

                  ),

                ),


              ],

            ),

          ),




          const SizedBox(
            height:25,
          ),




          Card(

            elevation:3,


            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(18),

            ),


            child:
            SwitchListTile(

              secondary:
              Container(

                padding:
                const EdgeInsets.all(10),


                decoration:
                BoxDecoration(

                  color:
                  Colors.indigo.withOpacity(.15),

                  borderRadius:
                  BorderRadius.circular(12),

                ),


                child:
                const Icon(
                  Icons.dark_mode,
                  color:Colors.indigo,
                ),

              ),


              title:
              const Text(
                "Dark Mode",
                style:
                TextStyle(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),


              value:
              settingsBox.get(
                "darkMode",
                defaultValue:false,
              ),


              onChanged:(value){

                settingsBox.put(
                    "darkMode",
                    value
                );


                setState(() {});

              },

            ),

          ),




          const SizedBox(height:10),




          settingCard(

            icon:
            Icons.business,

            title:
            "Company Information",

            subtitle:
            "Manage company details",

            color:
            Colors.blue,


            onTap:(){

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder:(_)=>
                  const CompanyInfoScreen(),

                ),

              );

            },

          ),





          const SizedBox(height:10),





          settingCard(

            icon:
            Icons.bar_chart,


            title:
            "Statistics",


            subtitle:
            "Total invoices: ${invoiceBox.length}",


            color:
            Colors.green,


            onTap:(){},


          ),





          const SizedBox(height:10),





          settingCard(

            icon:
            Icons.delete,


            title:
            "Clear All Invoices",


            subtitle:
            "Delete all saved invoices",


            color:
            Colors.red,


            onTap:
            clearInvoices,


          ),





          const SizedBox(height:10),




          settingCard(

            icon:
            Icons.person,


            title:
            "About Developer",


            subtitle:
            "Developed by Tabeer Fatima",


            color:
            Colors.purple,


            onTap:(){},


          ),





          const SizedBox(height:10),




          settingCard(

            icon:
            Icons.info,


            title:
            "App Version",


            subtitle:
            "Version 1.0.0",


            color:
            Colors.orange,


            onTap:(){},


          ),




        ],

      ),


    );

  }

}