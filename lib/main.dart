// ============================================================
// main.dart
//
// Configura:
//  - El tema global (colores, tipografía) desde AppTheme
//  - Las rutas de navegación de todas las pantallas
//  - La pantalla inicial: SplashScreen
//
// Flujo de navegación:
//   SplashScreen (3 seg) → HomeScreen → LoginScreen
// ============================================================

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

/// Función principal — inicia la aplicación Flutter
void main() {
  runApp(const MiApp());
}

/// Widget raíz de la aplicación.
/// MaterialApp configura el tema y el sistema de rutas.
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la app (se ve en el task switcher del sistema operativo)
      title: 'CasaRosada',
      // Oculta la cinta de "DEBUG" en la esquina superior derecha
      debugShowCheckedModeBanner: false,

      // Tema visual centralizado definido en lib/theme/app_theme.dart
      theme: AppTheme.temaApp,

      // Ruta inicial: siempre arranca desde el Splash
      initialRoute: '/',

      // --------------------------------------------------------
      // Mapa de rutas de la aplicación
      // Cada entrada conecta una cadena de texto con un Widget
      // --------------------------------------------------------
      routes: {
        // 1. Splash: pantalla de presentación (duración 3 segundos)
        '/': (context) => const SplashScreen(),

        // 2. Home: pantalla de bienvenida con descripción y botón "Comienza"
        '/home': (context) => const HomeScreen(),

        // 3. Login: pantalla de inicio de sesión
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
