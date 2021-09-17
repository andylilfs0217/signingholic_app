import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/sign_up/sign_up_bloc.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/widgets/app_appBar.dart';
import 'package:singingholic_app/widgets/app_circular_loading.dart';
import 'package:singingholic_app/widgets/app_scaffold.dart';
import 'package:validators/validators.dart';

/// Page for members to sign up
class SignUpPage extends StatefulWidget {
  /// Email that typed in Login Page
  final String? email;

  /// Password that typed in Login Page
  final String? password;

  const SignUpPage({Key? key, this.email, this.password}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// An indicator to show if the password is currently obscured
  bool isPasswordObscure = true;

  /// An indicator to show if the confirm password is currently obscured
  bool isConfirmPasswordObscure = true;

  /// Login form key
  final _formKey = GlobalKey<FormState>();

  /// Login form controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(appBar: AppBar(), title: 'Sign Up', hasCart: false),
        body: _buildBody(),
        hasDrawer: false);
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        _buildForm(),
        _buildWarnings(),
        _buildSignUpButton(),
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
          _buildName(),
          _buildEmail(),
          _buildMobile(),
          _buildPassword(),
          _buildConfirmPassword(),
        ],
      ),
    );
  }

  /// Show warning text if login failed
  Widget _buildWarnings() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpFailState) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppThemeSize.defaultItemHorizontalPaddingSize),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'This is warning text',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  /// Name text form field
  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Name',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty';
        }
        return null;
      },
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

  /// Mobile text form field
  Widget _buildMobile() {
    return TextFormField(
      controller: _mobileController,
      decoration: InputDecoration(
        icon: Icon(Icons.phone_android),
        labelText: 'Mobile number',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mobile number cannot be empty';
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

  /// Sign up text button
  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpProcessingState) {
          return AppCircularLoading();
        }
        return TextButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<SignUpBloc>().add(SignUp(
                  name: _nameController.text,
                  email: _usernameController.text,
                  mobile: _mobileController.text,
                  password: _passwordController.text,
                  password2: _confirmPasswordController.text));
            }
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
      },
    );
  }

  /// Confirm password text form field
  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: isConfirmPasswordObscure,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'Confirm Password',
        suffixIcon: IconButton(
          icon: Icon(isConfirmPasswordObscure
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: () {
            setState(() {
              isConfirmPasswordObscure = !isConfirmPasswordObscure;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        if (value != _passwordController.text) {
          return 'The password should be the same you type';
        }
        return null;
      },
    );
  }
}
