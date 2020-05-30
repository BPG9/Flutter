import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:popup_menu/popup_menu.dart';

import '../SizeConfig.dart';
import '../constants.dart';

class MuseumSearch extends StatefulWidget {
  final Function funct;
  final TextEditingController ctrl;

  const MuseumSearch(this.funct, this.ctrl, {Key key}) : super(key: key);

  _MuseumSearchState createState() => _MuseumSearchState();
}

class _MuseumSearchState extends State<MuseumSearch> {
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          key: _key,
          onPressed: _h2,
          splashColor: COLOR_ADD.withOpacity(.25),
          child: Row(children: [
            Icon(FontAwesomeIcons.question, size: 15, color: COLOR_ADD),
            Expanded(
                child: Text(
              "Benötigst Du Hilfe?",
              style: TextStyle(color: COLOR_ADD),
              textAlign: TextAlign.center,
            )),
          ]),
        ),
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
                  var text = widget.ctrl.text.isEmpty
                      ? "Gib einen Begriff oben ein, um die Suche zu starten."
                      : "Leider konnte kein passendes Objekt zu dieser Suchanfrage gefunden werden.\nVersuche es mit einem anderen Begriff erneut!";
                  return Center(child: Text(text, textAlign: TextAlign.center));
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

  void _h2() {
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
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: COLOR_ADD.withOpacity(.97),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: "Hilfe zur Objektsuche\n\n",style: TextStyle(fontSize: 25),),
                  TextSpan(
                      text:
                          "Mit der Suchfunktion kannst Du spezifische Museumsobjekte finden. "
                          "Im normalen Fall werden alle Objekte angezeigt, die die Texteingabe "
                          "irgendwo in ihrem Titel oder der Abteilung enthalten. Groß- und"
                          "Kleinschreibung wird ignoriert.\n\n"
                          "Mit bestimmten Schlüsselwörtern kannst Du nach gewünschten "
                          "Eigenschaften der Objekte suchen: \n"),
                  TextSpan(
                    text: "inv:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " Inventarnummer\n"),
                  TextSpan(text: "nam:",style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: " Titel des Objekts\n"),
                  TextSpan(text: "div:",style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: " Abteilung des Objekts\n"),
                  TextSpan(text: "cre:",style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: " Ersteller des Objekts\n"),
                  TextSpan(text: "art:",style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: " Art des Objekts [Bild, Skulptur, ...]\n"),
                  TextSpan(text: "mat:",style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(text: " Material des Objekts\n\n"),
                  TextSpan(
                      text:
                          "Mit einem Kaufmannsund [&] können mehrere Filter kombiniert "
                          "werden.\nDie Suche \""),
                  TextSpan(text: "nam Fibel & div archäologie",style: TextStyle(fontStyle: FontStyle.italic),),
                  TextSpan(
                      text:
                          "\" versucht also Objekte zu finden, die \"Fibel\" im Titel haben "
                          "UND in einer Abteilung sind, die \"archäologie\" im Namen enthält."),
                ],
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
