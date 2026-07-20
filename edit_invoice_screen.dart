import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/invoice_model.dart';

class EditInvoiceScreen extends StatefulWidget {
  final InvoiceModel invoice;
  final int index;

  const EditInvoiceScreen({
    super.key,
    required this.invoice,
    required this.index,
  });

  @override
  State<EditInvoiceScreen> createState() =>
      _EditInvoiceScreenState();
}

class _EditInvoiceScreenState
    extends State<EditInvoiceScreen> {
  late TextEditingController invoiceNumberController;
  late TextEditingController customerNameController;
  late TextEditingController companyNameController;
  late TextEditingController grandTotalController;

  @override
  void initState() {
    super.initState();

    invoiceNumberController =
        TextEditingController(
          text: widget.invoice.invoiceNumber,
        );

    customerNameController =
        TextEditingController(
          text: widget.invoice.customerName,
        );

    companyNameController =
        TextEditingController(
          text: widget.invoice.companyName,
        );

    grandTotalController =
        TextEditingController(
          text:
          widget.invoice.grandTotal.toString(),
        );
  }

  void updateInvoice() {
    final box =
    Hive.box<InvoiceModel>("invoices");

    final updatedInvoice = InvoiceModel(
    invoiceNumber: invoiceNumberController.text,
    invoiceDate: widget.invoice.invoiceDate,
    dueDate: widget.invoice.dueDate,
    companyName: companyNameController.text,
    companyAddress: widget.invoice.companyAddress,
    companyEmail: widget.invoice.companyEmail,
    companyPhone: widget.invoice.companyPhone,
    customerName: customerNameController.text,
    customerAddress: widget.invoice.customerAddress,
    customerEmail: widget.invoice.customerEmail,
    customerPhone: widget.invoice.customerPhone,
    subtotal: widget.invoice.subtotal,
    grandTotal:
    double.tryParse(
    grandTotalController.text,
    ) ??
        0,
        tax: widget.invoice.tax,
    discount: widget.invoice.discount,
    notes: widget.invoice.notes,
    paymentInstructions:
    widget.invoice.paymentInstructions,
    status: widget.invoice.status,
    logoPath: widget.invoice.logoPath,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
        Text("Invoice Updated!"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Edit Invoice"),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller:
              invoiceNumberController,
              decoration:
              const InputDecoration(
                labelText:
                "Invoice Number",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              customerNameController,
              decoration:
              const InputDecoration(
                labelText:
                "Customer Name",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              companyNameController,
              decoration:
              const InputDecoration(
                labelText:
                "Company Name",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              grandTotalController,
              decoration:
              const InputDecoration(
                labelText:
                "Grand Total",
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed:
              updateInvoice,
              child: const Text(
                "Update Invoice",
              ),
            ),
          ],
        ),
      ),
    );
  }
}