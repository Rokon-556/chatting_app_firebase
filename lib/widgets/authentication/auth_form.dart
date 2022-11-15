import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submitFn});
  final void Function(
    String email,String password,String username,bool isLogin,
  )submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin=true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      print(_userName);
      widget.submitFn(_userEmail,_userPassword,_userName,_isLogin);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                    validator: ((value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Use Valid Email';
                      }
                      return null;
                    }),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: const ValueKey('name'),
                    decoration: const InputDecoration(labelText: 'User Name'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please Use Valid Name';
                      }
                      return null;
                    }),
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please Use Valid Password';
                      }
                      return null;
                    }),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(onPressed:_trySubmit, child:  Text  ( _isLogin? 'Login': 'SignUp')),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin=!_isLogin;
                      });
                    },
                    child: Text(
                     _isLogin? 'Create New Account': 'Already have an account',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
