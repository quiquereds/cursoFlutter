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
              SizedBox(height: 20),
              _RegisterForm(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    // Creamos la referencia al cubit que maneja el estado del formulario
    final registerCubit = context.watch<RegisterCubit>();
    // Obtenemos el valor del estado actual de los campos
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            prefixIcon: const Icon(Icons.person),
            // Mandamos a actualizar el estado del cubit
            onChanged: registerCubit.usernameChanged,
            errorMessage: username.errrorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email_rounded),
            onChanged: registerCubit.emailChanged,
            errorMessage: email.errrorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            prefixIcon: const Icon(Icons.password),
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errrorMessage,
          ),
          const SizedBox(height: 40),
          FilledButton.tonalIcon(
            onPressed: () {
              // Validación y posteo
              registerCubit.onSubmit();
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
