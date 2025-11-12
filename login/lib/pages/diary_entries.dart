import 'package:flutter/material.dart';
import 'diary_storage.dart';

class DiaryEntriesPage extends StatelessWidget {
  const DiaryEntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entries = DiaryStorage.getAll();
  
    return Scaffold(
      appBar: AppBar(title: const Text('Entradas guardadas')),
      body: entries.isEmpty
          ? const Center(child: Text('No hay entradas guardadas.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final e = entries[i];
                return ListTile(
                  title: Text(e.feeling.isEmpty ? '(Sin texto)' : e.feeling),
                  subtitle: Text(
                      'Tomó pastillas: ${e.tookPills ? 'Sí' : 'No'} · ${e.timestamp.toLocal().toString().split('.').first}'),
                  trailing: e.sleepTime == null
                      ? null
                      : Text(e.sleepTime!.format(context)),
                );
              },
            ),
    );
  }
}