import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RendererBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_practical/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:flutter_practical/features/profile/presentation/screen/user_profile_screen.dart';
import 'my_services.dart';

/// A screen that defers the initialization of its content until an async operation completes.
class DeferScreen extends StatelessWidget {
  const DeferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DeferInit(
        create: () async {
          await MyService.init();
          final bool isRemembered =
              await MyService.instance.isLoggedIn() ?? false;
          if (isRemembered) {
            return BlocProvider(
              create: (context) => UserProfileBloc()
                ..add(
                  GetAllUsersProfile(),
                ),
              child: const UserProfileScreen(),
            );
          } else if (!isRemembered) {
            return const LoginScreen();
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
        emptyWidget: const Center(
          child: Text('Something went wrong.'),
        ),
      ),
    );
  }
}

/// Signature for a function that asynchronously creates a widget.
typedef DeferInitCreate<T extends Widget?> = Future<T> Function();

/// A widget that defers the initialization of its content until an async operation completes.
class DeferInit<T extends Widget?> extends StatefulWidget {
  const DeferInit({
    Key? key,
    required this.create,
    this.emptyWidget = const SizedBox.shrink(),
  }) : super(key: key);

  /// The asynchronous function that creates the widget to be deferred.
  final DeferInitCreate<T> create;

  /// The widget to display when the async operation has not completed yet.
  final Widget emptyWidget;

  @override
  State<DeferInit<T>> createState() => _DeferInitState<T>();
}

class _DeferInitState<T extends Widget?> extends State<DeferInit<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    RendererBinding.instance.deferFirstFrame();
    _future = widget.create().whenComplete(() {
      RendererBinding.instance.allowFirstFrame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        } else {
          final Widget? data = snapshot.data;
          return data ?? widget.emptyWidget;
        }
      },
    );
  }
}
