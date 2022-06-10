import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.success) {
          Navigator.pop(context);
        } else if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Erro ao salvar Task').show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Criar nova task',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome da task'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _durationEC,
                  decoration: const InputDecoration(
                    label: Text('Duração da task'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatória'),
                    Validatorless.number('Permitido somente números'),
                  ]),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    label: 'Salvar',
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        widget.controller.register(
                            _nameEC.text, int.parse(_durationEC.text));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
