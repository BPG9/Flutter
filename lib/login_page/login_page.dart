import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/SizeConfig.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/mutations.dart';

class LogIn extends StatefulWidget {
  final bool skippable;

  LogIn({this.skippable = true, Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

/// Models the two possible actions for this widget
enum LogInType { LOGIN, SIGNUP }

class _LogInState extends State<LogIn> {
  /// the current state
  LogInType _type = LogInType.LOGIN;

  /// controller for the username form
  final _usCtrl = TextEditingController();

  /// controller for the first password form
  final _pwCtrl = TextEditingController();

  /// controller for the second password form
  final _pw2Ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // only displayed in portrait-mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // set the orientation settings to normal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _usCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  /// Proceeds to the next screen.
  /// If the LogIn can be skipped -> go to home-screen
  /// else -> go to profile-screen
  void _nextScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (widget.skippable) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, "/home");
    }
  }

  /// Creates the input change buttons used for this widget.
  ///
  /// The button's [text] and [function] can be defined.
  /// If [function] is null, the [text] will be displayed in upper case.
  Widget _customButtons(String text, function) {
    return FlatButton(
      //color: Colors.grey[300],
      textColor: Colors.black54,
      disabledColor: Color(0xFF4AD285),
      disabledTextColor: Colors.white,
      splashColor: Color(0xFF4AD285).withOpacity(.6),
      child: Text(function == null ? text.toUpperCase() : text),
      onPressed: function,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    );
  }

