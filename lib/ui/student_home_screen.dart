import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evaluacion_docente_frontend/bloc/student_subject_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/student_subject_state.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentSubjectCubit>(context)
        .getSubjects(); // obtención de las materias mediante el cubit

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación Docente UCB'),
      ),
      body: BlocConsumer<StudentSubjectCubit, StudentSubjectState>(
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
            AlertDialog(
              title: const Text('Error'),
              content: Text(
                  'Error al obtener la data de las materias: ${state.errorMessage}'),
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
                    'Error al obtener la data de las materias: ${state.errorMessage}'),
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
                        child: Text('Evaluación de docentes',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                        child: Text(
                          'Docentes sin evaluar',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Docente',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Materia',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Center(
                                child: Text('Paralelo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            )),
                          ],
                          rows: List<DataRow>.generate(
                            state.data.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Center(
                                  child: Text(
                                    '${state.data[index].teacherFirstName} ${state.data[index].teacherLastName}',
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline),
                                  ),
                                )),
                                DataCell(Center(
                                    child:
                                        Text(state.data[index].subjectName))),
                                DataCell(Center(
                                    child: Text(state.data[index].parallel
                                        .toString()))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                        child: Text(
                          'Docentes evaluados',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // TODO: agregar lista de docentes evaluados
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Todavía no has evaluado a ningún docente.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: implementar logout
                          },
                          icon: const Icon(Icons.logout),
                          tooltip: 'Cerrar sesión',
                        ),
                        const Text('Cerrar sesión'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No existen materias registradas.'),
            );
          }
        },
      ),
    );
  }
}
