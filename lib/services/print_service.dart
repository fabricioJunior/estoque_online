// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const double inch = 72.0;
const double cm = inch / 2.54;
const double mm = inch / 25.4;

class PrintService {
  Future<void> printCodeBar(String svgImage) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.SvgImage(
                svg: svgImage,
                width: mm * 50,
                height: mm * 30,
              ),
            ); // Center
          },
          pageFormat: const PdfPageFormat(mm * 50, mm * 30)),
    ); // Page

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}
