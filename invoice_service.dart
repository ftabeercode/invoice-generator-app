import 'package:hive/hive.dart';
import '../models/invoice_model.dart';

class HiveService {
  static const String boxName = "invoices";

  static Future<void> saveInvoice(
      InvoiceModel invoice,
      ) async {
    final box =
    await Hive.openBox<InvoiceModel>(
      boxName,
    );

    await box.add(invoice);
  }

  static Future<List<InvoiceModel>>
  getInvoices() async {
    final box =
    await Hive.openBox<InvoiceModel>(
      boxName,
    );

    return box.values.toList();
  }

  static Future<void> deleteInvoice(
      int index,
      ) async {
    final box =
    await Hive.openBox<InvoiceModel>(
      boxName,
    );

    await box.deleteAt(index);
  }

  static Future<void> updateInvoice(
      int index,
      InvoiceModel invoice,
      ) async {
    final box =
    await Hive.openBox<InvoiceModel>(
      boxName,
    );

    await box.putAt(index, invoice);
  }
}