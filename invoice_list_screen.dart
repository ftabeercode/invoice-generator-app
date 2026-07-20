import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/invoice_model.dart';
import 'invoice_detail_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() =>
      _InvoiceListScreenState();
}

class _InvoiceListScreenState
    extends State<InvoiceListScreen> {
  final TextEditingController searchController =
  TextEditingController();

  String selectedStatus = "All";

  bool isOverdue(InvoiceModel invoice) {
    if (invoice.status == "Paid") {
      return false;
    }

    if (invoice.dueDate.isEmpty) {
      return false;
    }

    return DateTime.now().isAfter(
      DateTime.parse(invoice.dueDate),
    );
  }

  Color getStatusColor(String status) {
    if (status == "Paid") {
      return Colors.green;
    }

    if (status == "Overdue") {
      return Colors.red;
    }

    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final invoiceBox =
    Hive.box<InvoiceModel>("invoices");

    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "All Invoices",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      ),

      body: Column(
        children: [

          // SEARCH BAR
          Padding(
            padding:
            const EdgeInsets.all(16),
            child: TextField(
              controller:
              searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration:
              InputDecoration(
                hintText:
                "Search Invoice...",
                prefixIcon:
                const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor:
                Colors.white,
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                    20,
                  ),
                  borderSide:
                  BorderSide
                      .none,
                ),
              ),
            ),
          ),

          // FILTER
          Padding(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child:
            DropdownButtonFormField<
                String>(
              value:
              selectedStatus,
              decoration:
              InputDecoration(
                filled: true,
                fillColor:
                Colors.white,
                labelText:
                "Filter Status",
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                    15,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "All",
                  child: Text(
                    "All",
                  ),
                ),
                DropdownMenuItem(
                  value: "Paid",
                  child: Text(
                    "Paid",
                  ),
                ),
                DropdownMenuItem(
                  value: "Unpaid",
                  child: Text(
                    "Unpaid",
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedStatus =
                  value!;
                });
              },
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Expanded(
            child:
            ValueListenableBuilder(
              valueListenable:
              invoiceBox.listenable(),
              builder: (
                  context,
                  Box<InvoiceModel> box,
                  _,
                  ) {
                if (box.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Invoices Found",
                      style:
                      TextStyle(
                        fontSize:
                        22,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  );
                }

                List<InvoiceModel>
                invoices =
                box.values.toList();

                invoices = invoices
                    .where(
                      (invoice) {
                    final query =
                    searchController
                        .text
                        .toLowerCase();

                    bool
                    matchesSearch =
                        invoice
                            .invoiceNumber
                            .toLowerCase()
                            .contains(
                          query,
                        ) ||
                            invoice
                                .customerName
                                .toLowerCase()
                                .contains(
                              query,
                            );

                    bool
                    matchesStatus =
                        selectedStatus ==
                            "All" ||
                            invoice
                                .status ==
                                selectedStatus;

                    return matchesSearch &&
                        matchesStatus;
                  },
                )
                    .toList();

                if (invoices
                    .isEmpty) {
                  return const Center(
                    child: Text(
                      "No Matching Invoice Found",
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                  const EdgeInsets
                      .all(10),
                  itemCount:
                  invoices.length,
                  itemBuilder:
                      (context,
                      index) {
                    final invoice =
                    invoices[index];

                    String status =
                        invoice
                            .status;

                    if (isOverdue(
                      invoice,
                    )) {
                      status =
                      "Overdue";
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                InvoiceDetailScreen(
                                  invoice:
                                  invoice,
                                  index: box
                                      .values
                                      .toList()
                                      .indexOf(
                                    invoice,
                                  ),
                                ),
                          ),
                        );
                      },
                      child: Card(
                        elevation:
                        8,
                        margin:
                        const EdgeInsets
                            .only(
                          bottom:
                          15,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),
                        child:
                        Padding(
                          padding:
                          const EdgeInsets.all(
                            16,
                          ),
                          child:
                          Column(
                            children: [

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text(
                                          invoice.invoiceNumber,
                                          style:
                                          const TextStyle(
                                            fontSize:
                                            22,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                          10,
                                        ),

                                        Text(
                                          "Customer: ${invoice.customerName}",
                                        ),

                                        Text(
                                          "Due: ${invoice.dueDate}",
                                        ),

                                        const SizedBox(
                                          height:
                                          10,
                                        ),

                                        Text(
                                          "Total: \$${invoice.grandTotal.toStringAsFixed(2)}",
                                          style:
                                          const TextStyle(
                                            color:
                                            Colors.green,
                                            fontSize:
                                            18,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  invoice
                                      .logoPath
                                      .isNotEmpty
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                      15,
                                    ),
                                    child:
                                    Image.file(
                                      File(
                                        invoice.logoPath,
                                      ),
                                      width:
                                      70,
                                      height:
                                      70,
                                      fit:
                                      BoxFit.cover,
                                    ),
                                  )
                                      : const CircleAvatar(
                                    radius:
                                    35,
                                    child:
                                    Icon(
                                      Icons.business,
                                      size:
                                      30,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height:
                                15,
                              ),

                              Row(
                                children: [

                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal:
                                      15,
                                      vertical:
                                      8,
                                    ),
                                    decoration:
                                    BoxDecoration(
                                      color:
                                      getStatusColor(
                                        status,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child:
                                    Text(
                                      status,
                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.white,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  IconButton(
                                    onPressed:
                                        () {
                                      int actualIndex =
                                      box.values
                                          .toList()
                                          .indexOf(
                                        invoice,
                                      );

                                      box.deleteAt(
                                        actualIndex,
                                      );

                                      ScaffoldMessenger.of(
                                          context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                          Text(
                                            "Invoice Deleted",
                                          ),
                                        ),
                                      );
                                    },
                                    icon:
                                    const Icon(
                                      Icons
                                          .delete,
                                      color:
                                      Colors.red,
                                    ),
                                  ),

                                  const Icon(
                                    Icons
                                        .arrow_forward_ios,
                                    size:
                                    18,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}