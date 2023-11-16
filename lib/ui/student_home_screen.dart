import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evaluacion_docente_frontend/bloc/student_subject_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/student_subject_state.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentSubjectCubit>(context).getSubjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación Docente UCB'),
      ),
      body: BlocConsumer<StudentSubjectCubit, StudentSubjectState>(
        listener: (context, state) {
          if (state.status == PageStatus.failure) {
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
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Evaluación de docentes',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Docentes sin evaluar',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Docente')),
                    DataColumn(label: Text('Materia')),
                    DataColumn(label: Text('Paralelo')),
                  ],
                  rows: List<DataRow>.generate(
                    state.data.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(
                            '${state.data[index].teacherFirstName} ${state.data[index].teacherLastName}')),
                        DataCell(Text(state.data[index].subjectName)),
                        DataCell(Text(state.data[index].parallel.toString())),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Docentes evaluados',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                // Add your evaluated teachers list here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Todavía no has evaluado a ningún docente.',
                    style: Theme.of(context).textTheme.subtitle1,
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
                            // TODO: Implement logout functionality
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