  /// Creates the two state changing buttons.
  Widget _topButtons() {
    var funct1, funct2;
    // the button's functions depend on the current state
    switch (_type) {
      case LogInType.LOGIN:
        funct2 = () => setState(() => _type = LogInType.SIGNUP);
        break;
      case LogInType.SIGNUP:
        funct1 = () => setState(() => _type = LogInType.LOGIN);
        break;
    }
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: horSize(22.8, 40)),
      height: verSize(5, 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ButtonBar(
        mainAxisSize: MainAxisSize.min,
        buttonPadding: EdgeInsets.zero,
        buttonHeight: verSize(100, 100),
        buttonMinWidth: horSize(22.5, 30),
        alignment: MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // LogIn-Button
          _customButtons("Login", funct1),
          // SignUp-Button
          _customButtons("SignUp", funct2),
        ],
      ),
    );
  }

  /// Creates a single text field used in this widget.
  ///
  /// The [icon] is displayed left to the text field. The [text] is displayed as
  /// the field's label. Set [pwField] to true to create a password-field.
  Widget _customTextField(
      TextEditingController ctrl, IconData icon, String text,
      {bool pwField = false}) {
    return Container(
      height: verSize(pwField ? 9 : 13, 15),
      margin: EdgeInsets.only(top: verSize(3, 10), left: 16, right: 16), //15.5
      //padding: EdgeInsets.only(left: 10, right: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      child: TextFormField(
        onChanged: (_) => setState(() {}),
        controller: ctrl,
        obscureText: pwField,
        autovalidate: true,
        maxLength: pwField ? null : MAX_USERNAME,
        validator: pwField ? null : _userVal,
        decoration: InputDecoration(
          hoverColor: Colors.red,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          prefixIcon: Icon(icon),
          labelText: text,
        ),
      ),
    );
  }

  /// The username's validator.
  String _userVal(String s) {
    if (s.length == 0) return null;
    if (3 <= s.length) return null;
    return "Username zu kurz";
  }

  /// Creates the two/three text fields.
  Widget _textFields() {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          // Username field
          _customTextField(_usCtrl, Icons.account_circle, 'Username eingeben'),
          // Password field
          _customTextField(_pwCtrl, Icons.mail, 'Passwort eingeben',
              pwField: true),
          // Retype Password field [SignUp]
          _type == LogInType.SIGNUP
              ? _customTextField(
                  _pw2Ctrl, Icons.fiber_pin, 'Passwort bestätigen',
                  pwField: true)
              : Container(),
        ],
      ),
    );
  }

  /// Displays a dialog after the user wants to skip the login-process.
  void _skipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hinweis"),
          content: Text(
              "Möchtest Du wirklich ohne Accountverbindung fortfahen?\n"
              "Du benötigst einen Account für Rundgänge, kannst diesen aber auch später einrichten."),
          actions: [
            FlatButton(
              child: Text("Zurück"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Fortfahren"),
              onPressed: _nextScreen,
            ),
          ],
        );
      },
    );
  }

  /// Displays the signup-confirmation dialog
  void _signUpDialog() {
    var content;
    // not all fields filled
    if (_usCtrl.text == "" || _pwCtrl.text == "" || _pw2Ctrl.text == "")
      content = Text("Bitte fülle alle Felder aus.");
    // the two passwords dont match
    else if (_pwCtrl.text != _pw2Ctrl.text)
      content = Text("Die eingegebenen Passwörter stimmen nicht überein.");
    // everything ok
    else
      content = RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 18.0, color: Colors.black),
          children: [
            TextSpan(
                text: "Bitte überprüfe, dass Du für den Benutzernamen "
                    "keine persönlichen Informationen verwendet hast.\n"
                    "Eingabe: "),
            TextSpan(
                text: _usCtrl.text,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

    // If something went wrong, only be able to close the alert
    var actions = <Widget>[
      FlatButton(
        child: Text("Schließen"),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ];

    // ... else be able to confirm the data
    if (!(content is Text))
      actions.add(
        Mutation(
          options: MutationOptions(
              documentNode:
                  gql(MutationBackend.createUser(_pwCtrl.text, _usCtrl.text)),
              onError: (e) =>
                  print("Signup-Error: " + e.clientException.toString()),
              onCompleted: (result) async {
                var map = result.data['createUser'];
                Navigator.pop(context);
                if (map['ok'] == true) {
                  print("SIGNUP COMPLETE");
                  setState(() {
                    _pwCtrl.clear();
                    _pw2Ctrl.clear();
                    _type = LogInType.LOGIN;
                  });
                } else
                  print("AAAAAAAAAAAAAAAAAAAA");
                  //_failedLogin();
              }),
          builder: (runMutation, result) => FlatButton(
            child: Text("Weiter"),
            onPressed: () => runMutation({}),
          ),
        ),
      );

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Hinweis"), content: content, actions: actions));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/haupthalle_hlm_blue.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.only(right: 16, left: 16),
        alignment: Alignment.center,
        child: Stack(
          children: [
            // LogIn-Box
            Container(
              //height: _type == LogInType.SIGNUP ? 400 : 300,
              /*SizeConfig.safeBlockVertical *
                  (_type == LogInType.SIGNUP ? 47 : 36.5)*/

              //55.5, 42.5
              margin: const EdgeInsets.only(bottom: 27),
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _topButtons(),
                  //Container(height: 6), //verSize(2, 3.5)
                  _textFields(),
                  Container(height: verSize(4, 15)), //verSize(2, 3.5)
                ],
              ),
            ),
            // Submit-Button
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  textColor: Colors.white,
                  color: Color(0xFFFCBF49),
                  disabledTextColor: Colors.white.withOpacity(.6),
                  disabledColor: Color(0xFFFCBF49).withOpacity(.6),
                  splashColor: Colors.black.withOpacity(.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text("Bestätigen", textScaleFactor: 1.3),
                  onPressed: _userVal(_usCtrl.text) != null ||
                          _usCtrl.text.isEmpty
                      ? null
                      : (_type == LogInType.SIGNUP ? _signUpDialog : _login),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.skippable
          ? FlatButton(
              textColor: Colors.white,
              color: COLOR_PROFILE,
              splashColor: Colors.black.withOpacity(.1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Skip"), Icon(Icons.skip_next)],
              ),
              onPressed: _skipDialog,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            )
          : null,
    );
  }

  /// Tries to login using the controller's current contents.
  _login() async {
    bool b = await MuseumDatabase().logIn(_usCtrl.text, _pwCtrl.text);
    if (b)
      _nextScreen();
    else
      _failedLogin();

    if (b && widget.skippable) {
      MuseumDatabase().downloadBadges();
      MuseumDatabase().downloadStops();
    }
  }

  /// Displays an error dialog
  _failedLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hinweis"),
        content: Text("Die eingegebenen Benutzerdaten sind nicht korrekt. "
            "Überprüfe bitte die Eingaben und versuche es erneut!"),
        actions: [
          FlatButton(
            child: Text("Schließen"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
