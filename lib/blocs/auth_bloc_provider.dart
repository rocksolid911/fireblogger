import 'package:flutter/material.dart';
import 'auth_bloc.dart';

class AuthBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;

  const AuthBlocProvider({Key Key, Widget child, this.authenticationBloc})
      : super(key: Key, child: child);
  static AuthBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: AuthBlocProvider)
        as AuthBlocProvider);
  }

  @override
  bool updateShouldNotify(AuthBlocProvider old) {
  return authenticationBloc != old.authenticationBloc;
  }
}
