import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
// device_preview shows phone frame for testing
import 'package:device_preview/device_preview.dart';

// main function starts app
void main() {
  if (kDebugMode) {
    // in debug mode, show phone frame
    runApp(DevicePreview(builder: (_) => BoatDiverApp()));
  } else {
    runApp(BoatDiverApp());
  }
}

// this is the main app widget
class BoatDiverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // primary color
    final primary = Colors.blue.shade700;

    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'BoatDiver - Login Workflow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

// logo widget
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({this.size = 60, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.anchor,
            size: size, color: Theme.of(context).colorScheme.primary),
        SizedBox(width: 10),
        Text('BoatDiver',
            style: TextStyle(
                fontSize: size * 0.45,
                fontWeight: FontWeight.w700,
                color: Colors.black87)),
      ],
    );
  }
}

// splash screen with logo animation
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _ctrl.forward();

    // after short delay, go to WelcomeScreen
    _navTimer = Timer(Duration(milliseconds: 900), () {
      if (mounted)
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeScreen()));
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
                child: Hero(tag: 'logo', child: AppLogo(size: 96)),
              ),
              SizedBox(height: 18),
              Text(
                'Connecting boat owners and divers',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// button style helper
ButtonStyle primaryButtonStyle(BuildContext ctx) => ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

// welcome screen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Hero(tag: 'logo', child: AppLogo(size: 84)),
                  SizedBox(height: 18),
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Welcome to BoatDiver',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(
                              'Sign in to manage bookings, boats, and dives. Create a new account if you are using the app for the first time.'),
                          SizedBox(height: 18),
                          ElevatedButton.icon(
                            style: primaryButtonStyle(context),
                            icon: Icon(Icons.mail_outline),
                            label: Text('Login with Email'),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => LoginScreen())),
                          ),
                          SizedBox(height: 12),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            icon: Icon(Icons.g_mobiledata, color: Colors.black87),
                            label: Text('Continue with Google'),
                            onPressed: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => RoleSelectionScreen())),
                          ),
                          SizedBox(height: 8),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            icon: Icon(Icons.apple, color: Colors.black87),
                            label: Text('Continue with Apple'),
                            onPressed: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => RoleSelectionScreen())),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                      onPressed: () {}, child: Text('Learn more about BoatDiver')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// email login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _doLogin() {
    if (!_formKey.currentState!.validate()) return;

    // just simulating login
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Login'),
        content: Text('Login successful (simulated). Are you creating a new account?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SuccessScreen(message: 'Welcome back!')));
            },
          ),
          ElevatedButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => RoleSelectionScreen()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 480),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(tag: 'logo', child: AppLogo(size: 56)),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please enter email'
                              : null,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (v) =>
                              (v == null || v.length < 6) ? 'Password min 6 chars' : null,
                        ),
                        SizedBox(height: 18),
                        ElevatedButton(
                            style: primaryButtonStyle(context),
                            child: Text('Login'),
                            onPressed: _doLogin),
                        SizedBox(height: 12),
                        TextButton(
                            onPressed: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => RoleSelectionScreen())),
                            child: Text('Create new account')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  } 
}

// role selection
class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Account - Role')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 480),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Are you a boat owner or a diver?',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 18),
                      ElevatedButton(
                          style: primaryButtonStyle(context),
                          child: Text('Boat Owner'),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => BoatOwnerForm()))),
                      SizedBox(height: 12),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: Text('Diver'),
                          onPressed: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => DiverForm()))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// boat owner form
class BoatOwnerForm extends StatefulWidget {
  @override
  _BoatOwnerFormState createState() => _BoatOwnerFormState();
}

class _BoatOwnerFormState extends State<BoatOwnerForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _boatName = TextEditingController();
  final _registration = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ReviewScreen(role: 'Boat Owner', data: {
              'Full name': _name.text,
              'Boat name': _boatName.text,
              'Registration': _registration.text,
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boat Owner Info')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                          controller: _name,
                          decoration: InputDecoration(labelText: 'Full name'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 12),
                      TextFormField(
                          controller: _boatName,
                          decoration: InputDecoration(labelText: 'Boat name'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 12),
                      TextFormField(
                          controller: _registration,
                          decoration:
                              InputDecoration(labelText: 'Registration number'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 18),
                      ElevatedButton(
                          style: primaryButtonStyle(context),
                          child: Text('Submit'),
                          onPressed: _submit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// diver form
class DiverForm extends StatefulWidget {
  @override
  _DiverFormState createState() => _DiverFormState();
}

class _DiverFormState extends State<DiverForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _license = TextEditingController();
  final _experience = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ReviewScreen(role: 'Diver', data: {
              'Full name': _name.text,
              'License': _license.text,
              'Years experience': _experience.text,
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diver Info')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                          controller: _name,
                          decoration: InputDecoration(labelText: 'Full name'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 12),
                      TextFormField(
                          controller: _license,
                          decoration: InputDecoration(labelText: 'License #'),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 12),
                      TextFormField(
                          controller: _experience,
                          decoration:
                              InputDecoration(labelText: 'Years of experience'),
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null),
                      SizedBox(height: 18),
                      ElevatedButton(
                          style: primaryButtonStyle(context),
                          child: Text('Submit'),
                          onPressed: _submit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// review screen
class ReviewScreen extends StatelessWidget {
  final String role;
  final Map<String, String> data;

  ReviewScreen({required this.role, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review & Finish')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 6,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Role: $role',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      // show each field
                      ...data.entries.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(e.key,
                                        style: TextStyle(color: Colors.grey[700]))),
                                Expanded(child: Text(e.value, textAlign: TextAlign.right)),
                              ],
                            ),
                          )),
                      SizedBox(height: 16),
                      ElevatedButton(
                          style: primaryButtonStyle(context),
                          child: Text('Finish'),
                          onPressed: () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => SuccessScreen(
                                      message: 'Account created for $role')))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// success screen
class SuccessScreen extends StatelessWidget {
  final String message;
  SuccessScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Set')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, size: 96, color: Colors.green),
                SizedBox(height: 12),
                Text(message, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                SizedBox(height: 16),
                ElevatedButton(
                    style: primaryButtonStyle(context),
                    child: Text('Back to Start'),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => WelcomeScreen()),
                        (r) => false)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         // This is a basic Flutter widget test.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       