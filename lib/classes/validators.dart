import 'dart:async';
class Validator{
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink){
    if(email.contains('@') && email.contains('.')){
      sink.add(email);
    }else if (email.length>0){
      sink.addError('enter a valid email');
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink){
    if(password.length >= 6){
      sink.add(password);
    }else if(password.length>0){
      sink.addError('password need to be six character');
    }
  });
}