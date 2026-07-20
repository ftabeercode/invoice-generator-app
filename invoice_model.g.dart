// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceModelAdapter extends TypeAdapter<InvoiceModel> {
  @override
  final int typeId = 0;

  @override
  InvoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceModel(
      invoiceNumber: fields[0] as String,
      invoiceDate: fields[1] as String,
      dueDate: fields[2] as String,
      companyName: fields[3] as String,
      companyAddress: fields[4] as String,
      companyEmail: fields[5] as String,
      companyPhone: fields[6] as String,
      customerName: fields[7] as String,
      customerAddress: fields[8] as String,
      customerEmail: fields[9] as String,
      customerPhone: fields[10] as String,
      subtotal: fields[11] as double,
      grandTotal: fields[12] as double,
      tax: fields[13] as double,
      discount: fields[14] as double,
      notes: fields[15] as String,
      paymentInstructions: fields[16] as String,
      status: fields[17] as String,
      logoPath: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.invoiceNumber)
      ..writeByte(1)
      ..write(obj.invoiceDate)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.companyAddress)
      ..writeByte(5)
      ..write(obj.companyEmail)
      ..writeByte(6)
      ..write(obj.companyPhone)
      ..writeByte(7)
      ..write(obj.customerName)
      ..writeByte(8)
      ..write(obj.customerAddress)
      ..writeByte(9)
      ..write(obj.customerEmail)
      ..writeByte(10)
      ..write(obj.customerPhone)
      ..writeByte(11)
      ..write(obj.subtotal)
      ..writeByte(12)
      ..write(obj.grandTotal)
      ..writeByte(13)
      ..write(obj.tax)
      ..writeByte(14)
      ..write(obj.discount)
      ..writeByte(15)
      ..write(obj.notes)
      ..writeByte(16)
      ..write(obj.paymentInstructions)
      ..writeByte(17)
      ..write(obj.status)
      ..writeByte(18)
      ..write(obj.logoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
