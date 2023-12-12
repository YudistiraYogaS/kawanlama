import 'dart:io';
import 'package:kawanlama/domain/constant/app_assets.dart';
import 'package:kawanlama/domain/constant/app_sizes.dart';
import 'package:kawanlama/domain/constant/app_strings.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/utilities/i10n/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<pw.Document> createPDF(List<ItemDTO> data) async {
  final doc = pw.Document();
  final image = await imageFromAssetBundle(AppAssets.imgLogo);
  final imagePaid = await imageFromAssetBundle(AppAssets.imgPaid);

  return doc
    ..addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Image(image, width: 40, height: 40),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.Text(AppStrings.company, style: pw.TextStyle(fontSize: AppSizes.s6, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 4),
                    pw.Text(AppStrings.address, style: pw.TextStyle(fontSize: AppSizes.s4)),
                    pw.Text(AppStrings.phone, style: pw.TextStyle(fontSize: AppSizes.s4)),
                  ]),
                )
              ]),
              pw.SizedBox(height: 16),
              if (data.isNotEmpty) ...[
                pw.Stack(children: [
                  pw.Column(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 2),
                      child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        pw.Expanded(child: pw.Text(I10n.current.surah_name, style: pw.TextStyle(fontSize: AppSizes.s4, fontWeight: pw.FontWeight.bold))),
                        pw.Text(I10n.current.qty, style: pw.TextStyle(fontSize: AppSizes.s4, fontWeight: pw.FontWeight.bold)),
                      ]),
                    ),
                    ...List.generate(
                      data.length,
                      (index) => pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 1),
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text('${data[index].name} (${data[index].mean})',
                                  style: pw.TextStyle(fontSize: AppSizes.s4, fontWeight: pw.FontWeight.bold)),
                            ),
                            pw.Text("${data[index].number}", style: pw.TextStyle(fontSize: AppSizes.s4, fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ]),
                  pw.Center(
                      child: pw.Opacity(
                          child: pw.Image(
                            imagePaid,
                          ),
                          opacity: 0.3)),
                ])
              ]
            ],
          );
        },
      ),
    ); // Page
}

Future<String> saveDocument(pw.Document doc) async {
  try {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${DateTime.now()}.pdf');
    await file.writeAsBytes(await doc.save());
    return file.path;
  } catch (e) {
    rethrow;
  }
}

Future<void> printingDocument(pw.Document doc) async {
  try {
    await Printing.layoutPdf(format: PdfPageFormat.roll57, onLayout: (PdfPageFormat format) async => doc.save());
  } catch (e) {
    rethrow;
  }
}

Future<void> shareDocument(pw.Document doc) async {
  try {
    await Printing.sharePdf(bytes: await doc.save(), filename: '${DateTime.now()}.pdf');
  } catch (e) {
    rethrow;
  }
}

PdfPreview previewDocument(pw.Document doc) {
  try {
    return PdfPreview(build: (format) => doc.save());
  } catch (e) {
    rethrow;
  }
}
