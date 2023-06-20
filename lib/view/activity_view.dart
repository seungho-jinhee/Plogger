import 'package:flutter/material.dart';
import 'package:plogger/controller/file_controller.dart';
import 'package:plogger/model/plogging_model.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    List<Widget> getText(List<PloggingModel> ploggingModels) {
      int pickedUp = List.generate(
        ploggingModels.length,
        (index) => ploggingModels[index].pickedUp,
      ).fold(0, (a, b) => a + b);
      return [
        Text('JUN 2023', style: tt.bodyLarge),
        Text(
          '${ploggingModels.length} Plogging, $pickedUp Picked Up',
          style: tt.bodySmall,
        ),
      ];
    }

    Widget buildCard(PloggingModel ploggingModel) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: cs.outline),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ploggingModel.datetime.substring(0, 10),
                        style: tt.titleMedium,
                      ),
                      Text('Tuesday Evening Plogging', style: tt.bodyMedium),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ploggingModel.km.toStringAsFixed(2),
                        style: tt.titleSmall,
                      ),
                      Text('Km', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ploggingModel.averagePace ~/ 60}\'${ploggingModel.averagePace % 60}\'\'',
                        style: tt.titleSmall,
                      ),
                      Text('Average Pace', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ploggingModel.time ~/ 60}:${ploggingModel.time % 60}',
                        style: tt.titleSmall,
                      ),
                      Text('Time', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ploggingModel.pickedUp}',
                        style: tt.titleSmall,
                      ),
                      Text('Picked Up', style: tt.bodySmall),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    // List<Widget> getMonthlyActivity() {
    //   return List.generate(
    //     3,
    //     (index) => Column(
    //       children: [
    //         SizedBox(height: index == 0 ? 0 : 8),
    //         buildCard(),
    //         SizedBox(height: index == 3 - 1 ? 0 : 8),
    //       ],
    //     ),
    //   );
    // }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: Future(() => FileController.fileReadAsString()),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<PloggingModel> ploggingModels = PloggingModel.fromSTR(
                  snapshot.data!,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getText(ploggingModels),
                    const SizedBox(height: 16),
                    ...List.generate(
                      ploggingModels.length,
                      (index) {
                        return Column(
                          children: [
                            SizedBox(height: index == 0 ? 0 : 8),
                            buildCard(ploggingModels[index]),
                            SizedBox(
                              height:
                                  index == ploggingModels.length - 1 ? 0 : 8,
                            ),
                          ],
                        );
                      },
                    ).reversed,
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: List.generate(
          //     10,
          //     (index) => Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         SizedBox(height: index == 0 ? 0 : 8),
          //         ...getText(),
          //         const SizedBox(height: 16),
          //         ...getMonthlyActivity(),
          //         SizedBox(height: index == 10 - 1 ? 0 : 8),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
