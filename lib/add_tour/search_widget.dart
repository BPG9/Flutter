import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/moor_db.dart';

class MuseumSearch extends StatefulWidget {
  final Function funct;
  final TextEditingController ctrl;

  const MuseumSearch(this.funct, this.ctrl, {Key key}) : super(key: key);

  _MuseumSearchState createState() => _MuseumSearchState();
}

class _MuseumSearchState extends State<MuseumSearch> {

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
}
