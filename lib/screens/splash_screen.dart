// ============================================================
// splash_screen.dart
// Pantalla de presentación (Splash Screen) de la aplicación.
//
// Esta pantalla se muestra al abrir la app durante unos
// segundos antes de navegar a la pantalla principal o de login.
//
// Contiene:
//  - Logo de la aplicación (imagen PNG)
//  - Nombre de la app
//  - Mi nombre obviamente jahsja
//  - Animación de entrada suave (FadeIn + ScaleUp)
//  - Navegación automática tras 3 segundos
// ============================================================

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // --- Controlador de animación ---
  // Maneja la opacidad y la escala del contenido central
  late AnimationController _controladorAnimacion;
  late Animation<double> _animacionOpacidad;
  late Animation<double> _animacionEscala;

  @override
  void initState() {
    super.initState();

    // Configura el controlador con duración de 1.2 segundos
    _controladorAnimacion = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Animación de opacidad: de invisible (0) a visible (1)
    _animacionOpacidad = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controladorAnimacion,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    // Animación de escala: de pequeño (0.8) a tamaño normal (1.0)
    _animacionEscala = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controladorAnimacion,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    // Inicia la animación al cargar la pantalla
    _controladorAnimacion.forward();

    // Navega automáticamente a la siguiente pantalla después de 3 segundos
    _navegarDespuesDeDelay();
  }

  /// Espera 3 segundos y luego navega a la siguiente ruta.
  /// Cambia '/login' por la ruta que corresponda en tu app.
  Future<void> _navegarDespuesDeDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    // Verifica que el widget aún esté montado antes de navegar
    if (!mounted) return;

    // Navega a Home, reemplazando el Splash en la pila de navegación.
    // Usar pushReplacementNamed evita que el usuario pueda volver
    // al Splash presionando el botón "atrás" del dispositivo.
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void dispose() {
    // Libera el controlador al destruir el widget (evita memory leaks)
    _controladorAnimacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo gris claro según la paleta definida en AppTheme
      backgroundColor: AppTheme.colorFondo,

      body: AnimatedBuilder(
        animation: _controladorAnimacion,
        builder: (context, child) {
          // Aplica opacidad y escala animadas al contenido completo
          return Opacity(
            opacity: _animacionOpacidad.value,
            child: Transform.scale(scale: _animacionEscala.value, child: child),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ------------------------------------------------
              // LOGO: tarjeta blanca redondeada con la imagen PNG
              // ------------------------------------------------
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: AppTheme.colorBlanco,
                  borderRadius: BorderRadius.circular(36),
                  // Sombra sutil para dar profundidad a la tarjeta
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.colorPrimario.withOpacity(0.18),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  // Borde rosa delgado alrededor de la tarjeta
                  border: Border.all(
                    color: AppTheme.colorPrimario.withOpacity(0.25),
                    width: 1.5,
                  ),
                ),
                // Carga el logo desde los assets del proyecto
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ------------------------------------------------
              // NOMBRE DE LA APP
              // ------------------------------------------------
              Text(
                'CasaRosada',
                style: TextStyle(
                  color: AppTheme.colorPrimario,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),

      // --------------------------------------------------------
      // NOMBRE DEL AUTOR en la parte inferior de la pantalla
      // --------------------------------------------------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Text(
          'Juan David Garcia Aponte',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.colorOscuro.withOpacity(0.6),
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
