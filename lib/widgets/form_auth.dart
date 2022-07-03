import 'package:flutter/material.dart';

class FormAuth extends StatefulWidget {
  const FormAuth({Key? key, required this.submitForm}) : super(key: key);
  final Function(String username, String email, String password, bool isLogin)
      submitForm;

  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  //true = Login, false = Register
  bool _isLogin = true;

  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';

  void _trySubmit() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(_username, _email, _password, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 200, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autofocus: true,
                      onSaved: (value) {
                        _username = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "username minimal 4 karakter";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      ),
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty ||
                          !value.contains('@') ||
                          value.contains(' ')) {
                        return "Email tidak valid";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Password kurang dari 6 karakter";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        _trySubmit();
                      },
                      child: _isLogin ? const Text('Login') : Text('Register')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: _isLogin
                          ? const Text('Create Account')
                          : const Text('Login'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
