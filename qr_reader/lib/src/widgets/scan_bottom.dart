import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';

class ScanBottom extends StatelessWidget {
  const ScanBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final barcodeScanRes = 'https://www.youtube.com/watch?v=5JDRXIav2pw';
        //final barcodeScanRes = 'geo:16.768969,-3.004933';

        // ignore: unrelated_type_equality_checks
        if (barcodeScanRes == -1) return;

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
