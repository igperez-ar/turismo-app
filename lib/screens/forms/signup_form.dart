import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_app/bloc/bloc.dart';
import 'package:turismo_app/widgets/widgets.dart';


class SignUpForm extends StatefulWidget {

  final AutenticacionBloc autenticacionBloc;
  final Function onSubmit;

  const SignUpForm({
    Key key,
    @required this.autenticacionBloc,
    this.onSubmit,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  bool _showConfirm = false;

  final _formKey = GlobalKey<FormState>();

  AutenticacionBloc get _autenticationBloc => widget.autenticacionBloc;

  @override 
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      if (!_showConfirm && _passwordController.text.isNotEmpty) {
        setState(() {
          _showConfirm = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<AutenticacionBloc,AutenticacionState>(
        builder: (context, state) {
          return Column(
            children: [
              InputValidatedWidget(
                controller: _emailController,
                hintText: 'Email',
                email: true,
                icon: Icons.email,
              ),
              InputValidatedWidget(
                controller: _nameController,
                hintText: 'Nombre completo',
                textCapitalization: TextCapitalization.words,
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _usernameController,
                hintText: 'Usuario',
                icon: Icons.person,
              ),
              InputValidatedWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                icon: Icons.lock,
                password: true,
              ),
              Visibility(
                visible: _showConfirm,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _showConfirm ? 1.0 : 0.0,
                  child: InputValidatedWidget(
                    controller: _password2Controller,
                    hintText: 'Confirmar contraseña',
                    icon: Icons.lock,
                    password: true,
                    validPassword: _passwordController,
                  )
                )
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  if (state is! AutenticacionLoading && _formKey.currentState.validate()) {
                    _autenticationBloc.add(AutenticacionRegister(
                      nombre: _nameController.text,
                      username: _usernameController.text,
                      password: _passwordController.text,
                      email: _emailController.text
                    ));
                    if (widget.onSubmit != null) 
                      widget.onSubmit();
                  }
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: (state is AutenticacionLoading 
                    ? Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white, 
                          strokeWidth: 3
                        )
                      ) 
                    : Text('Crear cuenta', style: TextStyle(fontSize: 16))
                  )
                )
              ),
            ],
          );
        }
      )
    );
  }
}