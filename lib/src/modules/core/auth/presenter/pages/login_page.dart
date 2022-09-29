import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/events/login_events.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/login_bloc.dart';
import 'package:cardapio_manager/src/modules/core/auth/presenter/bloc/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBloc = Modular.get<LoginBloc>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        const AssetImage('assets/images/login_background.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: IconButton(
                              onPressed: () => emailFocus.requestFocus(),
                              icon: const Icon(
                                Icons.email,
                                color: Colors.white,
                              )),
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: emailController,
                            focusNode: emailFocus,
                            decoration: InputDecoration(
                                hintText: 'cardapio@hotmail.com',
                                hintStyle: _getTextStyle()),
                            validator: (email) {
                              if (!isEmail(email!)) {
                                return 'Email inválido';
                              }

                              return null;
                            },
                            style: _getTextStyle(),
                            onFieldSubmitted: (e) =>
                                passwordFocus.requestFocus(),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: IconButton(
                              onPressed: () => passwordFocus.requestFocus(),
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              )),
                        ),
                        Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocus,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              hintStyle: _getTextStyle(),
                            ),
                            obscureText: true,
                            style: _getTextStyle(),
                            validator: (password) {
                              if (password!.length < 6) {
                                return 'Senha inválida';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    BlocListener<LoginBloc, LoginStates>(
                      bloc: loginBloc,
                      listener: (_, state) {
                        if (state is LoginSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text('Usuário: ${state.user.name}'),
                          ));
                          Modular.to.pushReplacementNamed('/order/');
                        }

                        if (state is LoginErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error.message),
                          ));
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginStates>(
                        bloc: loginBloc,
                        builder: (_, state) {
                          if (state is LoginLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return SizedBox(
                            width: size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  loginBloc.add(LoginEvent(emailController.text,
                                      passwordController.text));
                                }
                              },
                              child: const Text('Login'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getTextStyle() {
    return const TextStyle(color: Colors.white);
  }
}
