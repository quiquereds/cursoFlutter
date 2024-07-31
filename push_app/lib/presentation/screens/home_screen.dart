import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:push_app/presentation/blocs/notifications_bloc/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (NotificationsBloc bloc) => Text('${bloc.state.status}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia al estado de NotificationsBloc
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;

    return ListView.builder(
      // TODO 4: Realizar implementación del ListView
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: notification.imageUrl != null
              ? Image.network(notification.imageUrl!)
              : null,
          onTap: () => context.push('/push-details/${notification.messageId}'),
        );
      },
    );
  }
}
