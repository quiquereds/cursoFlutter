import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    /// Renderiza los widgets dentro de un espacio de margenes accesibles por
    /// el usuario en iOS y Android
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        // Permite el desplazamiento en widgets con posible overflow
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterLogo(size: 100),
              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  /// Creamos una llave o controlador del formulario
  /// Este dará acceso a poder validar todos los campos que esten dentro
  /// del widget Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Creamos la referencia al cubit que maneja el estado del formulario
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            prefixIcon: const Icon(Icons.person),
            // Mandamos a actualizar el estado del cubit
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              // Validamos los cambios en el formulario
              _formKey.currentState?.validate();
            },
            // Creamos las validaciones
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Más de 6 caracteres';

              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email_rounded),
            onChanged: (value) {
              registerCubit.emailChanged(value);
              // Validamos los cambios en el formulario
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';

              // Expresión regular para validar correos electrónicos
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (!emailRegExp.hasMatch(value)) return 'Email no es valido';

              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            prefixIcon: const Icon(Icons.password),
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              // Validamos los cambios en el formulario
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Más de 6 caracteres';

              return null;
            },
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: () {
              // Validamos el formulario
              final isValid = _formKey.currentState!.validate();

              registerCubit.onSubmit();

              if (isValid) return;
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
