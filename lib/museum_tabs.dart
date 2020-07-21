import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/graphql/mutations.dart';

import 'SizeConfig.dart';
import 'constants.dart';
import 'database/moor_db.dart';
import 'graphql/graphqlConf.dart';
import 'image_dialog.dart';
import 'map/map_page.dart';

class MuseumTabs extends StatefulWidget {
  final Widget top;
  final Color color;
  final Map<String, Widget> tabs;
  final bool showSetting;
  final bool showMap;

  MuseumTabs(this.top, this.tabs,
      {this.color = Colors.black,
      this.showSetting = true,
      this.showMap = false,
      Key key})
      : super(key: key);

  MuseumTabs.single(this.top, widget,
      {this.color = Colors.black,
      this.showSetting = true,
      this.showMap = false,
      Key key})
      : tabs = {"Single": widget},
        super(key: key);

  @override
  _MuseumTabsState createState() => _MuseumTabsState();
}

class _MuseumTabsState extends State<MuseumTabs> with TickerProviderStateMixin {
  String _currentTab;

  void initState() {
    super.initState();
    if (widget.tabs.length >= 1) _currentTab = widget.tabs.keys.toList()[0];
  }

  List<Widget> _customButtons() {
    return widget.tabs.entries.map((entry) {
      var selected = (_currentTab == entry.key);
      return FlatButton(
        //textColor: Colors.black,
        //disabledTextColor: Colors.green,
        splashColor: widget.color.withOpacity(.4),
        child: Text(entry.key,
            style: TextStyle(
                color: (selected ? widget.color : Colors.black),
                fontSize: size(16, 19))),
        onPressed: () => setState(() => _currentTab = entry.key),
      );
    }).toList();
  }

  Widget _bottomInfo() {
    return Container(
      //height: SizeConfig.safeBlockVertical * 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          widget.tabs.length > 1
              ? ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.center,
                  children: _customButtons(),
                )
              : Container(),
          widget.tabs[_currentTab],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (!widget.tabs.containsKey(_currentTab))
      _currentTab = widget.tabs.keys.toList()[0];
    return ListView(
      children: <Widget>[
        Stack(overflow: Overflow.visible, children: [
          Container(height: verSize(30, 45), child: widget.top),
          Positioned(
            top: verSize(28.5, 47, top: true),
            child: Container(
              color: Colors.white,
              width: horSize(100, 100),
              height: verSize(80, 30),
            ),
          ),
          widget.showSetting
              ? Positioned(
                  right: horSize(2, 2, right: true),
                  top: verSize(1, 1),
                  child: MuseumSettings(),
                )
              : Container(),
          widget.showMap
              ? Positioned(
                  left: horSize(2, 2, left: true),
                  top: verSize(1, 1),
                  child: FlatButton(
                    padding: EdgeInsets.all(3),
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.map,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapPage()));
                    },
                  ),
                )
              : Container(),
        ]),
        _bottomInfo(),
      ],
    );
  }
}

enum _OptionType {
  EDIT_US,
  EDIT_PW,
  EDIT_IMG,
  LOGIN,
  LOGOUT,
  PROMOTE,
  ABOUT,
}

class MuseumSettings extends StatelessWidget {
  PopupMenuItem _myPopUpItem(String s, IconData i, _OptionType t) {
    return PopupMenuItem(
      child: Row(children: [
        Container(padding: EdgeInsets.only(right: 4), child: Icon(i)),
        Text(s)
      ]),
      value: t,
    );
  }

