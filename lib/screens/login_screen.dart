// ============================================================
// login_screen.dart
// Pantalla de Inicio de Sesión (Login Screen).
//
// Esta pantalla aparece al presionar "Comienza" o "Regístrate"
// desde la HomeScreen. Contiene:
//  - Logo pequeño + nombre de la app (encabezado)
//  - Subtítulo de bienvenida
//  - Campo de usuario (con ícono de persona)
//  - Campo de contraseña (con ícono de llave)
//  - Botón "Ingresar"
//  - Enlace "Recupera Tu Contraseña"
//  - Botón "Ingresa con Google"
//  - Enlace "No tienes cuenta? Regístrate"
//
// Los íconos de usuario y llave se cargan desde icono.png,
// recortando cada mitad de la imagen (superior = usuario,
// inferior = llave).
// ============================================================

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // --- Controladores de texto ---
  // Permiten leer el valor escrito por el usuario en cada campo
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorPassword = TextEditingController();

  // Controla si la contraseña se muestra u oculta (ojo)
  bool _mostrarPassword = false;

  // --- Animación de entrada ---
  late AnimationController _controladorAnimacion;
  late Animation<double> _animacionOpacidad;
  late Animation<Offset> _animacionSlide;

  @override
  void initState() {
    super.initState();

    // Animación de 800ms al entrar a la pantalla
    _controladorAnimacion = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Fade-in: de invisible a visible
    _animacionOpacidad = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controladorAnimacion,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Slide-up: el contenido sube suavemente al aparecer
    _animacionSlide =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controladorAnimacion,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
          ),
        );

    // Lanza la animación al entrar
    _controladorAnimacion.forward();
  }

  @override
  void dispose() {
    // Libera recursos para evitar memory leaks
    _controladorAnimacion.dispose();
    _controladorUsuario.dispose();
    _controladorPassword.dispose();
    super.dispose();
  }

  /// Acción del botón "Ingresar".
  /// Aquí iría la lógica de autenticación con tu backend.
  void _ingresar() {
    final String usuario = _controladorUsuario.value.text.trim();
    final String password = _controladorPassword.value.text.trim();

    // Ejemplo: llamar a un servicio de login y navegar al dashboard
    debugPrint('Usuario: $usuario | Password: $password');
  }

  /// Acción del enlace "Recupera Tu Contraseña".

  void _recuperarContrasena() {
    debugPrint('Recuperar contraseña');
  }

  /// Acción del botón "Ingresa con Google".

  void _ingresarConGoogle() {
    debugPrint('Login con Google');
  }

  /// Acción del enlace "Regístrate".

  void _irARegistro() {
    debugPrint('Ir a registro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorFondo,

      body: SafeArea(
        child: FadeTransition(
          opacity: _animacionOpacidad,
          child: SlideTransition(
            position: _animacionSlide,
            child: SingleChildScrollView(
              // SingleChildScrollView evita overflow en pantallas pequeñas
              // o cuando el teclado aparece y reduce el espacio disponible
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ------------------------------------------------
                  // ENCABEZADO: Logo pequeño + Nombre de la app
                  // ------------------------------------------------
                  _construirEncabezado(),

                  const SizedBox(height: 12),

                  // Subtítulo en cursiva debajo del encabezado
                  Text(
                    'La aventura está por iniciar,\npor favor inicia sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.colorOscuro.withOpacity(0.65),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ------------------------------------------------
                  // CAMPO DE USUARIO
                  // Ícono: mitad superior de icono.png (persona)
                  // ------------------------------------------------
                  _construirCampoTexto(
                    controlador: _controladorUsuario,
                    indiceParte: 0, // 0 = parte superior del PNG (usuario)
                    esPassword: false,
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------------------------
                  // CAMPO DE CONTRASEÑA
                  // Ícono: mitad inferior de icono.png (llave)
                  // ------------------------------------------------
                  _construirCampoTexto(
                    controlador: _controladorPassword,
                    indiceParte: 1, // 1 = parte inferior del PNG (llave)
                    esPassword: true,
                  ),

                  const SizedBox(height: 32),

                  // ------------------------------------------------
                  // BOTÓN PRINCIPAL: "Ingresar"
                  // ------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _ingresar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colorPrimario,
                        foregroundColor: AppTheme.colorBlanco,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 4,
                        shadowColor: AppTheme.colorPrimario.withOpacity(0.4),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------------------------
                  // ENLACE: "Recupera Tu Contraseña"
                  // ------------------------------------------------
                  GestureDetector(
                    onTap: _recuperarContrasena,
                    child: Text(
                      'Recupera Tu Contraseña',
                      style: TextStyle(
                        color: AppTheme.colorOscuro.withOpacity(0.75),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ------------------------------------------------
                  // BOTÓN GOOGLE: "Ingresa con Google"
                  // Botón con borde, fondo blanco e ícono de Google
                  // ------------------------------------------------
                  _construirBotonGoogle(),

                  const SizedBox(height: 24),

                  // ------------------------------------------------
                  // ENLACE FINAL: "No tienes cuenta? Regístrate"
                  // "Regístrate" aparece en color rosa
                  // ------------------------------------------------
                  _construirEnlaceRegistro(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // WIDGETS PRIVADOS DE CONSTRUCCIÓN
  // Cada método construye una sección específica del UI.
  // Separarlos mejora la legibilidad y facilita el mantenimiento.
  // ============================================================

  /// Construye el encabezado superior con logo pequeño y nombre.
  Widget _construirEncabezado() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tarjeta pequeña con el logo
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppTheme.colorBlanco,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.colorPrimario.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.colorPrimario.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
        ),

        const SizedBox(width: 16),

        // Nombre de la app en rosa y negrita
        Text(
          'CasaRosada',
          style: TextStyle(
            color: AppTheme.colorPrimario,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  /// Construye un campo de texto con su ícono correspondiente.
  ///
  /// [controlador]  → controla el texto ingresado por el usuario
  /// [indiceParte]  → 0 = campo usuario (ícono persona), 1 = campo contraseña (ícono llave)
  /// [esPassword]   → si es true, oculta el texto y muestra botón de ojo
  Widget _construirCampoTexto({
    required TextEditingController controlador,
    required int indiceParte,
    required bool esPassword,
  }) {
    // Selecciona el ícono según el campo:
    // indiceParte 0 → persona (usuario)
    // indiceParte 1 → llave   (contraseña)
    final IconData iconoSeleccionado = indiceParte == 0
        ? Icons.person
        : Icons.key;

    return Row(
      children: [
        // ---- ÍCONO Material en color rosa primario ----
        // Se usan íconos del sistema para garantizar que se vean
        // correctamente en cualquier tamaño y resolución de pantalla.
        Icon(iconoSeleccionado, color: AppTheme.colorPrimario, size: 36),

        const SizedBox(width: 12),

        // ---- CAMPO DE TEXTO ----
        Expanded(
          child: TextField(
            controller: controlador,
            // obscureText oculta los caracteres (para contraseñas)
            obscureText: esPassword && !_mostrarPassword,
            style: TextStyle(color: AppTheme.colorOscuro, fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.colorBlanco,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppTheme.colorOscuro.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppTheme.colorOscuro.withOpacity(0.25),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppTheme.colorPrimario,
                  width: 1.8,
                ),
              ),
              // Botón de ojo solo en el campo de contraseña
              suffixIcon: esPassword
                  ? IconButton(
                      icon: Icon(
                        _mostrarPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppTheme.colorOscuro.withOpacity(0.5),
                        size: 20,
                      ),
                      onPressed: () {
                        // Alterna entre mostrar y ocultar la contraseña
                        setState(() {
                          _mostrarPassword = !_mostrarPassword;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  /// Construye el botón de inicio de sesión con Google.
  /// Usa el ícono oficial de Google con sus colores característicos.
  Widget _construirBotonGoogle() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: _ingresarConGoogle,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppTheme.colorBlanco,
          side: BorderSide(
            color: AppTheme.colorOscuro.withOpacity(0.25),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono de Google dibujado con texto de colores
            // (alternativa sin dependencias externas)
            _iconoGoogle(),
            const SizedBox(width: 10),
            Text(
              'Ingresa con Google',
              style: TextStyle(
                color: AppTheme.colorOscuro,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye un ícono de Google usando letras de colores.
  /// Evita dependencias externas manteniendo los colores oficiales.
  Widget _iconoGoogle() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }

  /// Construye el texto final "No tienes cuenta? Regístrate"
  /// donde "Regístrate" aparece en color rosa y es clickeable.
  Widget _construirEnlaceRegistro() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta? ',
          style: TextStyle(
            color: AppTheme.colorOscuro.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: _irARegistro,
          child: Text(
            'Regístrate',
            style: TextStyle(
              color: AppTheme.colorPrimario,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// _GoogleIconPainter
// Dibuja el ícono multicolor de Google con Canvas.
// Se usa CustomPainter para evitar agregar imágenes externas.
// ============================================================
class _GoogleIconPainter extends CustomPainter {
  const _GoogleIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radio = size.width / 2;

    // Pinceles de los 4 colores oficiales de Google
    final Paint pincelRojo = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;
    final Paint pincelAzul = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    final Paint pincelVerde = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;
    final Paint pincelAmarillo = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;

    // Cuadrante superior derecho - Rojo
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radio),
      -1.57,
      1.57,
      true,
      pincelRojo,
    );
    // Cuadrante inferior derecho - Verde
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radio),
      0,
      1.57,
      true,
      pincelVerde,
    );
    // Cuadrante inferior izquierdo - Amarillo
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radio),
      1.57,
      1.57,
      true,
      pincelAmarillo,
    );
    // Cuadrante superior izquierdo - Azul
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radio),
      3.14,
      1.57,
      true,
      pincelAzul,
    );

    // Círculo blanco central para crear el efecto de "dona"
    canvas.drawCircle(
      Offset(cx, cy),
      radio * 0.55,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
