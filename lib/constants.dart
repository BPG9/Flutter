import 'package:flutter/material.dart';

// Color constants
const MaterialColor COLOR_HOME = MaterialColor(0xFF003473, {});
const MaterialAccentColor COLOR_TOUR = MaterialAccentColor(0xFFD62828, {});
const MaterialColor COLOR_ADD = MaterialColor(0xFFF77F00, {});
const MaterialColor COLOR_PROFILE = MaterialColor(0xFFFCBF49, {});

const String SERVER_ADDRESS = "http://130.83.247.244";
const String DB_ADDRESS = "http://130.83.247.244/app/";

const String PDF_BASE = "assets/pdfs/";
const String PDF_BARRIERE = "HLMD_Orientierungsplan_barrierefrei.pdf";
const String PDF_PRIVACY = "datenschutz.pdf";
const String PDF_K_SCHREIB = "Liste_kreativer_Schreibaufgaben.pdf";
const String PDF_EXAMPLE = "AB_Exemplarische-Herangehensweise-an-ein-Ausstellungsobjekt.pdf";
const String PDF_HANDR = "Handreichung_Schule-und-Museum_2011.pdf";

// DB constants
const int MIN_USERNAME = 4;
const int MAX_USERNAME = 15;

const int MIN_TOURNAME = 3;
const int MAX_TOURNAME = 25;

const int MIN_STOPNAME = 3;
const int MAX_STOPNAME = 50;
