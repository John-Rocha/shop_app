import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (emailValue) {
                    final email = emailValue ?? '';
                    if (email.trim().isEmpty || !email.contains("@")) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordEC,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (passwordValue) {
                    final password = passwordValue ?? '';
                    if (password.isEmpty) {
                      return 'Informe uma senha válida';
                    }
                    if (password.length < 5) {
                      return 'A senha precisa conter no mínimo 6 dígitos';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirmar Senha'),
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (passwordValue) {
                            final password = passwordValue ?? '';
                            if (password != _passwordEC.text) {
                              return 'Senhas informadas não conferem';
                            }
                            return null;
                          },
                  ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          ),
                        ),
                        child: _isLogin()
                            ? Text('Entrar'.toUpperCase())
                            : Text('Registrar'.toUpperCase()),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _isLogin()
                        ? 'Deseja Registrar?'.toUpperCase()
                        : 'Já possui conta?'.toUpperCase(),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthProvider auth = Provider.of(
      context,
      listen: false,
    );

    if (_isLogin()) {
      // TODO Login
      await auth.login(
        _authData['email']!,
        _authData['password']!,
      );
    } else {
      // TODO Register
      await auth.signup(
        _authData['email']!,
        _authData['password']!,
      );
    }

    setState(() => _isLoading = false);
  }

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;
}