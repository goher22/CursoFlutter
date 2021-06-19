import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(ScanModel scan, BuildContext context) async {
  String _url = scan.valor;
  if (scan.tipo == 'http') {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
