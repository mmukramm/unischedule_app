import 'dart:io';

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unischedule_app/core/utils/date_formatter.dart';
import 'package:unischedule_app/features/data/models/activity_participant.dart';

import 'package:unischedule_app/features/data/models/participant.dart';

class PdfService {
  Future<Uint8List> generateParticipantPdf(
    ActivityParticipant activityParticipant,
  ) async {
    final pdf = pw.Document();

    List<Participant?>? participants = activityParticipant.participants;

    if (participants == null) return Uint8List(2);

    final data = participants
        .map((e) => [
              e!.stdCode,
              e.name,
              e.gender,
              e.phoneNumber,
              e.email,
            ])
        .toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        footer: (context) => pw.Container(
          alignment: pw.Alignment.center,
          margin: const pw.EdgeInsets.only(top: 24, left: 12, right: 12),
          child: pw.Text('${context.pageNumber}'),
        ),
        build: (context) {
          return [
            buildEventDetail(
              eventName: activityParticipant.title!,
              organizer: activityParticipant.organizer!,
              date: formatDateTime(dateTimeString: activityParticipant.eventDate!),
            ),
            pw.SizedBox(height: 32),
            pw.Text(
              'Daftar Peserta Kegiatan',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: [
                'NIM',
                'Nama Lengkap',
                'Jenis Kelamin',
                'Nomor Telepon',
                'Email',
              ],
              data: data,
              headerCellDecoration: pw.BoxDecoration(
                color: PdfColor.fromHex('F9F0A6'),
              ),
              headerPadding: const pw.EdgeInsets.all(12),
              headerAlignment: pw.Alignment.centerLeft,
              cellPadding: const pw.EdgeInsets.all(12),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
                decorationColor: PdfColor.fromHex('F9F0A6'),
              ),
            ),
          ];
        },
      ),
    );
    return await pdf.save();
  }

  pw.Widget buildEventDetail({
    required String eventName,
    required String organizer,
    required String date,
  }) =>
      pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  'Nama Kegiatan',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                width: 12,
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  eventName,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  'Penyelenggara',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                width: 12,
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  organizer,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 8,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  'Waktu',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                ':',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                width: 12,
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  date,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String filepath = '${output!.path}/$fileName.pdf';

    final file = File(filepath);

    await file.writeAsBytes(byteList);

    await OpenFile.open(
      file.path,
    );

    // await OpenFile.open(filepath);
    // OpenFile.open(filePath);
  }
}
