import 'package:flutter_firebase_ecommerce/models/cart_item_model.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void showErrorSnackbar({title, message}) {
    Get.snackbar(title, message,
        colorText: Colors.redAccent, backgroundColor: Colors.red[50]);
  }

  static void showSucessSnackbar({title, message}) {
    Get.snackbar(title, message,
        colorText: Colors.blueAccent, backgroundColor: Colors.blue[50]);
  }

  static void generatePDF(List<CartItemModel> cartItens, double price) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(
          child: pw.Column(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(20.0),
            child: pw.Table(children: [
              pw.TableRow(children: [
                pw.Text('PRODUTO',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Text('QUANTIDADE',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Text('VALOR',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ])
            ]),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(20.0),
            child: pw.Table(
              children: cartItens
                  .map((cartItem) => pw.TableRow(children: [
                        pw.Text(cartItem.product.name,
                            style: const pw.TextStyle(fontSize: 18)),
                        pw.Center(
                          child: pw.Text(cartItem.quantity.toString(),
                              style: const pw.TextStyle(fontSize: 18)),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              'R\$ ${cartItem.totalItemPrice.toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 18)),
                        )
                      ]))
                  .toList(),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 20),
            child: pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'TOTAL: R\$ ${price.toStringAsFixed(2)}',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
          )
        ],
      )),
    ));

    var pdfBytes = await pdf.save();

    WcFlutterShare.share(
        sharePopupTitle: 'Pedido',
        fileName: 'Pedido.pdf',
        mimeType: 'application/pdf',
        bytesOfFile: pdfBytes);
  }
}
