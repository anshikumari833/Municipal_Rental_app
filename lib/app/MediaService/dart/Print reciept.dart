import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../../common/function.dart';


class PrintReceipt extends StatefulWidget {
  const PrintReceipt({Key? key}) : super(key: key);

  @override
  State<PrintReceipt> createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  List<String> _options = ["permission bluetooth granted", "bluetooth enabled", "connection status", "update info"];

  String tmpStr = '';
  String tmpStrSecondLine = '';
  String tmpStrThirdLine = '';
  String _selectSize = "2";
  final _txtText = TextEditingController(text: '');
  bool _connceting = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          actions: [
            PopupMenuButton(
              elevation: 3.2,
              //initialValue: _options[1],
              onCanceled: () {
                print('You have not chossed anything');
              },
              tooltip: 'Menu',
              onSelected: (Object select) async {
                String sel = select as String;
                print("selected: $sel");
                if (sel == "permission bluetooth granted") {
                  bool status = await PrintBluetoothThermal.isPermissionBluetoothGranted;
                  setState(() {
                    _info = "permission bluetooth granted: $status";
                  });
                } else if (sel == "bluetooth enabled") {
                  bool state = await PrintBluetoothThermal.bluetoothEnabled;
                  setState(() {
                    _info = "Bluetooth enabled: $state";
                  });
                } else if (sel == "update info") {
                  initPlatformState();
                } else if (sel == "connection status") {
                  final bool result = await PrintBluetoothThermal.connectionStatus;
                  setState(() {
                    _info = "connection status: $result";
                  });
                }
              },
              itemBuilder: (BuildContext context) {
                return _options.map((String option) {
                  return PopupMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('info: $_info\n '),
                Text(_msj),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        this.getBluetoots();
                      },
                      child: Row(
                        children: [
                          Visibility(
                            visible: _connceting,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(strokeWidth: 1, backgroundColor: Colors.white),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(_connceting ? "Connecting" : "Search"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: connected ? this.disconnect : null,
                      child: Text("Disconnect"),
                    ),
                    ElevatedButton(
                      onPressed: connected ? this.printTest : null,
                      child: Text("Test"),
                    ),
                  ],
                ), // Bluetooth option buttons
                Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: ListView.builder(
                      itemCount: items.length > 0 ? items.length : 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            String mac = items[index].macAdress;
                            bool flag = await(CommonUtils.setPrinter(mac));
                            this.connect();
                          },
                          title: Text('Name: ${items[index].name}'),
                          subtitle: Text("macAdress: ${items[index].macAdress}"),
                        );
                      },
                    )), //List of BlueTooth Devides
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Column(children: [
                    Text("Following text will be printed, Check before Print"),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300.0,
                      ),
                      child: TextField(
                        maxLines: null,
                        controller: _txtText,
                        enabled: false, // Add this line to disable editing
                      ),
                    ),

                    ElevatedButton(
                      onPressed: connected ? this.printReceipt : null,
                      // onPressed: connected ? this.testTicket : null,
                      child: Text("Print"),
                    ),
                  ]),
                ), // Printable Text
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    //print("bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
    } else {
      _msj = "Bluetooth not enabled";
    }

    setState(() {
      _info = platformVersion + " ($porcentbatery% battery)";
    });

    // var data = Get.arguments; //in the destination
    String tmpStr1 = '';
    String tmpStr2 = "";
    String tmpStr3 = "";
    dynamic argumentData = Get.arguments;
    tmpStr1 = argumentData[0]['print_string1'];
    tmpStr2 = argumentData[1]['print_string2'];
    tmpStr3 = argumentData[2]['print_string3'];



    if (tmpStr1.length > 0){
      setState(() {
        tmpStr = tmpStr1;
        tmpStrSecondLine = tmpStr2;
        tmpStrThirdLine = tmpStr3;
        _txtText.text = tmpStr;
      });
    }


    if (await CommonUtils.getPrinterConnected()){
      setState(() {
        connected = true;
      });
    }
  }

  Future<void> getBluetoots() async {
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    if (listResult.length == 0) {
      _msj = "There are no bluetooths linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect() async {
    setState(() {
      _connceting = true;
    });
    final String printerName = await CommonUtils.getPrinter();
    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: printerName);
    print("state conected $result");
    if (result) connected = true;
    if (result) {
      CommonUtils.setPrinterConnected();
    }
    setState(() {
      _connceting = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printTest() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      List<int> ticket = await testTicket();
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("impresion $result");
    } else {
      //no conectado, reconecte
    }
  }

  Future<void> printString() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      String enter = '\n';
      await PrintBluetoothThermal.writeBytes(enter.codeUnits);
      //size of 1-5
      String text = "Hello";
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 1, text: text));
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 2, text: text + " size 2"));
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 3, text: text + " size 3"));
    } else {
      //desconectado
      print("Disconnected bluetooth $conexionStatus");
    }
  }

  Future<List<int>> printReceipt() async {
    //tmpStr
    List<int> bytes = [];
    List<int> bytes1 = [];

    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();
    bytes += generator.qrcode('example.com');
    bytes += generator.text(
      // '    ****JHARKHAND****',
      'Ranchi Municipal Corporation',
      styles: PosStyles(
        fontType: PosFontType.fontB,
        bold: true,
      ),
    );
    // bytes += generator.text('***** JUIDCO *****', styles: PosStyles(bold: true));
    bytes += generator.text('           Citizen Copy', styles: PosStyles(bold: true));
    // bytes += generator.feed(2);
    // bytes += generator.text(" ", styles: PosStyles(bold: true));
    // bytes += generator.text("   RANCHI", styles: PosStyles(bold: true));
    bytes += generator.text("           Payment Receipt", styles: PosStyles(bold: true));
    // bytes += generator.text("........................................", styles: PosStyles(bold: true));
    bytes += generator.text(tmpStr, styles: PosStyles(bold: true));

    // bytes += generator.text("........................................", styles: PosStyles(bold: true));
    // bytes += generator.text(tmpStrSecondLine, styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    bytes += generator.text(tmpStrSecondLine, styles: PosStyles(bold: true));
    bytes += generator.text(tmpStrThirdLine, styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    bytes += generator.text("", styles: PosStyles(bold: true));
    await PrintBluetoothThermal.writeBytes(bytes);
    return bytes;
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();
    bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ', styles: PosStyles());
    bytes += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ', styles: PosStyles(codeTable: 'CP1252'));
    bytes += generator.text(
      'Special 2: blåbærgrød',
      styles: PosStyles(codeTable: 'CP1252'),
    );

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    //barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    //QR code
    bytes += generator.qrcode('example.com');

    bytes += generator.text(
      'Text size 50%',
      styles: PosStyles(
        fontType: PosFontType.fontB,
      ),
    );
    bytes += generator.text(
      'Text size 100%',
      styles: PosStyles(
        fontType: PosFontType.fontA,
      ),
    );
    bytes += generator.text(
      'Text size 200%',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.feed(2);
    //bytes += generator.cut();
    await PrintBluetoothThermal.writeBytes(bytes);
    return bytes;
  }

  Future<void> printWithoutPackage() async {
    //impresion sin paquete solo de PrintBluetoothTermal
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      String text = _txtText.text.toString() + "\n";
      bool result = await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: int.parse(_selectSize), text: text));
      print("status print result: $result");
      setState(() {
        _msj = "printed status: $result";
      });
    } else {
      //no conectado, reconecte
      setState(() {
        _msj = "no connected device";
      });
      print("no conectado");
    }
  }


}
