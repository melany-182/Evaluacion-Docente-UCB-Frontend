import 'dart:convert';
import 'package:evaluacion_docente_frontend/dto/evaluation_detail_dto.dart';
import 'package:evaluacion_docente_frontend/dto/response_dto.dart';
import 'package:evaluacion_docente_frontend/dto/teacher_subject_dto.dart';
import 'package:evaluacion_docente_frontend/service/ip/ip.dart' as ip;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherService {
  static String backendUrlBase = ip.urlBackend;

  static Future<List<TeacherSubjectDto>> getSubjects() async {
    List<TeacherSubjectDto> result;
    var uri = Uri.parse(
        '$backendUrlBase/api/v1/subjects/4'); // FIXME: quitar id del endpoint al integrar la autenticación
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
            .map((e) => TeacherSubjectDto.fromJson(e))
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

  static Future generateSubjectEvaluationDetail(int teacherSubjectId) async {
    var uri =
        Uri.parse('$backendUrlBase/api/v1/subjects/$teacherSubjectId/generate');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint(
          'backend response (GENERATE SUBJECT EVALUATION DETAILS): ${responseDto.toJson()}');
      if (responseDto.code.toString() == '200') {
        debugPrint('Detalles generados correctamente.');
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception(
          'Error al intentar generar los detalles de la evaluación de la materia.');
    }
    return 'Detalles generados correctamente.';
  }

  static Future<List<EvaluationDetailDto>> getSubjectEvaluationDetails(
      int teacherSubjectId) async {
    List<EvaluationDetailDto> result;
    var uri =
        Uri.parse('$backendUrlBase/api/v1/subjects/$teacherSubjectId/details');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      debugPrint(
          'backend response (GET SUBJECT EVALUATION DETAILS): ${responseDto.toJson()}');
      if (responseDto.code.toString() == '200') {
        result = (responseDto.response as List)
            .map((e) => EvaluationDetailDto.fromJson(e))
            .toList();
        // debugPrint('result: $result'); // aquí imprime el resultado
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      throw Exception(
          'Error al intentar obtener los detalles de la evaluación de la materia.');
    }
    return result;
  }
}
