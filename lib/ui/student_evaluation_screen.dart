import 'package:evaluacion_docente_frontend/bloc/question_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/question_state.dart';
import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: completar la implementación de esta pantalla
class StudentEvaluationScreen extends StatelessWidget {
  const StudentEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuestionCubit>(context).getQuestions();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación Docente UCB'),
      ),
      body: BlocConsumer<QuestionCubit, QuestionState>(
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
            AlertDialog(
              title: const Text('Error'),
              content: Text(
                  'Error al obtener la data de las preguntas: ${state.errorMessage}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Error al obtener la data de las preguntas: ${state.errorMessage}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == PageStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.data.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 12.0),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                            'Evaluación de docentes', // TODO: cambiar a nombre del docente
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12.0),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Preguntas',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.data[index].questionText),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No existen preguntas registradas.'),
            );
          }
        },
      ),
    );
  }
}
