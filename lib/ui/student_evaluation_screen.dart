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
            List<TextEditingController> controllers = List.generate(
                state.data.length,
                (index) =>
                    TextEditingController()); // TODO: usar para obtener las respuestas
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 12.0),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Evaluación a docente: ...', // TODO: cambiar a nombre del docente
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${index + 1}. ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        TextSpan(
                                          text: state.data[index].questionText,
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    controller: controllers[index],
                                    maxLength: 200,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      hintText: 'Escribe tu respuesta aquí',
                                      border: OutlineInputBorder(),
                                      labelText: 'Respuesta',
                                      counterStyle:
                                          TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // TODO: acciones para 'Enviar evaluación'
              },
            ),
          ],
        ),
      ),
    );
  }
}
