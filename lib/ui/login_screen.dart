import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:evaluacion_docente_frontend/bloc/user_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatelessWidget {
  final Auth0? auth0;

  const LoginScreen({this.auth0, final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final auth0Instance = auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    final scheme = dotenv.env['AUTH0_CUSTOM_SCHEME']!;

    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          bottom: 40.0,
          left: 40.0 / 2,
          right: 40.0 / 2,
        ),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            // TODO: implementar listener
          },
          builder: (context, state) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: state.user != null
                          ? UserWidget(user: state.user)
                          : const HeroWidget()),
                  state.user != null
                      ? ElevatedButton(
                          onPressed: () => context
                              .read<UserCubit>()
                              .logout(auth0Instance, scheme),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Text('Logout'),
                        )
                      : ElevatedButton.icon(
                          onPressed: (() => context
                              .read<UserCubit>()
                              .login(auth0Instance, scheme)),
                          icon: const Icon(Icons.emoji_emotions,
                              color: Colors.white),
                          label: const Text('Login'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                        ),
                ]);
          },
        ),
      )),
    );
  }
}

// widgets (hero y user)

final Shader linearGradient = const LinearGradient(colors: <Color>[
  Color.fromRGBO(255, 79, 64, 100),
  Color.fromRGBO(255, 68, 221, 100)
], begin: Alignment.topLeft, end: Alignment.bottomRight)
    .createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0));

class HeroWidget extends StatelessWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/icon.png', width: 24),
                const Text(
                  'Evaluación Docente UCB',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // TODO: implementar acción del botón de info
              },
              icon: const Icon(Icons.info, color: Colors.black),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Image.asset('assets/images/logo.png', width: 24),
        )
      ],
    );
  }
}

//
class UserWidget extends StatelessWidget {
  final UserProfile? user;

  const UserWidget({required this.user, final Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pictureUrl = user?.pictureUrl;
    // id, name, email, email verified, updated_at
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (pictureUrl != null)
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: CircleAvatar(
              radius: 56,
              child: ClipOval(child: Image.network(pictureUrl.toString())),
            )),
      Card(
          child: Column(children: [
        UserEntryWidget(propertyName: 'Id', propertyValue: user?.sub),
        UserEntryWidget(propertyName: 'Name', propertyValue: user?.name),
        UserEntryWidget(propertyName: 'Email', propertyValue: user?.email),
        UserEntryWidget(
            propertyName: 'Email Verified?',
            propertyValue: user?.isEmailVerified.toString()),
        UserEntryWidget(
            propertyName: 'Updated at',
            propertyValue: user?.updatedAt?.toIso8601String()),
      ]))
    ]);
  }
}

class UserEntryWidget extends StatelessWidget {
  final String propertyName;
  final String? propertyValue;

  const UserEntryWidget(
      {required this.propertyName, required this.propertyValue, final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(propertyName), Text(propertyValue ?? '')],
        ));
  }
}
