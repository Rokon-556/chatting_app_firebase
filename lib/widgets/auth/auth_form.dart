import 'dart:io';

import 'package:chatting_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submitFn, required this.isLoading});
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    XFile image,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  XFile? _userImageFile;

  void _pickImage(XFile image) {
    
      _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Pick An Image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    if (isValid) {
      _formKey.currentState!.save();
      print(_userName);
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin,_userImageFile!);
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
                  if (!_isLogin) UserImagePicker(imagePickFn: _pickImage),
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
                  if (!_isLogin)
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
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'SignUp')),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Create New Account'
                          : 'Already have an account',
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
