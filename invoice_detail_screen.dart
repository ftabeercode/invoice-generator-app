import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../models/invoice_model.dart';
import '../services/pdf_service.dart';
import 'edit_invoice_screen.dart';
import '../widgets/gradient_button.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final InvoiceModel invoice;
  final int index;

  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
    required this.index,
  });

  @override
  State<InvoiceDetailScreen> createState() =>
      _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState
    extends State<InvoiceDetailScreen> {
  void deleteInvoice() {
    Hive.box<InvoiceModel>("invoices")
        .deleteAt(widget.index);

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Invoice Deleted",
        ),
      ),
    );
  }

  Future<void> shareInvoice() async {
    final pdfData =
    await PdfService.generateInvoicePdf(
      widget.invoice,
    );

    final directory =
    await getTemporaryDirectory();

    final file = File(
      '${directory.path}/${widget.invoice.invoiceNumber}.pdf',
    );

    await file.writeAsBytes(pdfData);

    await Share.shareXFiles(
      [XFile(file.path)],
      text:
      'Invoice ${widget.invoice.invoiceNumber}',
    );
  }

  void markPaid() {
    widget.invoice.status =
    widget.invoice.status == "Paid"
        ? "Unpaid"
        : "Paid";

    widget.invoice.save();

    setState(() {});
  }

  void duplicateInvoice() {
    Hive.box<InvoiceModel>("invoices")
        .add(
      InvoiceModel(
        invoiceNumber:
        "${widget.invoice.invoiceNumber}-COPY",
        invoiceDate:
        widget.invoice.invoiceDate,
        dueDate: widget.invoice.dueDate,
        companyName:
        widget.invoice.companyName,
        companyAddress:
        widget.invoice.companyAddress,
        companyEmail:
        widget.invoice.companyEmail,
        companyPhone:
        widget.invoice.companyPhone,
        customerName:
        widget.invoice.customerName,
        customerAddress:
        widget.invoice.customerAddress,
        customerEmail:
        widget.invoice.customerEmail,
        customerPhone:
        widget.invoice.customerPhone,
        subtotal:
        widget.invoice.subtotal,
        grandTotal:
        widget.invoice.grandTotal,
        tax: widget.invoice.tax,
        discount:
        widget.invoice.discount,
        notes:
        widget.invoice.notes,
        paymentInstructions:
        widget.invoice
            .paymentInstructions,
        status: "Unpaid",
        logoPath:
        widget.invoice.logoPath,
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
        Text("Invoice Duplicated"),
      ),
    );
  }

  Color getStatusColor(
      String status) {
    switch (status) {
      case "Paid":
        return Colors.green;

      case "Overdue":
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;

    String status = invoice.status;

    if (status != "Paid" &&
        invoice.dueDate.isNotEmpty &&
        DateTime.now().isAfter(
          DateTime.parse(
            invoice.dueDate,
          ),
        )) {
      status = "Overdue";
    }

    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        title: Text(
          invoice.invoiceNumber,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration:
          const BoxDecoration(
            gradient:
            LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
          ),
        ),
      ),

      body: ListView(
        padding:
        const EdgeInsets.all(16),
        children: [

          // TOP CARD
          Card(
            elevation: 5,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [

                        Text(
                          invoice
                              .invoiceNumber,
                          style:
                          const TextStyle(
                            fontSize:
                            24,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                            10),

                        Text(
                          "Invoice Date:\n${invoice.invoiceDate}",
                        ),

                        const SizedBox(
                            height:
                            10),

                        Text(
                          "Due Date:\n${invoice.dueDate}",
                        ),
                      ],
                    ),
                  ),

                  if (invoice
                      .logoPath
                      .isNotEmpty)
                    ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(
                        15,
                      ),
                      child:
                      Image.file(
                        File(
                          invoice
                              .logoPath,
                        ),
                        width:
                        90,
                        height:
                        90,
                        fit: BoxFit
                            .cover,
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(
              height: 20),

          // STATUS
          Center(
            child: Chip(
              backgroundColor:
              getStatusColor(
                status,
              ),
              label: Text(
                status,
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontWeight:
                  FontWeight
                      .bold,
                ),
              ),
            ),
          ),

          const SizedBox(
              height: 20),

          // CUSTOMER CARD
          Card(
            elevation: 5,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [

                  const Text(
                    "Customer Information",
                    style:
                    TextStyle(
                      fontSize:
                      20,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const Divider(),

                  Text(
                    "Name: ${invoice.customerName}",
                  ),

                  Text(
                    "Email: ${invoice.customerEmail}",
                  ),

                  Text(
                    "Phone: ${invoice.customerPhone}",
                  ),

                  Text(
                    "Address: ${invoice.customerAddress}",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
              height: 20),

          // SUMMARY CARD
          Card(
            elevation: 5,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),
              child: Column(
                children: [

                  const Text(
                    "Invoice Summary",
                    style:
                    TextStyle(
                      fontSize:
                      20,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                      15),

                  ListTile(
                    title:
                    const Text(
                      "Subtotal",
                    ),
                    trailing:
                    Text(
                      "\$${invoice.subtotal}",
                    ),
                  ),

                  ListTile(
                    title:
                    const Text(
                      "Tax",
                    ),
                    trailing:
                    Text(
                      "${invoice.tax}%",
                    ),
                  ),

                  ListTile(
                    title:
                    const Text(
                      "Discount",
                    ),
                    trailing:
                    Text(
                      "${invoice.discount}%",
                    ),
                  ),

                  const Divider(),

                  ListTile(
                    title:
                    const Text(
                      "Grand Total",
                      style:
                      TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                    trailing:
                    Text(
                      "\$${invoice.grandTotal}",
                      style:
                      const TextStyle(
                        fontSize:
                        20,
                        fontWeight:
                        FontWeight
                            .bold,
                        color: Colors
                            .green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
              height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditInvoiceScreen(
                        invoice:
                        widget.invoice,
                        index:
                        widget.index,
                      ),
                ),
              );
            },
            icon:
            const Icon(Icons.edit),
            label: const Text(
              "Edit Invoice",
            ),
          ),

          const SizedBox(
              height: 10),

          ElevatedButton.icon(
            onPressed: markPaid,
            icon: const Icon(
              Icons.check,
            ),
            label: Text(
              invoice.status ==
                  "Paid"
                  ? "Mark Unpaid"
                  : "Mark Paid",
            ),
          ),

          const SizedBox(
              height: 10),

          ElevatedButton.icon(
            onPressed:
            duplicateInvoice,
            icon: const Icon(
              Icons.copy,
            ),
            label: const Text(
              "Duplicate Invoice",
            ),
          ),

          const SizedBox(
              height: 10),

          ElevatedButton.icon(
            onPressed: () async {
              final pdf =
              await PdfService
                  .generateInvoicePdf(
                widget.invoice,
              );

              await Printing
                  .layoutPdf(
                onLayout:
                    (_) async =>
                pdf,
              );
            },
            icon:
            const Icon(Icons.picture_as_pdf),
            label: const Text(
              "Generate PDF",
            ),
          ),

          const SizedBox(
              height: 10),

          ElevatedButton.icon(
            onPressed:
            shareInvoice,
            icon:
            const Icon(Icons.share),
            label: const Text(
              "Share Invoice",
            ),
          ),

          const SizedBox(
              height: 10),

          ElevatedButton.icon(
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              Colors.red,
            ),
            onPressed:
            deleteInvoice,
            icon:
            const Icon(Icons.delete),
            label: const Text(
              "Delete Invoice",
            ),
          ),

          const SizedBox(
              height: 30),
        ],
      ),
    );
  }
}