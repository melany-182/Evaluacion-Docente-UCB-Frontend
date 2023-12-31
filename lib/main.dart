import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/question_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/student_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/teacher_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/teacher_query_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/user_cubit.dart';
import 'package:evaluacion_docente_frontend/secure_storage.dart';
import 'package:evaluacion_docente_frontend/ui/login_screen.dart';
import 'package:evaluacion_docente_frontend/ui/student_evaluation_screen.dart';
import 'package:evaluacion_docente_frontend/ui/student_home_screen.dart';
import 'package:evaluacion_docente_frontend/ui/teacher_evaluation_detail_screen.dart';
import 'package:evaluacion_docente_frontend/ui/teacher_home_screen.dart';
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
        BlocProvider<TeacherCubit>(create: (context) => TeacherCubit()),
        BlocProvider<EvaluationDetailCubit>(
            create: (context) => EvaluationDetailCubit()),
        BlocProvider<TeacherQueryCubit>(
            create: (context) => TeacherQueryCubit()),
      ],
      child: MaterialApp(
        title: 'Evaluación Docente UCB',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute:
            '/teacher-home', // TODO: cambiar a '/login' al integrar la autenticación
        routes: {
          '/login': (context) => const LoginScreen(),
          '/student-home': (context) => const StudentHomeScreen(),
          '/student-evaluation': (context) =>
              StudentEvaluationScreen(subjectEvaluationId: 0),
          '/teacher-home': (context) => const TeacherHomeScreen(),
          '/teacher-evaluation-detail': (context) =>
              TeacherEvaluationDetailScreen(
                  evaluationPercentage: '0',
                  subjectName: 'Nombre de la materia',
                  parallel: '0',
                  teacherSubjectId: 0),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
