import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:client/shared/constants.dart';
import 'package:client/shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text('Sign up for uAcadeMe'),
          centerTitle: true,
            actions: <Widget> [
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.toggleView();
                    });
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign in'))
            ]

        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
                key: _formKey,
                child: Column(
                    children: <Widget> [
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        }
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            print(result);
                            if (result == null) {
                              setState(() {
                                error = 'Please edit information';
                                loading = false;
                              });
                            }
                          }
                        },
                        color: Colors.red[300],
                        child: Text('Register', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 20),
                      Text(error, style: TextStyle(color: Colors.red, fontSize: 14)),
                    ]
                )
            )
        )
    );
  }
}
