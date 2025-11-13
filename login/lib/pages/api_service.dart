import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // URL de tu Flask API
  // quitar la barra final para evitar '//' accidental al concatenar
  static const String baseUrl = 'http://10.215.221.252:5000';

  // REGISTRO
  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await http
          .post(
            // ruta del servidor Flask según tus logs
            Uri.parse('$baseUrl/api/usuarios/registro'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              // la API espera campos en español según /api/info
              'email': email,
              'contrasena': password,
              'nombre': name,
            }),
          )
          // evita waits indefinidos
          .timeout(const Duration(seconds: 10));

      dynamic data;
      try {
        data = json.decode(response.body);
      } catch (_) {
        data = {'raw': response.body};
      }

      // debug: log response body/status in debug mode to help troubleshooting
      if (kDebugMode) {
        try {
          print(
            'ApiService.signup -> ${response.statusCode}: ${response.body}',
          );
        } catch (_) {}
      }

      return {
        // considerar cualquier 2xx como éxito (p. ej. registro puede devolver 201)
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': data,
        'statusCode': response.statusCode,
      };
    } on SocketException catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión (socket): ${e.message}'},
        'statusCode': 500,
      };
    } on TimeoutException catch (_) {
      return {
        'success': false,
        'data': {'error': 'Timeout: la petición tardó demasiado.'},
        'statusCode': 500,
      };
    } catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión: $e'},
        'statusCode': 500,
      };
    }
  }

  // LOGIN
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/usuarios/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              // la API espera 'contrasena' en lugar de 'password'
              'email': email,
              'contrasena': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      dynamic data;
      try {
        data = json.decode(response.body);
      } catch (_) {
        data = {'raw': response.body};
      }

      if (kDebugMode) {
        try {
          print('ApiService.login -> ${response.statusCode}: ${response.body}');
        } catch (_) {}
      }

      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': data,
        'statusCode': response.statusCode,
      };
    } on SocketException catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión (socket): ${e.message}'},
        'statusCode': 500,
      };
    } on TimeoutException catch (_) {
      return {
        'success': false,
        'data': {'error': 'Timeout: la petición tardó demasiado.'},
        'statusCode': 500,
      };
    } catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión: $e'},
        'statusCode': 500,
      };
    }
  }

  // WELCOME
  static Future<Map<String, dynamic>> getWelcome({
    required String email,
  }) async {
    try {
      final response = await http
          .get(
            // el endpoint /api/info es informativo; no requiere email
            Uri.parse('$baseUrl/api/info'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      dynamic data;
      try {
        data = json.decode(response.body);
      } catch (_) {
        data = {'raw': response.body};
      }

      if (kDebugMode) {
        try {
          print(
            'ApiService.getWelcome -> ${response.statusCode}: ${response.body}',
          );
        } catch (_) {}
      }

      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'data': data,
        'statusCode': response.statusCode,
      };
    } on SocketException catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión (socket): ${e.message}'},
        'statusCode': 500,
      };
    } on TimeoutException catch (_) {
      return {
        'success': false,
        'data': {'error': 'Timeout: la petición tardó demasiado.'},
        'statusCode': 500,
      };
    } catch (e) {
      return {
        'success': false,
        'data': {'error': 'Error de conexión: $e'},
        'statusCode': 500,
      };
    }
  }
}
