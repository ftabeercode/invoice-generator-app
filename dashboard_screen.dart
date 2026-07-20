import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/invoice_model.dart';
import '../widgets/dashboard_card.dart';
import 'create_invoice_screen.dart';
import 'invoice_list_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
          ),
        ),
        title: const Text(
          "Invoice Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF6A11CB),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Create Invoice",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const CreateInvoiceScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(20),
                gradient:
                const LinearGradient(
                  colors: [
                    Color(0xFF6A11CB),
                    Color(0xFF2575FC),
                  ],
                ),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor:
                    Colors.white,
                    child: Icon(
                      Icons.receipt_long,
                      color:
                      Colors.deepPurple,
                      size: 35,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 24,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Manage your invoices easily",
                        style: TextStyle(
                          color:
                          Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DASHBOARD GRID
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [

                  // INVOICES
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const InvoiceListScreen(),
                        ),
                      );
                    },
                    child:
                    ValueListenableBuilder(
                      valueListenable:
                      Hive.box<
                          InvoiceModel>(
                        "invoices",
                      ).listenable(),
                      builder:
                          (context, box, _) {
                        return DashboardCard(
                          title:
                          "Invoices",
                          value: box.length
                              .toString(),
                          icon:
                          Icons.receipt,
                        );
                      },
                    ),
                  ),

                  // PAID
                  ValueListenableBuilder(
                    valueListenable:
                    Hive.box<
                        InvoiceModel>(
                      "invoices",
                    ).listenable(),
                    builder:
                        (context, box, _) {
                      int paid = box.values
                          .where(
                            (invoice) =>
                        invoice
                            .status ==
                            "Paid",
                      )
                          .length;

                      return DashboardCard(
                        title: "Paid",
                        value:
                        paid.toString(),
                        icon: Icons
                            .check_circle,
                      );
                    },
                  ),

                  // UNPAID
                  ValueListenableBuilder(
                    valueListenable:
                    Hive.box<
                        InvoiceModel>(
                      "invoices",
                    ).listenable(),
                    builder:
                        (context, box, _) {
                      int unpaid = box
                          .values
                          .where(
                            (invoice) =>
                        invoice
                            .status ==
                            "Unpaid",
                      )
                          .length;

                      return DashboardCard(
                        title:
                        "Unpaid",
                        value: unpaid
                            .toString(),
                        icon: Icons.cancel,
                      );
                    },
                  ),

                  // REVENUE
                  ValueListenableBuilder(
                    valueListenable:
                    Hive.box<
                        InvoiceModel>(
                      "invoices",
                    ).listenable(),
                    builder:
                        (context, box, _) {
                      double revenue =
                      box.values.fold(
                        0.0,
                            (sum, invoice) =>
                        sum +
                            invoice
                                .grandTotal,
                      );

                      return DashboardCard(
                        title:
                        "Revenue",
                        value:
                        "\$${revenue.toStringAsFixed(0)}",
                        icon: Icons
                            .attach_money,
                      );
                    },
                  ),

                  // OVERDUE
                  ValueListenableBuilder(
                    valueListenable:
                    Hive.box<
                        InvoiceModel>(
                      "invoices",
                    ).listenable(),
                    builder:
                        (context, box, _) {
                      int overdue =
                          box.values.where(
                                (invoice) {
                              return invoice
                                  .status !=
                                  "Paid" &&
                                  invoice
                                      .dueDate
                                      .isNotEmpty &&
                                  DateTime.now()
                                      .isAfter(
                                    DateTime.parse(
                                      invoice
                                          .dueDate,
                                    ),
                                  );
                            },
                          ).length;

                      return DashboardCard(
                        title:
                        "Overdue",
                        value: overdue
                            .toString(),
                        icon: Icons.warning,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Align(
              alignment:
              Alignment.centerLeft,
              child: Text(
                "Recent Invoice",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ValueListenableBuilder(
              valueListenable:
              Hive.box<InvoiceModel>(
                "invoices",
              ).listenable(),
              builder:
                  (context, box, _) {
                if (box.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding:
                      EdgeInsets.all(
                        20,
                      ),
                      child: Text(
                        "No invoices available.",
                      ),
                    ),
                  );
                }

                final latest =
                box.getAt(
                  box.length - 1,
                );

                return Card(
                  elevation: 6,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                      20,
                    ),
                  ),
                  child: ListTile(
                    leading:
                    const CircleAvatar(
                      child: Icon(
                        Icons.receipt,
                      ),
                    ),
                    title: Text(
                      latest!
                          .invoiceNumber,
                    ),
                    subtitle: Text(
                      latest
                          .customerName,
                    ),
                    trailing: Text(
                      "\$${latest.grandTotal}",
                      style:
                      const TextStyle(
                        color:
                        Colors.green,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}