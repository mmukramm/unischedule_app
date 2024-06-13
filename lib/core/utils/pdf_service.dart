import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:unischedule_app/features/data/models/user.dart';

class PdfService {
  Future<Uint8List> generateParticipantPdf() async {
    final pdf = pw.Document();

    // final users = [
    //   User(
    //       fullName: 'fullName1',
    //       nim: 'nim1',
    //       gender: 'gender1',
    //       phone: 'phone1',
    //       email: 'email1',
    //       image: '',),
    //   User(
    //       fullName: 'fullName2',
    //       nim: 'nim2',
    //       gender: 'gender2',
    //       phone: 'phone2',
    //       email: 'email2',
    //       image: '',),
    //   User(
    //       fullName: 'fullName3',
    //       nim: 'nim3',
    //       gender: 'gender3',
    //       phone: 'phone3',
    //       email: 'email3',
    //       image: '',),
    //   User(
    //       fullName: 'fullName4',
    //       nim: 'nim4',
    //       gender: 'gender4',
    //       phone: 'phone4',
    //       email: 'email4',
    //       image: '',),
    //   User(
    //       fullName: 'fullName5',
    //       nim: 'nim5',
    //       gender: 'gender5',
    //       phone: 'phone5',
    //       email: 'email5',
    //       image: '',),
    //   User(
    //       fullName: 'fullName6',
    //       nim: 'nim6',
    //       gender: 'gender6',
    //       phone: 'phone6',
    //       email: 'email6',
    //       image: '',),
    //   User(
    //       fullName: 'fullName7',
    //       nim: 'nim7',
    //       gender: 'gender7',
    //       phone: 'phone7',
    //       email: 'email7',
    //       image: '',),
    //   User(
    //       fullName: 'fullName8',
    //       nim: 'nim8',
    //       gender: 'gender8',
    //       phone: 'phone8',
    //       email: 'email8',
    //       image: '',),
    //   User(
    //       fullName: 'fullName9',
    //       nim: 'nim9',
    //       gender: 'gender9',
    //       phone: 'phone9',
    //       email: 'email9',
    //       image: '',),
    //   User(
    //       fullName: 'fullName10',
    //       nim: 'nim10',
    //       gender: 'gender10',
    //       phone: 'phone10',
    //       email: 'email10',
    //       image: '',),
    // ];

    final users = [
      User(
        id: '',
        name: 'Hamid',
        stdCode: 'Jp1028312',
        email: 'ssadasds@gmail.com',
        gender: 'MALE',
        phoneNumber: '089792',
        role: 'USER',
      ),
      User(
        id: '',
        name: 'Hamid',
        stdCode: 'Jp1028312',
        email: 'ssadasds@gmail.com',
        gender: 'MALE',
        phoneNumber: '089792',
        role: 'USER',
      ),
      User(
        id: '',
        name: 'Hamid',
        stdCode: 'Jp1028312',
        email: 'ssadasds@gmail.com',
        gender: 'MALE',
        phoneNumber: '089792',
        role: 'USER',
      ),
      User(
        id: '',
        name: 'Hamid',
        stdCode: 'Jp1028312',
        email: 'ssadasds@gmail.com',
        gender: 'MALE',
        phoneNumber: '089792',
        role: 'USER',
      ),
      User(
        id: '',
        name: 'Hamid',
        stdCode: 'Jp1028312',
        email: 'ssadasds@gmail.com',
        gender: 'MALE',
        phoneNumber: '089792',
        role: 'USER',
      ),
    ];

    final data = users
        .map((e) => [
              e.stdCode,
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
              eventName: 'Sosialisasi Pertukaran Mahasiswa Merdeka',
              organizer: 'Kemahasiswaaan',
              date: '18 Juni 2024 18.00',
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
