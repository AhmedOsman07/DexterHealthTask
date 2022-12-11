import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nursing_home_dexter/ui/home/home_screen.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../main.dart';
import '../../shared/app_constants/app_colors.dart';
import '../../shared/widget/dexter_button.dart';
import '../../shared/widget/dismissableScaffold.dart';
import '../../shared/widget/dexter_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _password, _email;
  FocusNode myFocusNode = FocusNode();

  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");

  LoginBloc? _bloc;

  LoginBloc get bloc => _bloc ??= LoginBloc();

  void buildListener(LoginState state, BuildContext context) {
    if (state is LoginSuccessfulState) {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, ModalRoute.withName('/'));
    } else if (state is LoginErrorState) {
      customFloatingSnackBar(context: context, content: state.message, isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return bloc;
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          buildListener(state, context);
        },
        child: DismissableScaffold(
          title: ("Login"),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // createTitle(context),
                const SizedBox(
                  height: 8,
                ),
                createEmailField(),
                const SizedBox(
                  height: 12,
                ),
                PasswordField(onSave: (value) {
                  _password = value;
                }),
                const SizedBox(
                  height: 10,
                ),
                createForgotPasswordField(),
                const Spacer(),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (c, state) => createButton(state is LoginLoadingState),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget createTitle(BuildContext ctx) {
    return const Text(
      "Login",
      style: TextStyle(
        color: AppColors.mainAppColor,
        // fontFamily: FontFamily.sfproDisplay,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget createForgotPasswordField() {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            // Navigator.of(ctx).pushNamed(ForgotPasswordSelection.forgotPassword);
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget createButton(bool isLoading) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DexterButton(
        title: "Login",
        isLoading: isLoading,
        onPress: () async {
          _formKey.currentState!.save();
          if (_formKey.currentState!.validate()) {
            bloc.add(LoginCredentialsEvent(
              email: _email!,
              password: _password!,
            ));
          }
        },
        textColor: Colors.white,
        color: Colors.red,
      ),
    );
  }

  Widget createEmailField() {
    return DexterTextFormField(
        textInputType: TextInputType.emailAddress,
        // padding: EdgeInsetsDirectional.fromSTEB(30.w, 50.h, 30.w, 0.h),
        hintText: "Email",
        textFormFieldValue: (dynamic value) {
          _email = value as String;
        },
        textFormFieldValidator: (dynamic value) {
          if (value == '') {
            return "Email is required.";
          } else if (!emailRegExp.hasMatch(value)) {
            return "Invalid email.";
          }
          return null;
        });
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({Key? key, required this.onSave}) : super(key: key);

  final Function(String val) onSave;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DexterTextFormField(
      // padding: EdgeInsetsDirectional.fromSTEB(
      //     30.w, 16.h, 30.w, 0.h),
      hintText: "Password",
      textFormFieldValue: (dynamic value) {
        widget.onSave(value);
      },
      textFormFieldValidator: (String? value) {
        if (value?.isEmpty ?? true) {
          return "Invalid password";
        }
        return null;
      },
      textInputType: TextInputType.text,
      isTextObscure: _isPasswordHidden,
      suffixIcon: InkWell(
        onTap: _togglePasswordView,
        child: Icon(
          _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
          color: AppColors.grey,
          size: 22,
        ),
      ),
    );
  }
}
