import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/auth/login_request.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../services/auth_service.dart';

/// Login form widget with authentication integration
class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaController = TextEditingController();
  
  String? _secureId;
  String? _captchaImageUrl;
  bool _isLoadingCaptcha = false;

  @override
  void initState() {
    super.initState();
    _loadCaptcha();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  /// Load captcha from API
  Future<void> _loadCaptcha() async {
    setState(() {
      _isLoadingCaptcha = true;
    });

    try {
      final captchaData = await AuthService.getSecureCaptcha();
      setState(() {
        _secureId = captchaData['secureId']?.toString();
        _captchaImageUrl = captchaData['captchaImageUrl']?.toString();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load captcha: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoadingCaptcha = false;
      });
    }
  }

  /// Handle login form submission
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    if (_secureId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please wait for captcha to load')),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final loginRequest = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      secureId: _secureId!,
      captchaText: _captchaController.text.trim(),
    );

    final success = await authProvider.login(loginRequest);
    
    if (success && mounted) {
      // Navigate to home screen or dashboard
      Navigator.of(context).pushReplacementNamed('/home');
    } else if (mounted) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Login failed'),
          backgroundColor: Colors.red,
        ),
      );
      // Reload captcha on failure
      _loadCaptcha();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Captcha section
              if (_isLoadingCaptcha)
                const Center(child: CircularProgressIndicator())
              else if (_captchaImageUrl != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        _captchaImageUrl!,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Failed to load captcha');
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _captchaController,
                        decoration: const InputDecoration(
                          labelText: 'Enter captcha text',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter captcha text';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: _loadCaptcha,
                        child: const Text('Refresh Captcha'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Login button
              ElevatedButton(
                onPressed: authProvider.isLoading ? null : _handleLogin,
                child: authProvider.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Login'),
              ),

              // Error message
              if (authProvider.hasError)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    authProvider.errorMessage ?? 'An error occurred',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
