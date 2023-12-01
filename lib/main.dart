import 'package:evaluacion_docente_frontend/bloc/question_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/student_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/user_cubit.dart';
import 'package:evaluacion_docente_frontend/secure_storage.dart';
import 'package:evaluacion_docente_frontend/ui/login_screen.dart';
import 'package:evaluacion_docente_frontend/ui/student_evaluation_screen.dart';
import 'package:evaluacion_docente_frontend/ui/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // este es el nivel más alto de la aplicación
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
            create: (context) => UserCubit(SecureStorage())),
        BlocProvider<StudentCubit>(create: (context) => StudentCubit()),
        BlocProvider<QuestionCubit>(create: (context) => QuestionCubit()),
      ],
      child: MaterialApp(
        title: 'Evaluación Docente UCB',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/student-home', // TODO: cambiar a '/login'
        routes: {
          '/login': (context) => const LoginScreen(),
          '/student-home': (context) => const StudentHomeScreen(),
          '/student-evaluation': (context) => const StudentEvaluationScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
