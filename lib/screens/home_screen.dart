// ============================================================
// home_screen.dart
// Pantalla de Bienvenida (Home Screen).
//
// Esta es la segunda pantalla que ve el usuario, justo después
// del Splash. Presenta la app con:
//  - Logo grande centrado
//  - Nombre de la app
//  - Descripción breve
//  - Botón "Comienza" → navega al Login
//  - Enlace "Regístrate" → navega al Login (modo registro)
//
// Animación: los elementos entran con un efecto slide-up + fade
// ============================================================

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // --- Controlador de animación de entrada ---
  late AnimationController _controladorAnimacion;

  // Animación del logo: entra deslizándose desde arriba
  late Animation<Offset> _animacionLogo;

  // Animación del texto y botones: entra deslizándose desde abajo
  late Animation<Offset> _animacionContenido;

  // Animación de opacidad general para el fade-in
  late Animation<double> _animacionOpacidad;

  @override
  void initState() {
    super.initState();

    // Duración total de la animación de entrada: 900ms
    _controladorAnimacion = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // El logo cae desde arriba (offset Y negativo → posición normal)
    _animacionLogo =
        Tween<Offset>(begin: const Offset(0, -0.4), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controladorAnimacion,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    // El contenido inferior sube desde abajo (offset Y positivo → posición normal)
    _animacionContenido =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controladorAnimacion,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Todo el contenido aparece con fade-in desde transparente
    _animacionOpacidad = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controladorAnimacion,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Lanza la animación al construir la pantalla
    _controladorAnimacion.forward();
  }

  @override
  void dispose() {
    // Libera recursos del controlador al salir de la pantalla
    _controladorAnimacion.dispose();
    super.dispose();
  }

  /// Navega a la pantalla de Login.
  /// [esRegistro] indica si el usuario llegó desde "Regístrate"
  /// o desde el botón "Comienza" (ambos van al mismo Login por ahora).
  void _irAlLogin({bool esRegistro = false}) {
    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de pantalla para hacer el diseño responsive
    final double altoPantalla = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.colorFondo,

      // Center ubica su hijo justo en el centro exacto de la pantalla,
      // tanto vertical como horizontalmente, sin importar el tamaño del dispositivo.
      body: Center(
        child: FadeTransition(
          opacity: _animacionOpacidad,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              // mainAxisSize.min hace que la Column solo ocupe el espacio
              // que necesitan sus hijos, permitiendo que Center la centre.
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ------------------------------------------------
                // SECCIÓN SUPERIOR: Logo con animación desde arriba
                // ------------------------------------------------
                SlideTransition(
                  position: _animacionLogo,
                  child: _construirTarjetaLogo(),
                ),

                // Espacio fijo entre el logo y el texto
                SizedBox(height: altoPantalla * 0.05),

                // ------------------------------------------------
                // SECCIÓN INFERIOR: Texto y botones con animación
                // ------------------------------------------------
                SlideTransition(
                  position: _animacionContenido,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nombre de la app en rosa y negrita
                      Text(
                        'CasaRosada',
                        style: TextStyle(
                          color: AppTheme.colorPrimario,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Descripción breve centrada con color oscuro suave
                      Text(
                        'Encuentra tu vivienda en Casa Rosada y '
                        'descubre una nueva forma de vivir tus sueños en tu techo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.colorOscuro.withOpacity(0.75),
                          fontSize: 15,
                          height: 1.5, // Interlineado para mejor legibilidad
                        ),
                      ),

                      SizedBox(height: altoPantalla * 0.07),

                      // ----------------------------------------
                      // BOTÓN PRINCIPAL: "Comienza"
                      // Al presionarlo navega a la pantalla Login
                      // ----------------------------------------
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => _irAlLogin(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.colorPrimario,
                            foregroundColor: AppTheme.colorBlanco,
                            // Bordes completamente redondeados (estilo píldora)
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 4,
                            shadowColor: AppTheme.colorPrimario.withOpacity(
                              0.4,
                            ),
                          ),
                          child: const Text(
                            'Comienza',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ----------------------------------------
                      // ENLACE SECUNDARIO: "Regístrate"
                      // También dirige al Login (para registrarse)
                      // ----------------------------------------
                      GestureDetector(
                        onTap: () => _irAlLogin(esRegistro: true),
                        child: Text(
                          'Regístrate',
                          style: TextStyle(
                            color: AppTheme.colorPrimario,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            // Subrayado para indicar que es un enlace clickeable
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.colorPrimario,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construye la tarjeta blanca redondeada que contiene el logo.
  /// Misma estética que en la SplashScreen para coherencia visual.
  Widget _construirTarjetaLogo() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: AppTheme.colorBlanco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppTheme.colorPrimario.withOpacity(0.18),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: AppTheme.colorPrimario.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
      ),
    );
  }
}
