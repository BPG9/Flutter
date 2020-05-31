import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:popup_menu/popup_menu.dart';

import '../SizeConfig.dart';
import '../constants.dart';

class MuseumSearch extends StatefulWidget {
  final Function funct;
  final TextEditingController ctrl;

  const MuseumSearch(this.funct, this.ctrl, {Key key}) : super(key: key);

  _MuseumSearchState createState() => _MuseumSearchState();

  static void showHintScreen(context) =>
      _MuseumSearchState.showHintScreen(context);
}

class _MuseumSearchState extends State<MuseumSearch> {
  GlobalKey _key = GlobalKey();

  var proSearch = RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black45,
      ),
      children: [
        TextSpan(
          text: "Gib einen Begriff oben ein, um die Suche zu starten.\n\n",
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: "Tipps zur Profi-Suche:\n",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "Zur verfeinerten Suche nach Kategorien, tippe erst die passende "
              "Abkürzung ein. Übersicht der Kategorien:\n\n",
        ),
        TextSpan(
          text: "inv:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Inventarnummer\n"),
        TextSpan(
          text: "nam:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Titel des Objekts\n"),
        TextSpan(
          text: "div:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Abteilung des Objekts\n"),
        TextSpan(
          text: "cre:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Urheber*in des Objekts\n"),
        TextSpan(
          text: "art:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Art des Objekts (Bild, Skulptur, ...)\n"),
        TextSpan(
          text: "mat:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " Material des Objekts\n\n"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.ctrl,
          onChanged: (s) => setState(() {}),
          decoration: InputDecoration(
            labelText: "Suche...",
            icon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        Expanded(
          child: Container(
            //color: Colors.red,
            child: StreamBuilder(
              stream: MuseumDatabase().stopSearch(widget.ctrl.text),
              builder: (context, snap) {
                List<Stop> lst = snap?.data;
                if (lst == null) return Container();
                if (lst.isEmpty) {
                  if (widget.ctrl.text.isEmpty) return proSearch;
                  return Center(
                      child: Text(
                    "Leider konnte kein passendes Objekt zu dieser Suchanfrage "
                    "gefunden werden.\nVersuche es mit einem anderen Begriff "
                    "erneut!",
                    textAlign: TextAlign.center,
                  ));
                }
                return Scrollbar(
                  child: ListView(
                    children: lst
                        .map((s) => ListTile(
                              onTap: () {
                                widget.funct(s);
                                Navigator.pop(context);
                              },
                              trailing: Icon(Icons.arrow_forward),
                              title: Text(s.name),
                              subtitle: Text("Abteilung " + (s.division ?? "")),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  static void showHintScreen(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, a, b) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: horSize(87, 70),
            height: verSize(83, 70),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: COLOR_ADD.withOpacity(.97),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "Hilfe zur Objektsuche\n\n",
                      style: TextStyle(fontSize: 25),
                    ),
                    TextSpan(
                      text: "Mit der Suchfunktion kannst Du konkrete "
                          "Museumsobjekte finden, um sie in Deinen "
                          "Rundgang einzubinden.\n\n",
                    ),
                    TextSpan(
                      text: "Einfache Suche:\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                        text:
                            "Sobald Du einen Begriff (z.B. Objektnamen) in die Suchleiste"
                            "eingibst, werden Dir Vorschläge für Objekte gemacht, die den"
                            "eingegebenen Begriff im "),
                    TextSpan(
                      text: "Objekt-Namen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " oder in der "),
                    TextSpan(
                      text: "Objekt-Abteilung",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " enthalten. Groß- und Kleinschreibung "
                          "sind dabei nicht wichtig.\n\n",
                    ),
                    TextSpan(
                      text: "Verfeinerte Profi-Suche:\n",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextSpan(
                      text: "Mithilfe von bestimmten",
                    ),
                    TextSpan(
                      text: "Kategorien",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ", kannst Du gezielter nach Objekten oder ihren "
                          "Eigenschaften suchen. Eine Übersicht der Kategorien "
                          "findest Du dauerhaft unter der Suchleiste.\n"
                          "Möchtest Du bspw. nach einem Objekt suchen, von dem Du "
                          "bisher nur die Inventarnummer kennst, gib in die Suchleiste "
                          "erst die Abkürzung ",
                    ),
                    TextSpan(
                      text: "[inv]",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " ein:\n"),
                    TextSpan(
                      text: "inv",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: " <bekannte Nummer>\n",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(text: "Mit einem "),
                    TextSpan(
                      text: "[&]",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            " können auch mehrere Kategorien kombiniert werden.\n"
                            "Die Suche:\n"),
                    TextSpan(
                      text: "nam",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: " Fibel ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "& div",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: " archäologie\n",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "wird also Ergebnisse liefern, die \"Fibel\" im "
                          "Objekttitel haben UND in der Abteilung \"Archäologie\" "
                          "zu finden sind.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _hint() {
    var p = PopupMenu(
        context: context,
        maxColumn: 1,
        backgroundColor: COLOR_ADD.withOpacity(.7),
        highlightColor: COLOR_ADD,
        items: [
          MenuItem(
              title:
                  "Mit der Suchfunktion kannst Du spezifische Museumsobjekte finden. "
                  "Im normalen Fall werden alle Objekte angezeigt, die die Texteingabe "
                  "irgendwo in ihrem Titel oder der Abteilung enthalten.",
              //image: Icon(Icons.list),
              textStyle: TextStyle(color: Colors.white)),
          MenuItem(
              title:
                  "Mit bestimmten Schlüsselwörtern [und einem darauffolgenden Leerzeichen] "
                  "kannst Du nach bestimmten Eigenschaften der Objekte suchen. Hier werden "
                  "einige kurz beschrieben: \n"
                  "div",
              //image: Icon(Icons.list),
              textStyle: TextStyle(color: Colors.white)),
          MenuItem(
              title: "Text",
              image: Icon(Icons.list),
              textStyle: TextStyle(color: Colors.white)),
        ]);
    p.show(widgetKey: _key);
  }
}
