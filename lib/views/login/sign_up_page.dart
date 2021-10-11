import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/sign_up/sign_up_bloc.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:singingholic_app/utils/app_navigator.dart';
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
  List<TextEditingController> _fieldControllers = [];
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  /// Custom fields
  List fields = [];

  @override
  void initState() {
    super.initState();
    context.read<SignUpBloc>().add(GetSignUpFormEvent());
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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          // Show a pop up to notify that registration is completed and go check their email
          showDialog(
            context: context,
            builder: (context) => _buildSignUpSuccessDialog(),
            barrierDismissible: false,
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildLogo(),
              _buildForm(),
              _buildWarnings(),
              if (state is! GetSignUpFormFailState ||
                  state is! GettingSignUpFormState)
                _buildSignUpButton(),
            ],
          ),
        );
      },
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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is GetSignUpFormSuccessState) {
          var memberForm = state.siteConfig?['memberForm'];
          fields = memberForm?['fields'] ?? [];
          fields = fields
              .where(
                  (field) => field['mode'] != null && field['mode'] != 'fixed')
              .toList();
          for (var field in fields) {
            TextEditingController controller = new TextEditingController();
            setState(() {
              _fieldControllers.add(controller);
            });
          }
        }
      },
      builder: (context, state) {
        if (state is GettingSignUpFormState) {
          return AppCircularLoading();
        } else if (state is GetSignUpFormFailState) {
          return Text('Sign Up is currently unavailable');
        } else {
          List<Widget> fieldWidgets = [];
          for (var i = 0; i < fields.length; i++) {
            fieldWidgets.add(_buildTextFormField(
                controller: _fieldControllers[i], field: fields[i]));
          }
          return Form(
            key: _formKey,
            child: Column(
              children: [
                _buildName(),
                _buildEmail(),
                ...fieldWidgets,
                _buildPassword(),
                _buildConfirmPassword(),
              ],
            ),
          );
        }
      },
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
                state.errorMsg,
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
  Widget _buildTextFormField(
      {required TextEditingController controller, required field}) {
    var dateFormatter = DateFormat('yyyy-MM-dd');
    if (field['type'] == 'date')
      controller.text = dateFormatter.format(DateTime.now());
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: field['title'],
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      minLines: field['type'] == 'textarea' ? 5 : 1,
      maxLines: field['type'] == 'textarea' ? 5 : 1,
      validator: (value) {
        if (field['mode'] == 'required' && (value == null || value.isEmpty)) {
          return 'This field cannot be empty';
        }
        return null;
      },
      onTap: field['type'] == 'date'
          ? () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime(2050, 12, 31))
                  .then((value) => {
                        if (value != null)
                          controller.text = dateFormatter.format(value)
                      });
            }
          : null,
      readOnly: field['type'] == 'date',
    );
  }

  /// Name text form field
  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
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
        labelText: 'Email',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
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
          return 'This field cannot be empty';
        }
        return null;
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
          return 'This field cannot be empty';
        }
        if (value != _passwordController.text) {
          return 'The password should be the same you type';
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
              Map<String, dynamic> _inputFields = {};
              for (var i = 0; i < fields.length; i++) {
                var field = fields[i]['field'];
                var text = _fieldControllers[i].text;
                _inputFields[field] = text;
              }
              context.read<SignUpBloc>().add(SignUp(
                  name: _nameController.text,
                  email: _usernameController.text,
                  inputFields: _inputFields,
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

  /// Alert dialog on sign up success
  Widget _buildSignUpSuccessDialog() {
    return AlertDialog(
        title: Text('Sign Up Success'),
        content: Text(
            'Thank you for registering as a member of $APP_TITLE. We have sent you an email to ${_usernameController.text} to verify your email address and activate your account.'),
        actions: [
          // Confirm button
          TextButton(
              onPressed: () {
                AppNavigator.goTo(context, AppRoute.HOME);
              },
              child: Text('Confirm')),
        ]);
  }
}
