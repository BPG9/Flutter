import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

Widget border(Widget w,
    {width,
    borderColor = COLOR_ADD,
    height,
    margin,
    padding = const EdgeInsets.all(8)}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset.fromDirection(pi / 2),
          )
        ]),
    child: w,
  );
}

Future<File> getPDF(String fileName) async {
  Directory tempDir = await getTemporaryDirectory();
  File tempFile = File('${tempDir.path}/$fileName');
  ByteData bd = await rootBundle.load(PDF_BASE + fileName);

  tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
  return tempFile;
}

openPDF(String fileName) async {
  getPDF(fileName).then((file) => OpenFile.open(file.path));
}