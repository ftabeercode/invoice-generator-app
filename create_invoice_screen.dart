import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/invoice_model.dart';
import '../widgets/invoice_tile.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceItemData {
  final TextEditingController itemController =
  TextEditingController();

  final TextEditingController quantityController =
  TextEditingController();

  final TextEditingController priceController =
  TextEditingController();
}

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState
    extends State<CreateInvoiceScreen> {

  final _formKey = GlobalKey<FormState>();
  File? logoFile;

  // Invoice
  final TextEditingController invoiceController =
  TextEditingController(text: "INV-001");

  DateTime? invoiceDate;
  DateTime? dueDate;


  // Company
  final TextEditingController companyNameController =
  TextEditingController();

  final TextEditingController companyAddressController =
  TextEditingController();

  final TextEditingController companyEmailController =
  TextEditingController();

  final TextEditingController companyPhoneController =
  TextEditingController();

  // Customer
  final TextEditingController customerNameController =
  TextEditingController();

  final TextEditingController customerAddressController =
  TextEditingController();

  final TextEditingController customerEmailController =
  TextEditingController();

  final TextEditingController customerPhoneController =
  TextEditingController();

  // Summary
  final TextEditingController taxController =
  TextEditingController();

  final TextEditingController discountController =
  TextEditingController();

  final TextEditingController notesController =
  TextEditingController();

  final TextEditingController paymentController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    final companyBox = Hive.box("company");

    companyNameController.text =
        companyBox.get(
          "name",
          defaultValue: "",
        );

    companyAddressController.text =
        companyBox.get(
          "address",
          defaultValue: "",
        );

    companyEmailController.text =
        companyBox.get(
          "email",
          defaultValue: "",
        );

    companyPhoneController.text =
        companyBox.get(
          "phone",
          defaultValue: "",
        );
  }

  double subtotal = 0;
  double grandTotal = 0;


  // Invoice Items
  List<InvoiceItemData> invoiceItems = [];
  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        logoFile = File(image.path);
      });

      print("LOGO PATH:");
      print(image.path);
    }
  }
  Future<void> saveInvoice() async {
    final box = Hive.box<InvoiceModel>("invoices");

    String savedLogoPath = "";


    if (logoFile != null) {
      final directory =
      await getApplicationDocumentsDirectory();

      final savedImage = await logoFile!.copy(
        '${directory.path}/company_logo_${DateTime.now().millisecondsSinceEpoch}.png',
      );

      savedLogoPath = savedImage.path;
    }

    box.add(
      InvoiceModel(
        invoiceNumber: invoiceController.text,
        invoiceDate: invoiceDate?.toString() ?? "",
        dueDate: dueDate?.toString() ?? "",
        companyName: companyNameController.text,
        companyAddress: companyAddressController.text,
        companyEmail: companyEmailController.text,
        companyPhone: companyPhoneController.text,
        customerName: customerNameController.text,
        customerAddress: customerAddressController.text,
        customerEmail: customerEmailController.text,
        customerPhone: customerPhoneController.text,
        subtotal: subtotal,
        grandTotal: grandTotal,
        tax: double.tryParse(taxController.text) ?? 0,
        discount: double.tryParse(discountController.text) ?? 0,
        notes: notesController.text,
        paymentInstructions: paymentController.text,
        status: "Unpaid",

        // UPDATED
        logoPath: savedLogoPath,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Invoice Saved Successfully!",
        ),
      ),
    );

    Navigator.pop(context);
  }


  void addInvoiceItem() {
    setState(() {
      invoiceItems.add(
        InvoiceItemData(),
      );
    });
  }

  void calculateTotals() {
    subtotal = 0;

    for (var item in invoiceItems) {
      double quantity =
          double.tryParse(
              item.quantityController.text) ??
              0;

      double price =
          double.tryParse(
              item.priceController.text) ??
              0;

      subtotal += quantity * price;
    }

    double tax =
        double.tryParse(taxController.text) ?? 0;

    double discount =
        double.tryParse(
            discountController.text) ??
            0;

    grandTotal = subtotal +
        (subtotal * tax / 100) -
        (subtotal * discount / 100);

    setState(() {});
  }
  Future<void> selectInvoiceDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        invoiceDate = pickedDate;
      });
    }
  }

  Future<void> selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        dueDate = pickedDate;
      });
    }
  }
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Colors.indigo,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Create Invoice",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              // Invoice Information
              const Text(
                "Invoice Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: buildTextField(
                      controller: invoiceController,
                      label: "Invoice Number",
                      icon: Icons.receipt,
                    ),
                  ),

                  const SizedBox(width: 15),

                  GestureDetector(
                    onTap: pickLogo,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor:
                      Colors.grey.shade200,
                      backgroundImage:
                      logoFile != null
                          ? FileImage(
                        logoFile!,
                      )
                          : null,
                      child: logoFile == null
                          ? const Icon(
                        Icons.business,
                        size: 30,
                      )
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(18),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: selectInvoiceDate,
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  label: Text(
                    invoiceDate == null
                        ? "Select Invoice Date"
                        : DateFormat('dd/MM/yyyy').format(invoiceDate!),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(18),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: selectDueDate,
                  icon: const Icon(
                    Icons.event,
                    color: Colors.white,
                  ),
                  label: Text(
                    dueDate == null
                        ? "Select Due Date"
                        : DateFormat('dd/MM/yyyy').format(dueDate!),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Company Information
              const SizedBox(height: 30),

              const Text(
                "Company Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: companyNameController,
                label: "Company Name",
                icon: Icons.business,
              ),

              const SizedBox(height: 15),

              buildTextField(
                controller: companyAddressController,
                label: "Company Address",
                icon: Icons.location_on,
              ),

              const SizedBox(height: 15),

              buildTextField(
                controller: companyEmailController,
                label: "Company Email",
                icon: Icons.email,
              ),

              const SizedBox(height: 15),

              buildTextField(
                controller: companyPhoneController,
                label: "Company Phone",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 20),

              // Customer Information
              const SizedBox(height: 30),

              const Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: customerNameController,
                label: "Customer Name",
                icon: Icons.person,
              ),

              buildTextField(
                controller: customerAddressController,
                label: "Customer Address",
                icon: Icons.home,
              ),

              buildTextField(
                controller: customerEmailController,
                label: "Customer Email",
                icon: Icons.email,
              ),

              buildTextField(
                controller: customerPhoneController,
                label: "Customer Phone",
                icon: Icons.phone,
              ),

              // Invoice Items
              const SizedBox(height: 30),

              const Text(
                "Invoice Items",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(18),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: addInvoiceItem,
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add New Item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 20),

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: invoiceItems
                        .map(
                          (item) => InvoiceTile(
                        itemController: item.itemController,
                        quantityController:
                        item.quantityController,
                        priceController:
                        item.priceController,
                        onChanged: calculateTotals,
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),

              // Invoice Summary
              const SizedBox(height: 30),

              const Text(
                "Invoice Summary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: taxController,
                label: "Tax %",
                icon: Icons.percent,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              buildTextField(
                controller: discountController,
                label: "Discount %",
                icon: Icons.discount,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              Text(
                "Subtotal: \$${subtotal.toStringAsFixed(2)}",
                style:
                const TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Grand Total: \$${grandTotal.toStringAsFixed(2)}",
                style:
                const TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),


              const SizedBox(height: 30),

              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: notesController,
                label: "Notes",
                icon: Icons.note,
              ),

              const SizedBox(height: 15),

              buildTextField(
                controller: paymentController,
                label: "Payment Instructions",
                icon: Icons.payment,
              ),

              const SizedBox(height: 30),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),
                    onPressed: saveInvoice,
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Save Invoice",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

