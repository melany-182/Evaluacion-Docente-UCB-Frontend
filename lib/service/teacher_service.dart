import 'dart:convert';
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
}
