import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PloggingView extends StatelessWidget {
  const PloggingView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daejeon, South Korea', style: tt.bodyLarge),
          Text(
            'Korea Advanced Institute of Science and Technology E3-1',
            style: tt.bodySmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<Position>(
              future: Future(() => Geolocator.getCurrentPosition()),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            snapshot.data!.latitude,
                            snapshot.data!.longitude,
                          ),
                          zoom: 17,
                        ),
                      )
                    // ? Container(
                    //     decoration: BoxDecoration(
                    //       color: cs.primaryContainer,
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(16),
                    //       ),
                    //     ),
                    //   )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
