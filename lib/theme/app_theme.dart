// ============================================================
// app_theme.dart
// Define los colores y estilos globales de la aplicación.
// Centralizar el tema aquí facilita cambios en toda la app.
// ============================================================

import 'package:flutter/material.dart';

class AppTheme {
  // --- Paleta de colores principal ---
  static const Color colorPrimario = Color(
    0xFFFF3D7F,
  ); // Rosa vibrante (botones, textos destacados)
  static const Color colorFondo = Color(
    0xFFEDEDED,
  ); // Gris claro (fondo de pantallas)
  static const Color colorOscuro = Color(
    0xFF1B2A4A,
  ); // Azul marino oscuro (textos secundarios)
  static const Color colorBlanco = Color(
    0xFFFFFFFF,
  ); // Blanco puro (tarjetas, íconos)

  // --- Configuración del ThemeData de la app ---
  static ThemeData get temaApp => ThemeData(
    // Color principal del sistema de diseño Material
    colorScheme: ColorScheme.fromSeed(seedColor: colorPrimario),

    // Fuente global de la aplicación
    fontFamily: 'Poppins',

    useMaterial3: true,
  );
}
