import 'package:hive/hive.dart';

part 'invoice_model.g.dart';

@HiveType(typeId: 0)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  String invoiceNumber;

  @HiveField(1)
  String invoiceDate;

  @HiveField(2)
  String dueDate;

  @HiveField(3)
  String companyName;

  @HiveField(4)
  String companyAddress;

  @HiveField(5)
  String companyEmail;

  @HiveField(6)
  String companyPhone;

  @HiveField(7)
  String customerName;

  @HiveField(8)
  String customerAddress;

  @HiveField(9)
  String customerEmail;

  @HiveField(10)
  String customerPhone;

  @HiveField(11)
  double subtotal;

  @HiveField(12)
  double grandTotal;

  @HiveField(13)
  double tax;

  @HiveField(14)
  double discount;

  @HiveField(15)
  String notes;

  @HiveField(16)
  String paymentInstructions;

  @HiveField(17)
  String status;

  @HiveField(18)
  String logoPath;


  InvoiceModel({
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    required this.companyName,
    required this.companyAddress,
    required this.companyEmail,
    required this.companyPhone,
    required this.customerName,
    required this.customerAddress,
    required this.customerEmail,
    required this.customerPhone,
    required this.subtotal,
    required this.grandTotal,
    required this.tax,
    required this.discount,
    required this.notes,
    required this.paymentInstructions,
    this.status = "Unpaid",
    required this.logoPath,
  });
}