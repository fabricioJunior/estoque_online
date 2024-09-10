import 'package:barcode/barcode.dart';

const double inch = 72.0;
const double cm = inch / 2.54;
const double mm = inch / 25.4;

class CodeBarService {
  Future<String> generateCodeBar(String codigoDeBarras) async {
    final dm = Barcode.codabar();

    return dm.toSvg(codigoDeBarras, x: mm * 50, y: mm * 30);
  }
}
