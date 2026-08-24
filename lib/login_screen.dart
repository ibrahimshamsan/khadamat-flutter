import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Splash.dart';
import 'create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ✅ دالة تسجيل الدخول مع Firebase
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'email': _emailController.text.trim(),
            'lastLogin': FieldValue.serverTimestamp(),
            'uid': userCredential.user!.uid,
          }, SetOptions(merge: true));

      _showSnackBar('تم تسجيل الدخول بنجاح ✅', Colors.green);

      // TODO: انتقل للصفحة الرئيسية بعد تسجيل الدخول
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'البريد الإلكتروني غير مسجل';
          break;
        case 'wrong-password':
          errorMessage = 'كلمة المرور غير صحيحة';
          break;
        case 'invalid-email':
          errorMessage = 'البريد الإلكتروني غير صالح';
          break;
        case 'too-many-requests':
          errorMessage = 'تم إيقاف الحساب مؤقتاً، حاول لاحقاً';
          break;
        default:
          errorMessage = 'حدث خطأ: ${e.message}';
      }
      _showSnackBar('❌ $errorMessage', Colors.red);
    } catch (e) {
      _showSnackBar('❌ حدث خطأ غير متوقع: $e', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.bgGradient),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    Center(
                      child: Image.asset(
                        'assets/images/icon1.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'أهلاً بعودتك! سجّل دخولك وكمّل رحلتك نحو النمو',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.subtitleGrey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 40),

                    _buildLabel('البريد الإلكتروني'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'example@email.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'من فضلك أدخل البريد الإلكتروني';
                        }
                        if (!value.contains('@')) {
                          return 'البريد الإلكتروني غير صحيح';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    _buildLabel('كلمة المرور'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _passwordController,
                      hint: '••••••••',
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.subtitleGrey,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: انتقل لصفحة استعادة كلمة المرور
                        },
                        child: const Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: AppColors.gradEnd,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gradMid.withOpacity(0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: _isLoading ? null : _handleLogin,
                          child: Center(
                            child: _isLoading
                                ? const SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(0.2)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'أو',
                            style: TextStyle(color: AppColors.subtitleGrey),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white.withOpacity(0.2)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(color: AppColors.subtitleGrey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CreateAccountScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      cursorColor: AppColors.gradMid,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.subtitleGrey.withOpacity(0.6)),
        prefixIcon: Icon(icon, color: AppColors.subtitleGrey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gradMid, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
