import 'dart:math';

import 'package:clm_app/fetch_kmlstring.dart';
import 'package:clm_app/polygons.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class FileController with ChangeNotifier {
  List<Polygon> _polygons = [];
  List<Polygon> get polygons => _polygons;

  Future<List<Polygon>> parseKML(mymapsUrl) async {
    final polylgons = <Polygon>[];

    final kmlData = await fetchKmlString(mymapsUrl);
    final document = XmlDocument.parse(kmlData);
    String _extractColor(style) {
      final lineStyle = style.findElements('LineStyle').first;
      final color = lineStyle.findElements('color').first.text;
      return color;
    }

    for (final placemarkElement in document.findElements('Polygon')) {
      final placemarkName =
          placemarkElement.findElements('name').first.innerText;

      final coordinateElements =
          placemarkElement.findAllElements('coordinates');
      final coordinateString =
          coordinateElements.first.innerText.replaceAll(",0", "").trim();

      final coordinateList = coordinateString.split(' ').toList();
      coordinateList.removeWhere((element) => element.length < 2);

      final coordinates = coordinateList.map((coordinate) {
        final latLngList = coordinate.split(',');
        latLngList.removeWhere((number) => number == "0");
        // debugPrint(latLngList.length.toString());

        final lng = double.tryParse(latLngList[0]);
        final lat = double.tryParse(latLngList[1]);
        return Point(lat!, lng!);
      }).toList();
      final style = placemarkElement.findElements('styleUrl').first;
      final color = _extractColor(style);
      debugPrint(placemarkName);

      polylgons.add(Polygon(placemarkName, color, coordinates));
    }
    _polygons = polylgons;

    return polylgons;
  }
}
