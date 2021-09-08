import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:validators/validators.dart';

/// Login page
class LoginPage extends StatefulWidget {
  /// Create login page
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// An indicator to show if the password is currently obscured
  bool isPasswordObscure = true;

  /// Login form key
  final _formKey = GlobalKey<FormState>();

  /// Login form controllers
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          AppNavigator.goTo(context, AppRoute.HOME);
        }
      },
      child: AppScaffold(
        body: _buildBody(),
        appBar: AppAppBar(
          appBar: AppBar(),
          title: 'Login',
          hasCart: false,
        ),
        hasDrawer: false,
      ),
    );
  }

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        _buildForm(),
        _buildWarnings(),
        _buildButtons(),
        if (ENV == EnvironmentStage.development ||
            ENV == EnvironmentStage.staging)
          _buildOneTapLoginForDev(),
      ],
    );
  }

  /// Create logo container
  Widget _buildLogo() {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(LOGO_PATH),
      ),
    );
  }

  /// Login form
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmail(),
          _buildPassword(),
        ],
      ),
    );
  }

  /// Login button
  Widget _buildLoginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginProcessingState) {
          return AppCircularLoading();
        }
        return TextButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginSubmittedEvent(
                  email: _usernameController.text,
                  password: _passwordController.text));
            }
          },
          icon: Icon(Icons.login),
          label: Text('Login'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppThemeColor.appPrimaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            alignment: Alignment.center,
          ),
        );
      },
    );
  }

  /// Sign up text button
  Widget _buildSignUpButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: Implement sign up button
        print('Sign up');
      },
      icon: Icon(Icons.person),
      label: Text('Sign up'),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(AppThemeColor.appPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        alignment: Alignment.center,
      ),
    );
  }

  /// Username text form field
  Widget _buildEmail() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Email',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty';
        }
        if (!isEmail(value)) {
          return 'Email format incorrect';
        }
        return null;
      },
    );
  }

  /// Password text form field
  Widget _buildPassword() {
    return TextFormField(
      controller: _passwordController,
      obscureText: isPasswordObscure,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon:
              Icon(isPasswordObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              isPasswordObscure = !isPasswordObscure;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        return null;
      },
    );
  }

  /// Button row, including login and sign up button
  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppThemeSize.appDrawerListTileHorizontalPaddingSize),
      child: Row(
        children: [
          Expanded(child: _buildLoginButton()),
          SizedBox(width: AppThemeSize.defaultItemHorizontalPaddingSize),
          Expanded(child: _buildSignUpButton()),
        ],
      ),
    );
  }

  /// Show warning text if login failed
  Widget _buildWarnings() {
    return BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginFailedState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppThemeSize.defaultItemHorizontalPaddingSize),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login failed',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          // No Warning Text
          return Container();
        },
        listener: (context, state) {});
  }

  /// A button for developer to login in one tap without filling email and password
  ///
  /// The function will login with default email and password
  Widget _buildOneTapLoginForDev() {
    return TextButton(
        onPressed: () {
          context.read<LoginBloc>().add(LoginSubmittedEvent(
              email: "a.li@vizualize.net", password: "andyli0217"));
        },
        child: Text('One Tap Login'));
  }
}
