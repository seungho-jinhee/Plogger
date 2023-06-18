import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    List<Widget> getText() {
      return [
        Text(
          'JUN 2023',
          style: tt.bodyLarge,
        ),
        Text(
          '1 Plogging, 3 Picked Up',
          style: tt.bodySmall,
        ),
      ];
    }

    Widget buildCard() {
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
                      Text('2023. 06. 17.', style: tt.titleMedium),
                      const SizedBox(height: 4),
                      Text('Saturday Morning Run', style: tt.bodyMedium),
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
                      Text('2.35', style: tt.titleSmall),
                      Text('Km', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('12\'18\'\'', style: tt.titleSmall),
                      Text('Average Pace', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('28:54', style: tt.titleSmall),
                      Text('Time', style: tt.bodySmall),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('10', style: tt.titleSmall),
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

    List<Widget> getMonthlyActivity() {
      return List.generate(
        3,
        (index) => Column(
          children: [
            SizedBox(height: index == 0 ? 0 : 8),
            buildCard(),
            SizedBox(height: index == 3 - 1 ? 0 : 8),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              10,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: index == 0 ? 0 : 8),
                  ...getText(),
                  const SizedBox(height: 16),
                  ...getMonthlyActivity(),
                  SizedBox(height: index == 10 - 1 ? 0 : 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
