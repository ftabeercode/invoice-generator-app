import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  Color getCardColor() {
    switch (title) {
      case "Invoices":
        return const Color(0xFF6A11CB);

      case "Paid":
        return Colors.green;

      case "Unpaid":
        return Colors.red;

      case "Revenue":
        return Colors.teal;

      case "Overdue":
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),

        gradient: LinearGradient(
          colors: [
            getCardColor(),
            getCardColor()
                .withOpacity(0.7),
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: getCardColor()
                .withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Card(
        color: Colors.transparent,
        elevation: 0,

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
            20,
          ),
        ),

        child: SizedBox(
          width: 150,
          height: 140,

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment
                .center,

            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor:
                Colors.white,

                child: Icon(
                  icon,
                  size: 30,
                  color: getCardColor(),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                value,
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontSize: 24,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Text(
                title,
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}