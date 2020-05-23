import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/database/modelling.dart';
import 'package:museum_app/image_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class TourExtra extends StatefulWidget {
  final int index;
  final ActualExtra extra;
  final bool edit;
  final bool result;

  TourExtra(this.index, this.extra,
      {this.edit = false, this.result = false, Key key})
      : super(key: key);

  @override
  _TourExtraState createState() => _TourExtraState();
}

class _TourExtraState extends State<TourExtra> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8), child: _makeExtra());
  }

  Widget _makeExtra() {
    if (widget.extra.task != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pink Box
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            width: horSize(100, 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(color: COLOR_TOUR, width: 2.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  "Aufgabe " + widget.index.toString() + ":",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                widget.edit
                    ? TextField(
                        controller: widget.extra.textInfo,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: TextField.noMaxLength,
                        style: TextStyle(fontSize: 20.0),
                      )
                    : SelectableText(
                        widget.extra.textInfo.text,
                        style: TextStyle(fontSize: 20.0),
                      ),
              ],
            ),
          ),
          // Text Form
          _makeAnswers(widget.extra.type, widget.extra.task),
        ],
      );
    if (widget.extra.type == ExtraType.IMAGE)
      return ImageCaroussel.fromStrings(widget.extra.textInfo.text.split(";"));
    return Container(
      child: widget.edit
          ? TextField(
              decoration: InputDecoration(labelText: "Freies Textfeld"),
              controller: widget.extra.textInfo,
              minLines: 1,
              maxLines: 10,
              maxLength: TextField.noMaxLength,
              style: TextStyle(fontSize: 18),
            )
          : SelectableLinkify(
              text: widget.extra.textInfo.text,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
              options: LinkifyOptions(
                removeWww: true,
                defaultToHttps: true,
              ),
              onOpen: (elem) async {
                print("AAAAD");
                if (await canLaunch(elem.url))
                  await launch(elem.url);
                else
                  print("Link ${elem.url} not launchable");
              },
            ),
    );
  }

  Widget _makeAnswers(ExtraType type, ActualTask t) {
    var label = (e) => widget.edit
        ? TextField(
            controller: e.valA,
            minLines: 1,
            maxLines: 3,
            maxLength: 70,
            decoration: InputDecoration(hintText: "Label"),
          )
        : SelectableText(e.valA.text);
    switch (type) {
      case ExtraType.TASK_TEXT:
        var text = (e) => !widget.result
            ? TextField(
                controller: e.valB,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.create),
                  hintText: "....",
                ),
              )
            : SelectableText(e.valB.text);
        return Column(
          children: [
            t.entries.length == 0
                ? Container()
                : t.entries.length == 1
                    ? Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: text(t.entries[0]),
                      )
                    : Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {0: FixedColumnWidth(horSize(30, 20))},
                        border: TableBorder.all(color: Colors.black),
                        children: t.entries
                            .map(
                              (e) => TableRow(
                                //fit: FlexFit.loose,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: widget.edit ? 4 : 13),
                                    alignment: Alignment.center,
                                    child: label(e),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: text(e),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
            widget.edit ? _addLine(t, TextEditingController()) : Container(),
          ],
        );
      case ExtraType.TASK_MULTI:
        return Column(
          children: List<Widget>() +
              t.entries.map((e) {
                int id = t.entries.indexOf(e);
                return CheckboxListTile(
                  value: e.valB,
                  onChanged: widget.result
                      ? null
                      : (newVal) => setState(() {
                            if (widget.edit) {
                              if (newVal)
                                t.correct.add(id);
                              else
                                t.correct.remove(id);
                            }
                            e.valB = newVal;
                          }),
                  title: label(e),
                  secondary: widget.result
                      ? Padding(
                          padding: EdgeInsets.only(left: 5),
                          child:
                              Icon(t.isCorrect(id) ? Icons.check : Icons.stop))
                      : null,
                );
              }).toList() +
              [widget.edit ? _addLine(t, false) : Container()],
        );
      case ExtraType.TASK_SINGLE:
        return Column(
          children: List<Widget>() +
              t.entries.map((e) {
                int id = t.entries.indexOf(e);
                return RadioListTile(
                    value: id,
                    onChanged: widget.result
                        ? null
                        : (newVal) => setState(() {
                              if (widget.edit) {
                                t.correct.clear();
                                t.correct.add(id);
                              }
                              t.selected = id;
                            }),
                    title: label(e),
                    groupValue: t.selected,
                    secondary: widget.result
                        ? Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                                t.isCorrect(id) ? Icons.check : Icons.stop))
                        : null);
              }).toList() +
              [widget.edit ? _addLine(t, false) : Container()],
        );
      default:
        return Container();
    }
  }

  Widget _addLine(ActualTask t, toAdd) {
    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      //alignment: MainAxisAlignment.spaceEvenly,
      //buttonMinWidth: horSize(20, 20),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "Antworteinstellungen:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        FlatButton(
          color: COLOR_ADD,
          //borderSide: BorderSide(color: Colors.orange),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => setState(() => t.addLabel("Antwort", toAdd)),
          child: Text("Hinzufügen", style: TextStyle(color: Colors.white)),
        ),
        FlatButton(
          color: COLOR_ADD,
          //borderSide: BorderSide(color: Colors.orange),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => setState(() => t.removeLast()),
          child: Text("Entfernen", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
