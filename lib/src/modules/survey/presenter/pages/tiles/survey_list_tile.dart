import 'package:cardapio_manager/src/modules/survey/domain/entities/survey.dart';
import 'package:flutter/material.dart';

class SurveyListTile extends StatefulWidget {
  const SurveyListTile(
      {Key? key,
      required this.survey,
      required this.onTap,
      required this.onEnabled,
      required this.showResponses})
      : super(key: key);

  final Survey survey;
  final VoidCallback onTap;
  final VoidCallback showResponses;
  final Function(bool enabled) onEnabled;

  @override
  State<SurveyListTile> createState() => _SurveyListTileState();
}

class _SurveyListTileState extends State<SurveyListTile> {
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    enabled = widget.survey.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  widget.survey.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(
                        widget.survey.description,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Switch(
                        value: enabled,
                        onChanged: (value) {
                          setState(() {
                            enabled = value;
                            widget.onEnabled(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: widget.showResponses,
                  child: const Text('Respostas'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
