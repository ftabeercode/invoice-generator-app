import 'dart:typed_data';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/invoice_model.dart';


class PdfService {


  static Future<Uint8List> generateInvoicePdf(
      InvoiceModel invoice) async {


    final pdf =
    pw.Document();



    pw.ImageProvider? logo;



    if(invoice.logoPath.isNotEmpty){

      final file =
      File(invoice.logoPath);


      if(await file.exists()){

        logo =
            pw.MemoryImage(
              file.readAsBytesSync(),
            );

      }

    }




    pdf.addPage(

      pw.Page(

        pageFormat:
        PdfPageFormat.a4,


        margin:
        const pw.EdgeInsets.all(30),


        build:(context){


          return pw.Column(

            crossAxisAlignment:
            pw.CrossAxisAlignment.start,


            children:[



              // HEADER

              pw.Container(

                padding:
                const pw.EdgeInsets.all(20),


                decoration:
                pw.BoxDecoration(

                  color:
                  PdfColors.indigo,

                  borderRadius:
                  pw.BorderRadius.circular(15),

                ),



                child:

                pw.Row(

                  mainAxisAlignment:
                  pw.MainAxisAlignment.spaceBetween,


                  children:[



                    pw.Column(

                      crossAxisAlignment:
                      pw.CrossAxisAlignment.start,


                      children:[


                        pw.Text(

                          "INVOICE",

                          style:
                          pw.TextStyle(

                            color:
                            PdfColors.white,

                            fontSize:30,

                            fontWeight:
                            pw.FontWeight.bold,

                          ),

                        ),



                        pw.SizedBox(
                            height:5
                        ),



                        pw.Text(

                          invoice.invoiceNumber,

                          style:
                          const pw.TextStyle(

                            color:
                            PdfColors.white,

                          ),

                        ),

                      ],

                    ),



                    if(logo!=null)

                      pw.Image(

                        logo,

                        width:70,

                        height:70,

                      )



                  ],

                ),

              ),





              pw.SizedBox(height:25),




              // DATE INFORMATION

              pw.Row(

                mainAxisAlignment:
                pw.MainAxisAlignment.spaceBetween,


                children:[


                  pw.Text(
                    "Invoice Date: ${invoice.invoiceDate}",
                  ),


                  pw.Text(
                    "Due Date: ${invoice.dueDate}",
                  ),


                ],

              ),




              pw.SizedBox(height:20),





              // COMPANY CUSTOMER

              pw.Row(

                children:[



                  pw.Expanded(

                    child:

                    _infoBox(

                      "From",

                      [

                        invoice.companyName,

                        invoice.companyAddress,

                        invoice.companyEmail,

                        invoice.companyPhone,

                      ],

                    ),

                  ),




                  pw.SizedBox(
                      width:20
                  ),




                  pw.Expanded(

                    child:

                    _infoBox(

                      "Bill To",

                      [

                        invoice.customerName,

                        invoice.customerAddress,

                        invoice.customerEmail,

                        invoice.customerPhone,

                      ],

                    ),

                  ),



                ],

              ),





              pw.SizedBox(height:25),





              // SUMMARY


              pw.Container(

                padding:
                const pw.EdgeInsets.all(15),


                decoration:
                pw.BoxDecoration(

                  color:
                  PdfColors.grey100,

                  borderRadius:
                  pw.BorderRadius.circular(10),

                ),



                child:

                pw.Column(

                  children:[


                    _summaryRow(
                        "Subtotal",
                        "\$${invoice.subtotal}"
                    ),


                    _summaryRow(
                        "Tax",
                        "${invoice.tax}%"
                    ),



                    _summaryRow(
                        "Discount",
                        "${invoice.discount}%"
                    ),



                    pw.Divider(),




                    _summaryRow(

                      "Grand Total",

                      "\$${invoice.grandTotal}",

                      bold:true,

                    ),


                  ],

                ),

              ),





              pw.SizedBox(height:20),





              // STATUS


              pw.Container(

                padding:
                const pw.EdgeInsets.all(10),


                decoration:
                pw.BoxDecoration(

                  color:
                  invoice.status=="Paid"

                      ?

                  PdfColors.green100

                      :

                  PdfColors.orange100,


                  borderRadius:
                  pw.BorderRadius.circular(8),

                ),


                child:

                pw.Text(

                  "Status: ${invoice.status}",

                  style:
                  pw.TextStyle(

                    fontWeight:
                    pw.FontWeight.bold,

                  ),

                ),

              ),




              pw.SizedBox(height:20),




              _section(

                "Notes",

                invoice.notes,

              ),



              pw.SizedBox(height:10),



              _section(

                "Payment Instructions",

                invoice.paymentInstructions,

              ),




              pw.Spacer(),




              pw.Center(

                child:

                pw.Text(

                  "Thank you for your business!",

                  style:
                  const pw.TextStyle(

                    color:
                    PdfColors.grey,

                  ),

                ),

              )



            ],

          );


        },

      ),

    );



    return pdf.save();

  }






  static pw.Widget _infoBox(
      String title,
      List<String> data
      ){


    return pw.Container(

      padding:
      const pw.EdgeInsets.all(12),


      decoration:
      pw.BoxDecoration(

        border:
        pw.Border.all(
          color:
          PdfColors.grey300,
        ),


        borderRadius:
        pw.BorderRadius.circular(10),

      ),



      child:

      pw.Column(

        crossAxisAlignment:
        pw.CrossAxisAlignment.start,


        children:[


          pw.Text(

            title,

            style:
            pw.TextStyle(

              fontWeight:
              pw.FontWeight.bold,

            ),

          ),


          pw.SizedBox(height:8),



          ...data.map(
                  (e)=>pw.Text(e)
          ),



        ],

      ),

    );

  }






  static pw.Widget _summaryRow(
      String title,
      String value,
      {
        bool bold=false
      }
      ){


    return pw.Padding(

      padding:
      const pw.EdgeInsets.symmetric(
          vertical:5
      ),


      child:

      pw.Row(

        mainAxisAlignment:
        pw.MainAxisAlignment.spaceBetween,


        children:[


          pw.Text(

            title,

            style:
            pw.TextStyle(

              fontWeight:
              bold
                  ?
              pw.FontWeight.bold
                  :
              pw.FontWeight.normal,

            ),

          ),



          pw.Text(

            value,

            style:
            pw.TextStyle(

              fontWeight:
              bold
                  ?
              pw.FontWeight.bold
                  :
              pw.FontWeight.normal,

            ),

          ),



        ],

      ),

    );

  }







  static pw.Widget _section(
      String title,
      String value
      ){


    return pw.Container(

      padding:
      const pw.EdgeInsets.all(12),


      decoration:
      pw.BoxDecoration(

        color:
        PdfColors.grey100,

        borderRadius:
        pw.BorderRadius.circular(10),

      ),



      child:

      pw.Column(

        crossAxisAlignment:
        pw.CrossAxisAlignment.start,


        children:[


          pw.Text(

            title,

            style:
            pw.TextStyle(

              fontWeight:
              pw.FontWeight.bold,

            ),

          ),



          pw.SizedBox(height:5),


          pw.Text(value),


        ],

      ),

    );

  }



}