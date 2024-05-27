import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/config/theme/app_theme.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Envolvemos la app en un MultiProvider que permite que la app raíz tenga
    /// múltiples proveedores de información, para que todos los widgets hijos
    /// tengan acceso a estas clases de providers.
    return MultiProvider(
      providers: [
        // Creamos un proveedor del chat a nivel global de la aplicación
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // LLamamos a la función theme de la clase AppTheme
        theme: AppTheme(selectedColor: 2, darkThemeEnabled: true).theme(),
        title: 'Yes No App',
        home: const ChatScreen(),
      ),
    );
  }
}
