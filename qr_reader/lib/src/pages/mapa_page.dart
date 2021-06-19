import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapType maptype = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getlatLng(),
      zoom: 17,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(
        Marker(markerId: MarkerId('geo-location'), position: scan.getlatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Corredenadas'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: scan.getlatLng(), zoom: 17)));
            },
            icon: Icon(Icons.location_disabled),
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: maptype,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (maptype == MapType.normal) {
            maptype = MapType.satellite;
          } else {
            maptype = MapType.normal;
          }

          setState(() {});
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
