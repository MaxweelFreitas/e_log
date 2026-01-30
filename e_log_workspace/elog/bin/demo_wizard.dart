// import 'package:elog/src/wizard/e_wizard.dart';
// import 'package:elog/src/wizard/steps/info_steps.dart';
// import 'package:elog/src/wizard/style/e_wizard_presets.dart'; // <--- Importe os presets
// import 'package:elog/src/wizard/steps/text_step.dart';
// import 'package:elog/src/wizard/steps/select_step.dart';

// void main() {
//   // Escolha seu preset aqui:
//   // - EWizardPresets.classic
//   // - EWizardPresets.modern
//   // - EWizardPresets.retro
//   // - EWizardPresets.minimal
//   // - EWizardPresets.ubuntu
//   // - EWizardPresets.fire

//   final myStyle = EWizardPresets.ubuntu;

//   final wizard = EWizard(
//     title: 'NEW PROJECT TEST SETUP',
//     message: 'Let\'s configure your application.',
//     endingMessage: 'YOU ARE READY!',
//     style: myStyle,
//     steps: [
//       TextStep(id: 'name', title: 'Application Name'),
//       SelectStep(
//           id: 'type',
//           title: 'Project Type',
//           options: ['Mobile', 'Web', 'Desktop']),
//       InfoStep(
//           id: 'done',
//           title: 'Finish',
//           description: 'Press Enter to generate files...')
//     ],
//     width: 70,
//   );

//   wizard.run();
// }
