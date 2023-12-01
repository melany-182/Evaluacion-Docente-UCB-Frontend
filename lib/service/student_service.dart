import 'dart:convert';
import 'package:evaluacion_docente_frontend/dto/question_dto.dart';
import 'package:evaluacion_docente_frontend/dto/student_subject_dto.dart';
import 'package:evaluacion_docente_frontend/dto/response_dto.dart';
import 'package:evaluacion_docente_frontend/service/ip/ip.dart' as ip;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentService {
  static String backendUrlBase = ip.urlBackend;

  static Future<List<StudentSubjectDto>> getSubjects() async {
    List<StudentSubjectDto> result;
    var uri = Uri.parse(
        '$backendUrlBase/api/v1/teachers/1'); // FIXME: quitar id del endpoint al integrar la autenticación
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint('backend response (GET SUBJECTS): ${responseDto.toJson()}');
      if (responseDto.code.toString() == '200') {
        result = (responseDto.response as List)
            .map((e) => StudentSubjectDto.fromJson(e))
            .toList();
        // debugPrint('result: $result'); // aquí imprime el resultado
      } else {
        debugPrint('vino por aquí');
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error al intentar obtener los datos de las materias.');
    }
    return result;
  }

  static Future<List<QuestionDto>> fetchQuestions() async {
    List<QuestionDto> result;
    var uri = Uri.parse('$backendUrlBase/api/v1/evaluations/questions');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint('backend response (GET QUESTIONS): ${responseDto.toJson()}');
      if (responseDto.code.toString() == '200') {
        result = (responseDto.response as List)
            .map((e) => QuestionDto.fromJson(e))
            .toList();
      } else {
        debugPrint('vino por aquí');
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error al intentar obtener los datos de las preguntas.');
    }
    return result;
  }

  static Future<void> evaluateTeacher(
      int subjectEvaluationId, Map<int, String> answers) async {
    var uri = Uri.parse('$backendUrlBase/api/v1/teachers');

    // Construir la lista de respuestas para enviar
    List<Map<String, dynamic>> answersList = answers.entries.map((entry) {
      return {
        'subjectEvaluation': {'subjectEvaluationId': subjectEvaluationId},
        'question': {'questionId': entry.key},
        'student': {
          'userId': 1
        }, // FIXME: quitar este id predeterminado al integrar la autenticación
        'answerText': entry.value,
        'status': 1
      };
    }).toList();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode(answersList);

    var response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint(
          'backend response (EVALUATE TEACHER): ${responseDto.toJson()}');
      if (responseDto.code.toString() == '200') {
        debugPrint('evaluación exitosa');
      } else {
        debugPrint('vino por aquí');
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception('Error al intentar evaluar al docente.');
    }
  }
}
