import 'package:consent_app/src/procedure_chooser_feature/procedure_item_list_view.i18n.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../database.dart';
import '../../main.dart';
import '../components/frame.dart';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:survey_kit/survey_kit.dart';

SingleChoiceAnswerFormat Function() yesNoNotSure =
    () => SingleChoiceAnswerFormat(
          textChoices: [
            TextChoice(text: multiLingualText('Yes'), value: 'Yes'),
            TextChoice(text: multiLingualText('No'), value: 'No'),
            TextChoice(text: multiLingualText('Not Sure'), value: 'Not Sure'),
          ],
        );

multiLingualText(String txt) {
  return (locator<Store>().language == 'en')
      ? txt
      : '${"${txt}".i18n} (${txt})';
}

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  static const routeName = '/Survey';

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    return FrameView(
        heading: 'Survey'.i18n, body: const Center(child: SurveyApp()));
  }
}

class SurveyApp extends StatefulWidget {
  const SurveyApp({super.key});

  @override
  _SurveyAppState createState() => _SurveyAppState();
}

class _SurveyAppState extends State<SurveyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: FutureBuilder<Task>(
          future: getQuizTask(),
          builder: (context, snapshot) {
            // todo : check all these conditions are correct
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              final task = snapshot.data!;
              return SurveyKit(
                onResult: (SurveyResult result) async {
                  storeSurveyWrapper(result);
                //go somewhere!?
                },
                task: task,
                showProgress: true,
                localizations: {
                  'cancel': 'Cancel'.i18n,
                  'next': 'Next'.i18n,
                },
                themeData: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                      primary: Color(0xFF005EB8),
                      secondary: Color(0xFF005EB8),
                      background: Colors.green),
                  cupertinoOverrideTheme: const CupertinoThemeData(),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(150.0, 60.0),
                      ),
                      side: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> state) {
                          if (state.contains(MaterialState.disabled)) {
                            return const BorderSide(
                              color: Colors.grey,
                            );
                          }
                          return const BorderSide(
                            color: Colors.cyan,
                          );
                        },
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  textButtonTheme: const TextButtonThemeData(
                    style: ButtonStyle(),
                  ),
                  textTheme: const TextTheme(
                      displayMedium: TextStyle(
                    fontSize: 28.0,
                    color: Colors.black,
                  )),
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                surveyProgressbarConfiguration: SurveyProgressConfiguration(
                  backgroundColor: const Color(0xFFFFEB3B),
                  progressbarColor: const Color(0xFFFFEB3B),
                  height: 18,
                ),
              );
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }

  storeSurveyWrapper(SurveyResult result) async => await storeSurvey(result);

  Future<void> storeSurvey(SurveyResult result) async {
    List resultArray = [];
    for (var element in result.results) {
      List innerResult = [];
      for (var innerele in element.results) {
        innerResult.add(innerele.valueIdentifier);
      }
      resultArray.add(
        {
          'id': element.id?.id,
          'startDate': element.startDate.toString(),
          'endDate': element.endDate.toString(),
          'results': innerResult,
        },
      );
    }
    var jsonData = jsonEncode(resultArray);
    Store store = locator<Store>();
    developer.log('jsonData');
    developer.log(jsonData);
    insertFeedback('',jsonData, store.language);
  }

  Future<Task> getQuizTask() {
    Store store = locator<Store>();
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Thank you for taking this survey',
          text: 'Please answer the following ten short questions',
          buttonText: 'Start',
        ),
        QuestionStep(
          title:
              'Was it made clear to you WHAT procedure you were having?'.i18n,
          text: (store.language == 'en')
              ? ''
              : 'Was it made clear to you WHAT procedure you were having?',
          answerFormat: yesNoNotSure(),
          isOptional: true,
        ),
        QuestionStep(
          title: 'Was it made clear to you WHY you were having the procedure?',
          answerFormat: yesNoNotSure(),
        ),
        // QuestionStep(
        //   title: 'Were the risks of the procedure explained to you?',
        //   text: '',
        //   answerFormat: yesNoNotSure,
        // ),
        // QuestionStep(
        //   title: 'Were the options of anaesthetic spray and sedation made clear to you?',
        //   answerFormat: yesNoNotSure,
        // ),
        // QuestionStep(
        //   title: 'Were the RISKS of sedation made clear to you?',
        //   text: '',
        //   isOptional: false,
        //   answerFormat: yesNoNotSure,
        // ),
        // QuestionStep(
        //   title: 'Were you told you would need an escort if you chose to have sedation?',
        //   answerFormat: SingleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Yes', value: 'Yes'),
        //       TextChoice(text: 'No', value:'No'),
        //       TextChoice(text: 'Not Sure', value: 'Not Sure'),
        //       TextChoice(text: "I didn’t want sedation", value: "I didn’t want sedation"),
        //     ],
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Were you told that you would need to have someone '
        //       'with you for 24 hours if you chose to have sedation?',
        //   answerFormat: SingleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Yes', value: 'Yes'),
        //       TextChoice(text: 'No', value:'No'),
        //       TextChoice(text: 'Not Sure', value: 'Not Sure'),
        //       TextChoice(text: "I didn’t want sedation", value: "I didn’t want sedation"),
        //     ],
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Did the doctor/nurse ask whether you had any questions?',
        //   answerFormat: yesNoNotSure,
        // ),
        // QuestionStep(
        //   title: 'Were your questions answered to your satisfaction?',
        //   answerFormat: SingleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Yes', value: 'Yes'),
        //       TextChoice(text: 'I did not have any questions', value:'I did not have any questions'),
        //       TextChoice(text: 'Somewhat', value:'Somewhat'),
        //       TextChoice(text: 'No', value:'No'),
        //       TextChoice(text: 'I was not given the opportunity to ask questions',
        //          value: 'I was not given the opportunity to ask questions'),

        //     ],
        //   ),
        // ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, your feedback is valuable to '
              'us',
          title: 'Done!',
          buttonText: 'Complete',
        ),
      ],
    );
    return Future.value(task);
  }
}
