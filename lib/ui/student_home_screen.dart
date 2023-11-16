import 'package:evaluacion_docente_frontend/bloc/student_subject_cubit.dart';
import 'package:evaluacion_docente_frontend/bloc/student_subject_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.data.isNotEmpty) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    // itemCount: state.data.length,
                    // itemBuilder: (context, index) {
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      const ListTile(
                        title: Text('Evaluación de docentes',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      ListTile(
                        title: Text('Docentes sin evaluar',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: DataTable(
                          columns: const <DataColumn>[
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
                          rows: const <DataRow>[
                            DataRow(cells: <DataCell>[
                              DataCell(Center(
                                  child: Text('YAÑEZ GUZMÁN MARÍA LUCERO'))),
                              DataCell(Center(
                                  child: Text('SIS-123 ESTRUCTURAS DE DATOS'))),
                              DataCell(Center(child: Text('1'))),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(
                                  Center(child: Text('RIVERA JURADO ORLANDO'))),
                              DataCell(Center(
                                  child: Text(
                                      'SIS-111 INTRODUCCIÓN A LA PROGRAMACIÓN'))),
                              DataCell(Center(child: Text('3'))),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Center(
                                  child:
                                      Text('CAMPOHERMOSO ALCÓN ERNESTO OMAR'))),
                              DataCell(Center(
                                  child:
                                      Text('SIS-213 INGENIERÍA DEL SOFTWARE'))),
                              DataCell(Center(child: Text('2'))),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListTile(
                          title: Text('Docentes evaluados',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.left)),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child:
                            Text('Todavía no has evaluado a ningún docente.'),
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
                            // TODO: implementar cerrar sesión
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
              child: Text(
                'No existen materias registradas.',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
        },
      ),
    );
  }
}
