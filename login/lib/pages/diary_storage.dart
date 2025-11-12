import 'package:flutter/material.dart';

class DiaryEntry {
  final String feeling;
  final bool tookPills;
  final TimeOfDay? sleepTime;
  final DateTime timestamp;

  DiaryEntry({
    required this.feeling,
    required this.tookPills,
    required this.sleepTime,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class DiaryStorage {
  // Almacenamiento en memoria simple. Puedes reemplazar por persistencia real.
  static final List<DiaryEntry> _entries = [];

  static void save(DiaryEntry entry) {
    _entries.add(entry);
  }

  static List<DiaryEntry> getAll() {
    return List.unmodifiable(_entries.reversed.toList()); // mostrar más reciente primero
  }

  static void clear() => _entries.clear();
}