import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../main.dart';
import '../../shared/widget/dexter_button.dart';
import '../../shared/widget/dismissableScaffold.dart';
import '../../shared/widget/dexter_textfield.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/SignupScreen";

  const SignupScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");

  // uniquely identifies a Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // variables to store user data
  String? _email;
  String? _name;
  String? _password;

  SignUpBloc? _bloc;

  SignUpBloc get bloc => _bloc ??= SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return bloc;
      },
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (BuildContext context, state) {
          buildListener(state, context);
        },
        child: DismissableScaffold(
            title: ("Sign up"),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  const Text(
                      "Im aware that nurses should not signup, as they get their own credentials. But for sake of testing and adding nurses to user table it was implemented."),
                  const SizedBox(
                    height: 8,
                  ),
                  DexterTextFormField(
                      hintText: "Name",
                      textFormFieldValue: (String? value) {
                        _name = value;
                      },
                      textFormFieldValidator: (dynamic value) {
                        if (value == '') {
                          return "Name is required.";
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress,
                      isTextObscure: false),
                  const SizedBox(
                    height: 12,
                  ),
                  DexterTextFormField(
                      hintText: "Email",
                      textFormFieldValue: (String? value) {
                        _email = value;
                      },
                      textFormFieldValidator: (dynamic value) {
                        if (value == '') {
                          return "Email is required.";
                        } else if (!emailRegExp.hasMatch(value)) {
                          return "Invalid email.";
                        }
                        return null;
                      },

                      textInputType: TextInputType.emailAddress,
                      isTextObscure: false),
                  const SizedBox(
                    height: 12,
                  ),
                  PasswordField(onSave: (value) {
                    _password = value;
                  }),
                  Spacer(),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (c, state) => createButton(state is SignupLoadingState),
                  )
                ]),
              ),
            )),
      ),
    );
  }

  void buildListener(SignUpState state, BuildContext context) {
    if (state is SignupSuccessfulState) {
      customFloatingSnackBar(context: context, content: state.message, isSuccess: false);
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, ModalRoute.withName('/'));
    } else if (state is SignupErrorState) {
      customFloatingSnackBar(context: context, content: state.message, isSuccess: false);
    }
  }

  Widget createButton(bool isLoading) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DexterButton(
        title: "Sign up",
          isLoading:isLoading,
        onPress: () async {
          _formKey.currentState!.save();
          if (_formKey.currentState!.validate()) {
            bloc.add(SignupCredentialsEvent(
              email: _email!,
              password: _password!,
              name: _name!,
            ));
          }
        },
        textColor: Colors.white,
        color: Colors.red,
      ),
    );
  }
}
