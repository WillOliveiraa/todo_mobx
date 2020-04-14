import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email = 'willian@gmail.com';
  @observable
  String password = '123123';
  @observable
  bool passwordVisible = true;
  @observable
  bool loading = false;
  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void tooglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    loggedIn = true;

    email = '';
    password = '';
  }

  @action
  void logout() {
    loggedIn = false;
  }

  @computed
  bool get isEmailValid =>
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;
}