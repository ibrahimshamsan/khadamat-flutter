import 'package:flutter/material.dart';
//import 'Sofra.dart';

void main() {
  runApp(const KhadamatApp());
}

class KhadamatApp extends StatelessWidget {
  const KhadamatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خدمات',
      theme: ThemeData(fontFamily: 'Cairo', useMaterial3: true),
      home: const WelcomeScreen(),
    );
  }
}

// كلاس الألوان الموحدة للتطبيق
class AppColors {
  static const Color bgTop = Color(0xFF0F172A);
  static const Color bgMid = Color(0xFF17104A);
  static const Color bgBottom = Color(0xFF2B176B);

  static const Color subtitleGrey = Color(0xFFD7D9E5);

  // تدرج ألوان الشعار (أزرق - بنفسجي - فوشيا)
  static const Color gradStart = Color(0xFF5B6CFF);
  static const Color gradMid = Color(0xFF8B5CF6);
  static const Color gradEnd = Color(0xFFD946EF);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgTop, bgMid, bgBottom],
  );

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [gradStart, gradMid, gradEnd],
  );
}

// كلاس أنماط النصوص الموحدة
class AppText {
  // اسم التطبيق في شاشة الترحيب - أكبر وزن
  static const TextStyle appName = TextStyle(
    color: Colors.white,
    fontSize: 48,
    fontWeight: FontWeight.w800, // ExtraBold
    letterSpacing: 1,
  );

  // وصف/ تحت اسم التطبيق
  static const TextStyle tagline = TextStyle(
    color: AppColors.subtitleGrey,
    fontSize: 17,
    fontWeight: FontWeight.w300, // Light
  );

  //عناوين الصفحات
  static const TextStyle pageTitle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w800, // ExtraBold
  );

  // وصف فرعي
  static const TextStyle pageSubtitle = TextStyle(
    color: AppColors.subtitleGrey,
    fontSize: 15,
    fontWeight: FontWeight.w400, // Regular
  );

  //  فوق عنوان الحقل
  static const TextStyle fieldLabel = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
  );

  // نص داخل الحقل
  static const TextStyle fieldInput = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w400, // Regular
  );

  // نص داخل الحقل
  static TextStyle fieldHint = TextStyle(
    color: AppColors.subtitleGrey.withOpacity(0.6),
    fontSize: 15,
    fontWeight: FontWeight.w300, // Light
  );

  // نص زرار رئيسي
  static const TextStyle primaryButton = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700, // Bold
  );

  // روابط (نسيت كلمة المرور / إنشاء حساب)
  static const TextStyle linkBold = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700, // Bold
    fontSize: 14,
  );

  static const TextStyle linkAccent = TextStyle(
    color: AppColors.gradEnd,
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 14,
  );

  // نص عادي
  static const TextStyle body = TextStyle(
    color: AppColors.subtitleGrey,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
  );
}

// شاشة الترحيب
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال التلقائي لواجهة تسجيل الدخول بعد 5 ثواني
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
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
            child: Column(
              children: [
                const Spacer(flex: 2),

                // الشعار
                Image.asset(
                  'assets/images/icon1.png',
                  width: 190,
                  height: 190,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 25),

                // اسم التطبيق
                const Text('خدمات', style: AppText.appName),

                const SizedBox(height: 12),

                // الوصف
                const Text(
                  'تسويق ذكي | حلول مبتكرة | نمو مستدام',
                  textAlign: TextAlign.center,
                  style: AppText.tagline,
                ),

                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// !!!!!!!!!!!!!!!!!!!!!!!!!! واجهة تسجيل الدخول!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO:  هنا ربط مع منطق تسجيل الدخول الفعلي
      debugPrint('تسجيل الدخول: ${_emailController.text}');
    }
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

                    // شعار مصغر أعلى الصفحة
                    Center(
                      child: Image.asset(
                        'assets/images/icon1.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // عنوان الصفحة
                    const Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: AppText.pageTitle,
                    ),

                    const SizedBox(height: 10),

                    // وصف فرعي
                    const Text(
                      'أهلاً بعودتك! سجّل دخولك وكمّل رحلتك نحو النمو',
                      textAlign: TextAlign.center,
                      style: AppText.pageSubtitle,
                    ),

                    const SizedBox(height: 40),

                    // حقل البريد الإلكتروني
                    _buildLabel('البريد الإلكتروني'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'EX...@email.com',
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

                    // حقل كلمة المرور
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

                    // حقل نسيت كلمة المرور
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // TODO: انتقل لصفحة استعادة كلمة المرور
                        },
                        child: const Text(
                          'نسيت كلمة المرور؟',
                          style: AppText.linkAccent,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // زر تسجيل الدخول
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                          color: AppColors.gradMid.withValues(alpha: 0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: _handleLogin,
                          child: const Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: AppText.primaryButton,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // فاصل "أو"
                    Row(
                      children: [
                        Expanded(
                         child: Divider(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('أو', style: AppText.body),
                        ),
                        Expanded(
                         child: Divider(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // رابط إنشاء حساب جديد
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب؟', style: AppText.body),
                        TextButton(
                          onPressed: () {
                            // TODO: انتقل لصفحة إنشاء حساب
                          },
                          child: const Text(
                            'إنشاء حساب جديد',
                            style: AppText.linkBold,
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

  // !!!!!!!!!!!!!!!!!!!!!!!عناصر مساعدة لبناء الحقول !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Widget _buildLabel(String text) {
    return Text(text, style: AppText.fieldLabel);
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
      style: AppText.fieldInput,
      cursorColor: AppColors.gradMid,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppText.fieldHint,
        prefixIcon: Icon(icon, color: AppColors.subtitleGrey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
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
