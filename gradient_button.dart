import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final List<Color> colors;


  const GradientButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.colors = const [
      Color(0xff667eea),
      Color(0xff764ba2),
    ],
  });



  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      height: 55,


      decoration: BoxDecoration(

        gradient: LinearGradient(

          colors: colors,

          begin: Alignment.centerLeft,

          end: Alignment.centerRight,

        ),


        borderRadius:
        BorderRadius.circular(16),


        boxShadow: [

          BoxShadow(

            color:
            colors.first.withOpacity(0.25),

            blurRadius: 10,

            offset:
            const Offset(0, 5),

          ),

        ],

      ),



      child: ElevatedButton.icon(

        onPressed: onPressed,


        icon: Icon(

          icon,

          color: Colors.white,

        ),


        label: Text(

          text,


          style: const TextStyle(

            color: Colors.white,

            fontSize: 16,

            fontWeight:
            FontWeight.bold,

          ),

        ),



        style:
        ElevatedButton.styleFrom(

          backgroundColor:
          Colors.transparent,


          shadowColor:
          Colors.transparent,


          elevation: 0,


          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(16),

          ),

        ),

      ),

    );

  }

}