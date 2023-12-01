// ignore_for_file: use_build_context_synchronously

import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_state.dart';
import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/bloc/teacher_query_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherEvaluationDetailScreen extends StatelessWidget {
  final String evaluationPercentage; // FIXME: quitar
  final String subjectName; // FIXME: quitar
  final String parallel; // FIXME: quitar
  final int teacherSubjectId;
  final TextEditingController queryController = TextEditingController();

  TeacherEvaluationDetailScreen(
      {super.key,
      required this.evaluationPercentage,
      required this.subjectName,
      required this.parallel,
      required this.teacherSubjectId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EvaluationDetailCubit>(context)
        .generateSubjectEvaluationDetail(
            teacherSubjectId); // FIXME: hay que tener cuidado con esto
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors
                            .black, // Debes establecer el color para el TextSpan ya que no usa el estilo predeterminado del texto
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Materia: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: subjectName, // El texto dinámico va aquí
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Paralelo: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: parallel,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
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
                        child: Center(
                          child: SingleChildScrollView(
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
                                      value: evaluationDetail
                                              .parameterCalification /
                                          100,
                                      backgroundColor: Colors.grey[400],
                                      valueColor: evaluationDetail
                                                  .parameterCalification <
                                              50
                                          ? const AlwaysStoppedAnimation<Color>(
                                              Colors.red)
                                          : evaluationDetail
                                                      .parameterCalification <
                                                  75
                                              ? const AlwaysStoppedAnimation<
                                                  Color>(Colors.orange)
                                              : const AlwaysStoppedAnimation<
                                                  Color>(Colors.green),
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Consulta específica',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: queryController,
                    maxLength: 200,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Escribe tu consulta aquí',
                      border: const OutlineInputBorder(),
                      labelText: 'Consulta',
                      counterStyle: const TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.grey[1000],
                          onPressed: () async {
                            if (queryController.text.isEmpty) {
                              // Mostrar un SnackBar si el campo de consulta está vacío
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Debes escribir una consulta primero.'),
                                ),
                              );
                            } else {
                              try {
                                String result = await BlocProvider.of<
                                        TeacherQueryCubit>(context)
                                    .makeQuery(
                                        teacherSubjectId, queryController.text);

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text('Resultado de la consulta'),
                                    content: Text(result),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cerrar'),
                                      ),
                                    ],
                                  ),
                                );
                              } catch (e) {
                                debugPrint('Error: ${e.toString()}');
                              }
                            }
                          }),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: ver historial de consultas
                      },
                      child: const Text(
                        'Ver historial de consultas',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
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
        child: SizedBox(
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
