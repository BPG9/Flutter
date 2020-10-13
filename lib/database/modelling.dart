import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/server_connection/graphqlConf.dart';
import 'package:museum_app/server_connection/query.dart';

import '../SizeConfig.dart';
import 'moor_db.dart';

class TourWithStops {
  final TextEditingController name = TextEditingController();
  final TextEditingController descr = TextEditingController();
  final String author;
  double difficulty;

  //TODO change to lastEdit
  DateTime creationTime;
  final int id;
  final String onlineId;
  final String searchId;
  final List<ActualStop> stops;

  TourWithStops(Tour t, this.stops)
      : id = t.id,
        author = t.author,
        onlineId = t.onlineId,
        searchId = t.searchId {
    this.name.text = t.name;
    this.descr.text = t.desc;
    difficulty = t.difficulty;
    creationTime = t.creationTime;
  }

  TourWithStops.empty(String author)
      : this(
            Tour(
                id: null,
                name: "Neue Tour",
                onlineId: null,
                author: author,
                difficulty: 0,
                creationTime: null,
                desc: ""),
            <ActualStop>[]);

  ToursCompanion createToursCompanion(bool nullToAbsent) {
    return ToursCompanion(
      name: Value(name.text),
      author: Value(author),
      difficulty: Value(difficulty),
      creationTime: Value(creationTime),
      onlineId: Value(onlineId ?? ""),
      searchId: Value(searchId ??
          author.substring(0, min(3, author.length)) +
              name.text.substring(0, min(4, name.text.length)) +
              (name.text.length + difficulty).toString() +
              (id?.toString() ?? "")),
      desc: Value(descr.text),
      id: id == null ? Value.absent() : Value(id),
    ); //.createCompanion(nullToAbsent);
  }

  Widget getRating(
          {color = Colors.black, color2 = Colors.white, size = 40.0}) =>
      RatingBarIndicator(
        rating: min(max(difficulty, 0), 5),
        itemSize: size,
        itemBuilder: (BuildContext context, int index) => Icon(
          Icons.school,
          color: color,
        ),
        unratedColor: color2.withOpacity(.5),
      );

  void resetTasks() {
    for (var s in stops) for (var e in s.extras) (e?.task)?.reset();
  }

  Future<bool> syncTasks() async {
    User u = await MuseumDatabase().getUser();
    String token = await MuseumDatabase().checkRefresh();

    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode:
          gql(QueryBackend.answersInTour(token, u.username, onlineId)),
    ));
    if (result.hasException) {
      print(result.exception.toString());
      return Future.value(false);
    }
    if (result.loading) return Future.value(false);
    var d = result.data;
    if (d?.data == null) return Future.value(false);
    if (d is LazyCacheMap) {
      List<ActualExtra> localList = [];
      for (ActualStop s in stops) {
        localList.add(ActualExtra(ExtraType.TEXT));
        localList.addAll(s.extras);
      }

      List list = d.data["answersByUser"];
      print(list);
      for (var up in list) {
        int index = up["question"]["index"] - 1;
        ActualTask task = localList[index].task;
        ExtraType type = localList[index].type;
        if (task != null && up["text"] is String) {
          String text = up["text"];
          if (type == ExtraType.TASK_TEXT) {
            if (text.startsWith("Antwort: "))
              text = text.replaceAll("Antwort: ", "");
            task.entries[0].valB.text = text;
          } else if (type == ExtraType.TASK_SINGLE) {
            int i;
            try {
              i = int.parse(text.substring(1, text.length - 1));
              task.entries[i].valB = true;
            } catch (_) {}
            task.selected = i;
          } else if (type == ExtraType.TASK_MULTI) {
            List l2 = jsonDecode(text);
            print(l2);
            /*if (text == "[]") continue;

            List<int> l = text
                .substring(1, text.length - 1)
                .split(",")
                .map((e) => int.parse(e))
                .toList();*/

            for (int i in l2)
              task.entries[i].valB = true;
          }
        }
      }
    }

    return Future.value(true);
  }

  Widget buildTime(
      {Color color = COLOR_TOUR, Color color2 = Colors.black, scale = 1.0}) {
    if (creationTime == null) return Container();
    String s = DateFormat('dd.MM.yyyy').format(creationTime);
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.date_range,
          color: color,
          size: size(21, 25) * scale,
        ),
        Container(
          padding: EdgeInsets.only(left: 4, top: 2),
          child: Text(
            s,
            style: TextStyle(
                fontSize: size(13, 14) * scale,
                fontWeight: FontWeight.bold,
                color: color2),
          ),
        ),
      ],
    );
  }
}

class ActualStop {
  Stop stop;
  StopFeature features;
  List<ActualExtra> extras;

  bool isCustom() => stop != null && stop.name == customName;

  ActualStop(this.stop, this.features, this.extras);

  ActualStop.custom()
      : this(
            Stop(
                id: customName,
                images: <String>[],
                name: customName,
                descr: ""),
            StopFeature(
                id_tour: null,
                id_stop: customName,
                showImages: false,
                showText: true,
                showDetails: false,
                id: null),
            <ActualExtra>[]);
}

enum ExtraType { TASK_TEXT, TASK_SINGLE, TASK_MULTI, IMAGE, TEXT }

class ActualExtra {
  final TextEditingController textInfo = TextEditingController();
  final ActualTask task;
  final ExtraType type;

  ActualExtra(this.type, {text = "", sel = const [""], correct})
      : task = ActualTask(type, answerNames: sel, correct: correct) {
    textInfo.text = text;
  }
}

class Tuple<K, V> {
  K valA;
  V valB;

  Tuple(this.valA, this.valB);
}

class ActualTask {
  final List<Tuple> entries;
  final Set<int> correct;
  int selected;

  factory ActualTask(type, {answerNames = const [""], correct}) {
    correct ??= <int>{};
    switch (type) {
      case ExtraType.TASK_TEXT:
        return ActualTask.text(answerNames, correct: correct);
      case ExtraType.TASK_MULTI:
      case ExtraType.TASK_SINGLE:
        return ActualTask.bool(answerNames, correct: correct);
      default:
        return null;
    }
  }

  ActualTask.text(names, {this.correct = const <int>{}}) : entries = <Tuple>[] {
    for (String s in names) addLabel(s, TextEditingController());
  }

  ActualTask.bool(names, {this.correct = const <int>{}}) : entries = <Tuple>[] {
    for (String s in names) addLabel(s, false);
  }

  addLabel(String label, value) {
    var tedit = TextEditingController();
    tedit.text = label;
    entries.add(Tuple(tedit, value));
  }

  removeLast() {
    if (entries.length < 1) return;
    entries.removeLast();
  }

  bool isCorrect(int id) {
    if (id < 0 || entries.length <= id) return false;
    var t = entries[id];

    // SINGLE task
    if (selected != null)
      return (correct.contains(id) && selected == id) ||
          (!correct.contains(id) && selected != id);

    // MULTI task
    return (correct.contains(id) && t.valB == true) ||
        (!correct.contains(id) && t.valB != true);
  }

  reset() {
    selected = null;
    for (var e in entries) {
      if (e.valB == true)
        e.valB = false;
      else if (e.valB is TextEditingController) e.valB.text = "";
    }
  }
}
