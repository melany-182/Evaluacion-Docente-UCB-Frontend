import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_state.dart';
import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherEvaluationDetailScreen extends StatelessWidget {
  final String evaluationPercentage; // FIXME: quitar
  final String subjectName; // FIXME: quitar
  final String parallel; // FIXME: quitar
  final int teacherSubjectId;

  const TeacherEvaluationDetailScreen(
      {super.key,
      required this.evaluationPercentage,
      required this.subjectName,
      required this.parallel,
      required this.teacherSubjectId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EvaluationDetailCubit>(context)
        .generateSubjectEvaluationDetail(teacherSubjectId);
    BlocProvider.of<EvaluationDetailCubit>(context)
        .getSubjectEvaluationDetails(teacherSubjectId);
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('Evaluación Docente UCB'),
      ),
      body: BlocConsumer<EvaluationDetailCubit, EvaluationDetailState>(
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
            AlertDialog(
              title: const Text('Error'),
              content: Text(
                  'Error al obtener la data del detalle de la evaluación: ${state.errorMessage}'),
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
                    'Error al obtener la data del detalle de la evaluación: ${state.errorMessage}'),
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
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Detalles de la evaluación al $evaluationPercentage',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Materia: $subjectName',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Paralelo: $parallel',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Parámetros de evaluación',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final evaluationDetail = state.data[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    evaluationDetail.parameter,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 22.0),
                                LinearProgressIndicator(
                                  value:
                                      evaluationDetail.parameterCalification /
                                          100,
                                  backgroundColor: Colors.grey[400],
                                  valueColor: evaluationDetail
                                              .parameterCalification <
                                          50
                                      ? const AlwaysStoppedAnimation<Color>(
                                          Colors.red)
                                      : evaluationDetail.parameterCalification <
                                              75
                                          ? const AlwaysStoppedAnimation<Color>(
                                              Colors.orange)
                                          : const AlwaysStoppedAnimation<Color>(
                                              Colors.green),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${evaluationDetail.parameterCalification}%',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Resumen: ${evaluationDetail.messageForTeacher}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                // TODO: aquí viene el textfield para teacherquery
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Query docente',
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            );
          } else {
            return const Center(
              child: Text('No hay datos para mostrar.'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
