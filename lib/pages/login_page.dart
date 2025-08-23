import 'package:equilibreapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/database_helper.dart';
import '../database/user_dao.dart';
import 'package:equilibreapp/utils/colors.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseHelper db = DatabaseHelper();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserDAO userDAO = UserDAO();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen1,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.darkGreen5,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bem-vindo ao Equilibre',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.3,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                _buildTextField(
                  controller: emailController,
                  label: 'E-mail',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  labelColor: Colors.white,
                  iconColor: Colors.white,
                  fillColor: Colors.white.withOpacity(0.15),
                  focusedBorderColor: Colors.white,
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: passwordController,
                  label: 'Senha',
                  icon: Icons.lock_outline,
                  obscureText: !_passwordVisible,
                  labelColor: Colors.white,
                  iconColor: Colors.white,
                  fillColor: Colors.white.withOpacity(0.15),
                  focusedBorderColor: Colors.white,
                  isPasswordField: true,
                  onVisibilityToggle: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  passwordVisible: _passwordVisible,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: ação "esqueci minha senha"
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                      textStyle: const TextStyle(decoration: TextDecoration.underline),
                    ),
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(height: 36),

                _GlassButton(
                  label: 'Entrar',
                  icon: Icons.login,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 18),
                _GlassButton(
                  label: 'Criar uma conta',
                  outlined: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Color labelColor = Colors.white,
    Color iconColor = Colors.white,
    Color fillColor = Colors.transparent,
    Color focusedBorderColor = Colors.white,
    bool isPasswordField = false,
    VoidCallback? onVisibilityToggle,
    bool passwordVisible = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      cursorColor: Colors.white70,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: iconColor) : null,
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        filled: true,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: focusedBorderColor.withOpacity(0.4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: onVisibilityToggle,
        )
            : null,
      ),
    );
  }

  void _handleLogin() async {
    String email = emailController.text.trim();
    String senha = passwordController.text;

    UserDAO userDAO = UserDAO();
    final usuario = await userDAO.validar(email, senha);

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(email: email, senha: senha),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail e/ou senha incorretos!')),
      );
    }
  }

}

// Botão glassmorphism customizado

class _GlassButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool outlined;

  const _GlassButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  @override
  State<_GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<_GlassButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) => setState(() => _isPressed = true);
  void _onTapUp(TapUpDetails details) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.outlined
        ? Colors.white.withOpacity(0.15)
        : Colors.white.withOpacity(0.25);
    final borderColor = Colors.white.withOpacity(0.5);

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: _isPressed ? bgColor.withOpacity(0.8) : bgColor,
          borderRadius: BorderRadius.circular(18),
          border: widget.outlined ? Border.all(color: borderColor, width: 1.5) : null,
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: Colors.white, size: 22),
              const SizedBox(width: 12),
            ],
            Text(
              widget.label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
