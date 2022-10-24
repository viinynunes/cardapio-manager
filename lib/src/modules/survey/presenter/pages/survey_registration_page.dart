import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/survey.dart';
import '../../infra/models/survey_model.dart';

class SurveyRegistrationPage extends StatefulWidget {
  const SurveyRegistrationPage({Key? key, this.survey}) : super(key: key);

  final Survey? survey;

  @override
  State<SurveyRegistrationPage> createState() => _SurveyRegistrationPageState();
}

class _SurveyRegistrationPageState extends State<SurveyRegistrationPage> {
  late Survey newSurvey;

  final formKey = GlobalKey<FormState>();
  final titleFocus = FocusNode();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    if (widget.survey != null) {
      newSurvey = SurveyModel.fromSurvey(widget.survey!);
      titleController.text = widget.survey!.title;
      descriptionController.text = widget.survey!.description;
      enabled = widget.survey!.enabled;
    }

    titleFocus.requestFocus();
  }

  getNewSurvey() {
    newSurvey = Survey(
        id: widget.survey?.id ?? '0',
        title: titleController.text,
        description: descriptionController.text,
        enabled: enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey?.title ?? 'Nova Pesquisa'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                titleController.text = '';
                descriptionController.text = '';
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            getNewSurvey();
            Modular.to.pop(newSurvey);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  focusNode: titleFocus,
                  decoration: const InputDecoration(
                    hintText: 'Titulo',
                    label: Text('Titulo'),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 3) {
                      return 'Titulo inválido';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Descrição',
                    label: Text('Descrição'),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