  Future<void> _editUS(BuildContext context) async {
    String accesToken = await MuseumDatabase().accessToken();
    var ctrl = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Username ändern"),
              content: TextFormField(
                autovalidate: true,
                controller: ctrl,
                maxLength: MAX_USERNAME,
                validator: (input) {
                  if (input.length < MIN_USERNAME)
                    return "Username ist zu kurz";
                  return null;
                },
                decoration: InputDecoration(hintText: "Username"),
              ),
              actions: [
                FlatButton(
                  child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Bestätigen",
                      style: TextStyle(color: COLOR_PROFILE)),
                  onPressed: () async {
                    GraphQLClient _client =
                        GraphQLConfiguration().clientToQuery();
                    print(ctrl.text);
                    QueryResult result = await _client.mutate(MutationOptions(
                      documentNode: gql(MutationBackend.changeUsername(
                          accesToken, ctrl.text.trim())),
                      update: (cache, result) => cache,
                      onError: (e) => print("ERROR_changeUS " + e.toString()),
                    ));

                    if (result.hasException || result.data == null) return;

                    print(result.data);
                    if (result.data['changeUsername']["ok"]["boolean"] ==
                        true) {
                      MuseumDatabase().updateUsername(ctrl.text.trim(),
                          result.data["changeUsername"]["refreshToken"]);
                      //MuseumDatabase().refreshToken();
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ));
  }

  Future<void> _editPW(BuildContext context) async {
    var ctrl = TextEditingController();
    var ctrl2 = TextEditingController();
    final key = GlobalKey<FormFieldState>();
    String accesToken = await MuseumDatabase().accessToken();

    var dialog = AlertDialog(
      title: Text("Passwort ändern"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: ctrl,
            obscureText: true,
            decoration: InputDecoration(hintText: "Passwort"),
          ),
          TextFormField(
            key: key,
            controller: ctrl2,
            obscureText: true,
            decoration: InputDecoration(hintText: "Passwort wiederholen"),
            validator: (s) {
              if (s != ctrl.text) return "Passwörter stimmen nicht überein";
              return null;
            },
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Bestätigen", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () async {
            if (!key.currentState.validate()) return;
            GraphQLClient _client = GraphQLConfiguration().clientToQuery();
            print(ctrl.text);
            await _client.mutate(MutationOptions(
              documentNode: gql(
                  MutationBackend.changePassword(accesToken, ctrl.text.trim())),
              update: (cache, result) => cache,
              onCompleted: (result) => Navigator.pop(context),
              onError: (e) => print("ERROR"),
            ));
          },
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }

  void _select(val, BuildContext context) {
    switch (val) {
      case _OptionType.EDIT_IMG:
        showDialog(context: context, builder: (_) => ImageDialog());
        break;
      case _OptionType.EDIT_US:
        _editUS(context);
        //showDialog(context: context, builder: _editUS);
        break;
      case _OptionType.EDIT_PW:
        _editPW(context);
        break;
      case _OptionType.ABOUT:
        showDialog(context: context, builder: _about);
        break;
      case _OptionType.LOGOUT:
        showDialog(context: context, builder: _logout);
        break;
      case _OptionType.PROMOTE:
        _promote(context);
        break;
      case _OptionType.LOGIN:
        Navigator.popAndPushNamed(context, "/profile");
        break;
      default:
    }
  }

  Widget _about(context) {
    return AlertDialog(
      title: Text("Geschichte Vernetzt"),
      content: Container(
        height: verSize(40, 30),
        width: horSize(80, 80),
        child: ListView(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Teil des Projekts MINTplus²: Systematischer und vernetzter Kompetenzaufbau in der Lehrerbildung im Umgang mit Digitalisierung und Heterogenität",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: horSize(4, 2),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1A1A1A)),
            ),
            Image.asset('assets/images/photo_2020-01-19.jpeg',
                width: horSize(35, 30), height: verSize(9, 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 7, right: 7),
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/Logo_MINTplus_182x0.jpg',
                      width: horSize(28, 30), height: verSize(10, 20)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, right: 7),
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/serveimage.png',
                      width: horSize(28, 30), height: verSize(10, 20)),
                ),
              ],
            ),
            Text(
              "Used Flutter Packages in this Project:\ncupertino_icons, gradient_text, flutter_circular_chart, flutter_rating_bar, photo_view, carousel_slider, graphql_flutter, expandable, intl, expandable_bottom_bar, keyboard_visibility, moor, moor_ffi, path_provider, path, provider, reorderables, rxdart, md2_tab_indicator, font_awesome_flutter, popup_menu, open_file, url_launcher, carousel_pro, flutter_keyboard_visibility",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: horSize(4, 2),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      actions: [
        FlatButton(
          child: Text("Schließen", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _logout(BuildContext context) {
    return AlertDialog(
      title: Text("Warnung"),
      content: Text("Möchtest Du Dich wirklich ausloggen?\n"
          "Alle heruntergeladenen Touren werden gelöscht. Wenn Du eine Tour favorisierst, kann "
          "diese bei der nächsten Anmeldung leichter wiedergefunden werden."),
      actions: [
        FlatButton(
          child: Text("Zurück", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Abmelden", style: TextStyle(color: COLOR_PROFILE)),
          onPressed: () async {
            await MuseumDatabase().logOut();
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/profile");
          },
        )
      ],
    );
  }

  _promote(context) async {
    String token = await MuseumDatabase().accessToken();
    final key = GlobalKey<FormFieldState>();
    TextEditingController ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erstellercode eingeben"),
        content: TextFormField(
          controller: ctrl,
          key: key,
          validator: (s) => "Der Code $s wurde nicht akzeptiert",
        ),
        actions: [
          FlatButton(
            child: Text("Schließen", style: TextStyle(color: COLOR_PROFILE)),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text("Bestätigen", style: TextStyle(color: COLOR_PROFILE)),
            onPressed: () async {
              GraphQLClient _client = GraphQLConfiguration().clientToQuery();
              print(ctrl.text);
              QueryResult result = await _client.mutate(MutationOptions(
                  documentNode:
                      gql(MutationBackend.promote(token, ctrl.text.trim())),
                  update: (cache, result) => cache));
              if (result.hasException)
                print("EXC_promote: " + result.exception.toString());
              if (result.data is LazyCacheMap) {
                if (result.data['promoteUser']["ok"]["boolean"] == true) {
                  MuseumDatabase().setProducer();
                  Navigator.pop(context);
                } else
                  key.currentState.validate();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MuseumDatabase().watchUser(),
      builder: (context, snap) {
        bool logged = snap.hasData && snap.data.accessToken != "";
        bool producer = snap.hasData && snap.data.producer;
        return PopupMenuButton(
          itemBuilder: (context) => _popUpList(logged, producer),
          onSelected: (result) => _select(result, context),
          icon: Icon(
            Icons.settings,
            size: 35,
            color: Colors.white,
          ),
        );
      },
    );
  }

  _popUpList(bool logged, bool producer) {
    List<PopupMenuItem> base = [
      _myPopUpItem("Einloggen", Icons.redo, _OptionType.LOGIN),
      _myPopUpItem("Über diese App", Icons.info, _OptionType.ABOUT),
      //_myPopUpItem("DEBUG clear", Icons.clear, _OptionType.clear),
      //_myPopUpItem("DEBUG demo", Icons.play_arrow, _OptionType.demo),
    ];

    if (logged) {
      base.removeAt(0);
      if (!producer)
        base.insert(
            0,
            _myPopUpItem(
                "Tourersteller werden", Icons.work, _OptionType.PROMOTE));
      base.insert(0, _myPopUpItem("Ausloggen", Icons.undo, _OptionType.LOGOUT));
      base.insert(
          0,
          _myPopUpItem(
              "Passwort ändern", Icons.fiber_pin, _OptionType.EDIT_PW));
      base.insert(0,
          _myPopUpItem("Username ändern", Icons.person, _OptionType.EDIT_US));
      base.insert(0,
          _myPopUpItem("Profilbild ändern", Icons.image, _OptionType.EDIT_IMG));
    }

    return base;
  }
}
