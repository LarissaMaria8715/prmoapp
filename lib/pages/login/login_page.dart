import 'package:equilibreapp/pages/registration/register_page.dart';
import 'package:equilibreapp/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/user/usuarios_api.dart';
import '../../utils/colors.dart';
import '../../model/user/user_model.dart';
import '../../utils/shared_prefs.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPrefs _prefs = SharedPrefs();

  bool _passwordVisible = false;
  Future<Usuario?>? _loginFuture;

  get _onLoginPressed => null;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _prefs.getUserStatus();
    if (isLoggedIn) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(email: '', senha: ''),
          ),
        );
      }
    }
  }

  Future<Usuario?> _login(String email, String senha) async {
    try {
      final api = UsuariosApi();
      final usuario = await api.login(email, senha);

      if (usuario != null) {
        await _prefs.setUserStatus(true);
        return usuario;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha incorretos.')),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao conectar à API.')),
      );
      return null;
    }
  }

  Future<void> onPressed() async{
    String email = emailController.text;
    String password = passwordController.text;

    //try {
      //Usuario? user = await UsuariosApi().login(email, password);
    //} catch () {

    //}
    Usuario? user = await UsuariosApi().login(email, password);
    if(user != null) {

      SharedPrefs().setUserID(user.id);
      ProfileProvider().setUser(user);
      // salvar no provider
      // context.read
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(email: '', senha: '',);
          },
        ),
      );
    }else {
      print('Usuario e/ou senha incorretos!');
    }
  }
  //  void _onLoginPressed() {
    //if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      //ScaffoldMessenger.of(context).showSnackBar(
        //const SnackBar(content: Text('Preencha todos os campos!')),
      //);
    //  return;
    //}

  //  setState(() {
    //  _loginFuture = _login(
   //     emailController.text.trim(),
  //      passwordController.text,
   //   );
   // });
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen1,
      body: Center(
        child: FutureBuilder<Usuario?>(
          future: _loginFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Colors.white);
            } else if (snapshot.hasData && snapshot.data != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      email: snapshot.data!.email,
                      senha: snapshot.data!.senha,
                    ),
                  ),
                );
              });
              return const SizedBox.shrink();
            }

            return SingleChildScrollView(
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
                    const SizedBox(height: 36),
                    _GlassButton(
                      label: 'Entrar',
                      icon: Icons.login,
                      onPressed: _onLoginPressed,
                    ),
                    const SizedBox(height: 18),
                    _GlassButton(
                      label: 'Criar uma conta',
                      outlined: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
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
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
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
            passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: onVisibilityToggle,
        )
            : null,
      ),
    );
  }
}

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
          border: widget.outlined
              ? Border.all(color: borderColor, width: 1.5)
              : null,
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