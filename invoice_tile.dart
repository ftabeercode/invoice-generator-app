import 'package:flutter/material.dart';

class InvoiceTile extends StatelessWidget {
  final TextEditingController itemController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final VoidCallback onChanged;

  const InvoiceTile({
    super.key,
    required this.itemController,
    required this.quantityController,
    required this.priceController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff667eea),
                        Color(0xff764ba2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                const Text(
                  "Invoice Item",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),


            const SizedBox(height: 18),


            TextFormField(
              controller: itemController,
              decoration: InputDecoration(
                labelText: "Item Name",
                prefixIcon: const Icon(Icons.inventory_2_outlined),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),


            const SizedBox(height: 14),


            Row(
              children: [

                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => onChanged(),

                    decoration: InputDecoration(
                      labelText: "Quantity",
                      prefixIcon: const Icon(Icons.numbers),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),


                const SizedBox(width: 12),


                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => onChanged(),

                    decoration: InputDecoration(
                      labelText: "Unit Price",
                      prefixIcon: const Icon(Icons.currency_rupee),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(height: 15),


            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.calculate_outlined,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    "Amount updates automatically",
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}