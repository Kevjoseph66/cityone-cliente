import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),
          Container(
            width: size.width * 0.95,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.only(top: 40.0, bottom: 15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 5.0),
                    // spreadRadius: 3.0,
                  )
                ]),
            child: Form(
              key: _con.loginFormKey,
              child: Column(
                children: [
                  _crearEmail(),
                  SizedBox(height: 30.0),
                  _crearPassword(),
                  SizedBox(height: 20.0),
                  _crearBoton(),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        textColor: Theme.of(context).hintColor,
                        child: Text(S.of(context).i_dont_have_an_account),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/SignUp');
                        },
                      ),
                      FlatButton(
                        textColor: Theme.of(context).hintColor,
                        child: Text(S.of(context).i_forgot_password),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/ForgetPassword');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Usuario o Correo electronico:',
              textAlign: TextAlign.start,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (input) => _con.user.email = input,
            validator: (input) => !input.contains('@')
                ? S.of(context).should_be_a_valid_email
                : null,
            decoration: InputDecoration(
              fillColor: Color(0xFF989EDC),
              filled: true,
              // labelText: S.of(context).email,
              // labelStyle: TextStyle(color: Colors.black54),
              contentPadding: EdgeInsets.all(12),
              hintText: 'Ingrese su Usuario o Correo electronico',
              hintStyle: TextStyle(color: Colors.white54),
              // prefixIcon:
              //     Icon(Icons.alternate_email, color: Theme.of(context).accentColor),

              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text('Contraseña:', textAlign: TextAlign.start),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (input) => _con.user.password = input,
            validator: (input) => input.length < 3
                ? S.of(context).should_be_more_than_3_characters
                : null,
            obscureText: _con.hidePassword,
            decoration: InputDecoration(
              fillColor: Color(0xFF989EDC),
              filled: true,

              // labelText: S.of(context).password,
              // labelStyle: TextStyle(color: Colors.black54),
              contentPadding: EdgeInsets.all(12),
              hintText: 'Ingrese su Contraseña',
              hintStyle: TextStyle(color: Colors.white54),
              // prefixIcon:
              //     Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _con.hidePassword = !_con.hidePassword;
                  });
                },
                color: Theme.of(context).focusColor,
                icon: Icon(_con.hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).focusColor.withOpacity(0.2))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Text(
          S.of(context).login,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      color: Color(0xFFFF5800),
      textColor: Colors.white,
      onPressed: () {
        _con.login();
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final background = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/Recurso28.png'), fit: BoxFit.cover),
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Container(
          padding: EdgeInsets.only(top: 120.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/img/logo.png',
              width: MediaQuery.of(context).size.width * .3,
            ),
          ),
        )
      ],
    );
  }

//     Scaffold(
//       key: _con.scaffoldKey,
//       resizeToAvoidBottomPadding: false,
//       body: Stack(
//         alignment: AlignmentDirectional.topCenter,
//         children: <Widget>[
//           Positioned(
//             top: 0,
//             child: Container(
//               width: config.App(context).appWidth(100),
//               height: config.App(context).appHeight(37),
//               decoration: BoxDecoration(color: Theme.of(context).accentColor),
//             ),
//           ),
//           Positioned(
//             top: config.App(context).appHeight(37) - 120,
//             child: Container(
//               width: config.App(context).appWidth(84),
//               height: config.App(context).appHeight(37),
//               child: Text(
//                 S.of(context).lets_start_with_login,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline2
//                     .merge(TextStyle(color: Theme.of(context).primaryColor)),
//               ),
//             ),
//           ),
//           Positioned(
//             top: config.App(context).appHeight(37) - 50,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 50,
//                       color: Theme.of(context).hintColor.withOpacity(0.2),
//                     )
//                   ]),
//               margin: EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               padding:
//                   EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
//               width: config.App(context).appWidth(88),
// //              height: config.App(context).appHeight(55),
//               child: Form(
//                 key: _con.loginFormKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       onSaved: (input) => _con.user.email = input,
//                       validator: (input) => !input.contains('@')
//                           ? S.of(context).should_be_a_valid_email
//                           : null,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).email,
//                         labelStyle:
//                             TextStyle(color: Theme.of(context).accentColor),
//                         contentPadding: EdgeInsets.all(12),
//                         hintText: 'johndoe@gmail.com',
//                         hintStyle: TextStyle(
//                             color:
//                                 Theme.of(context).focusColor.withOpacity(0.7)),
//                         prefixIcon: Icon(Icons.alternate_email,
//                             color: Theme.of(context).accentColor),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.2))),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.5))),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.2))),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                       onSaved: (input) => _con.user.password = input,
//                       validator: (input) => input.length < 3
//                           ? S.of(context).should_be_more_than_3_characters
//                           : null,
//                       obscureText: _con.hidePassword,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).password,
//                         labelStyle:
//                             TextStyle(color: Theme.of(context).accentColor),
//                         contentPadding: EdgeInsets.all(12),
//                         hintText: '••••••••••••',
//                         hintStyle: TextStyle(
//                             color:
//                                 Theme.of(context).focusColor.withOpacity(0.7)),
//                         prefixIcon: Icon(Icons.lock_outline,
//                             color: Theme.of(context).accentColor),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _con.hidePassword = !_con.hidePassword;
//                             });
//                           },
//                           color: Theme.of(context).focusColor,
//                           icon: Icon(_con.hidePassword
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                         ),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.2))),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.5))),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .focusColor
//                                     .withOpacity(0.2))),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     BlockButtonWidget(
//                       text: Text(
//                         S.of(context).login,
//                         style: TextStyle(color: Theme.of(context).primaryColor),
//                       ),
//                       color: Theme.of(context).accentColor,
//                       onPressed: () {
//                         _con.login();
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     FlatButton(
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed('/Pages', arguments: 2);
//                       },
//                       shape: StadiumBorder(),
//                       textColor: Theme.of(context).hintColor,
//                       child: Text(S.of(context).skip),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 14),
//                     ),
// //                      SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             child: Column(
//               children: <Widget>[
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pushReplacementNamed('/ForgetPassword');
//                   },
//                   textColor: Theme.of(context).hintColor,
//                   child: Text(S.of(context).i_forgot_password),
//                 ),
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pushReplacementNamed('/SignUp');
//                   },
//                   textColor: Theme.of(context).hintColor,
//                   child: Text(S.of(context).i_dont_have_an_account),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );

}
