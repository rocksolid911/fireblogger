import 'package:flutter/material.dart';
import '../blocs/login_bloc.dart';
import '../services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = LoginBloc(AuthService());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Icon(
            Icons.account_circle,
            size: 88.0,
            color: Colors.white,
          ),
          preferredSize: Size.fromHeight(40.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder(
                stream: _loginBloc.email,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    icon: Icon(Icons.email),
                    errorText: snapshot.error,
                  ),
                  onChanged: _loginBloc.emailChanged.add,
                ),
              ),
              StreamBuilder(
                stream: _loginBloc.password,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password',
                    icon: Icon(Icons.security),
                    errorText: snapshot.error,
                  ),
                  onChanged: _loginBloc.passwordChanged.add,
                ),
              ),
              SizedBox(height: 48.0),
              _buildLoginAndCreateButton(),
              _googleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginAndCreateButton() {
    return StreamBuilder(
      initialData: 'Login',
      stream: _loginBloc.loginOrCreateButton,
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == 'Login') {
          return _buttonLogin();
        } else if (snapshot.data == 'Create Account') {
          return _buttonCreateAccount();
        // } else if (snapshot.data == 'GoogleLogin') {
        //   return _googleLoginButton();
        }
      }),
    );
  }

  Column _buttonLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              RaisedButton(
            elevation: 16.0,
            child: Text('login'),
            color: Colors.lightGreen.shade200,
            disabledColor: Colors.green,
            onPressed: snapshot.data
                ? () => _loginBloc.loginOrCreateChanged.add('Login')
                : null,
          ),
        ),
        FlatButton(
          onPressed: () =>
              _loginBloc.loginOrCreateButtonChanged.add('Create Account'),
          child: Text('create account'),
        ),
      ],
    );
  }

  Column _buttonCreateAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              RaisedButton(
            elevation: 16.0,
            child: Text('create account'),
            color: Colors.lightGreen.shade200,
            disabledColor: Colors.grey.shade100,
            onPressed: snapshot.data
                ? () => _loginBloc.loginOrCreateChanged.add('Create Account')
                : null,
          ),
        ),
        FlatButton(
          onPressed: () => _loginBloc.loginOrCreateButtonChanged.add('Login'),
          child: Text('Login'),
        ),
      ],
    );
  }

  Column _googleLoginButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder(
          initialData: true,
          stream: _loginBloc.googleLoginOrCreate,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              RaisedButton(
            elevation: 16.0,
            child: Text('google login'),
            color: Colors.lightGreen.shade200,
            disabledColor: Colors.green,
            onPressed: snapshot.data
                ? () => _loginBloc.loginOrCreateChanged.add('GoogleLogin')
                : null,
          ),
        )
      ],
    );
  }
}
