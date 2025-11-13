import 'package:flutter/material.dart';
import '../theme.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String feeling = '';
  bool tookPills = false;
  TimeOfDay? sleepTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi Diario")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¿Cómo te sentiste hoy?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) => setState(() => feeling = value),
                decoration: const InputDecoration(
                  hintText: "Escribe cómo te sientes...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text("¿Tomaste tus pastillas hoy?"),
                value: tookPills,
                onChanged: (v) => setState(() => tookPills = v!),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  sleepTime == null
                      ? "Seleccionar hora de sueño"
                      : "Hora de sueño: ${sleepTime!.format(context)}",
                ),
                trailing: const Icon(Icons.bedtime),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setState(() => sleepTime = picked);
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registro guardado (modo demo)"),
                      ),
                    );
                  },
                  child: const Text("Guardar entrada"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
