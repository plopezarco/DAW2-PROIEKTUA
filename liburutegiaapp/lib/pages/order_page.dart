import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:liburutegiaapp/helpers/api_service.dart';
import 'package:liburutegiaapp/helpers/colors.dart';
import 'package:intl/intl.dart';
import 'package:liburutegiaapp/models/eskaera.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;
import 'package:liburutegiaapp/models/liburua.dart';
import 'package:liburutegiaapp/pages/pages.dart';
import 'package:location/location.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  String? izena, abizena, helbidea;
  DateTime? itzuli;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  ApiService api = ApiService();
  bool apiCall = false;
  TextEditingController txt = TextEditingController();
  bool findingLocation = false;

  @override
  Widget build(BuildContext context) {
    itzuli = DateTime.now().add(const Duration(days: 15));
    return Scaffold(
        appBar:
            AppBar(title: const Text('Eskaera'), backgroundColor: themeMain),
        resizeToAvoidBottomInset: false,
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                              enabled: !apiCall,
                              maxLength: 45,
                              decoration: const InputDecoration(
                                  labelText: 'Izena', counterText: ''),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi izena mesedez';
                                }
                                return null;
                              },
                              onSaved: (val) => setState(() {
                                    izena = val;
                                  })),
                          TextFormField(
                              enabled: !apiCall,
                              maxLength: 45,
                              decoration: const InputDecoration(
                                  labelText: 'Abizena', counterText: ''),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi abizena mesedez';
                                }
                                return null;
                              },
                              onSaved: (val) => setState(() {
                                    abizena = val;
                                  })),
                          TextFormField(
                              controller: txt,
                              enabled: !apiCall,
                              decoration: InputDecoration(
                                labelText: 'Helbidea',
                                suffixIcon: ClipOval(
                                    child: Material(
                                  color: Colors.transparent,
                                  child: findingLocation
                                      ? const CircularProgressIndicator()
                                      : IconButton(
                                          onPressed: !apiCall
                                              ? () {
                                                  setState(() {
                                                    findingLocation = true;
                                                  });
                                                  getAddress().then(
                                                      (value) => setState(() {
                                                            if (value != null) {
                                                              txt.text = value;
                                                            }
                                                            findingLocation =
                                                                false;
                                                          }));
                                                }
                                              : null,
                                          icon: const Icon(Icons.location_on),
                                        ),
                                )),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi helbidea mesedez';
                                }
                                return null;
                              },
                              onSaved: (val) => setState(() {
                                    helbidea = val;
                                  })),
                          const SizedBox(
                            height: 30,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Gaur eskatuta ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: dateFormat.format(itzuli ??
                                        DateTime.now()
                                            .add(const Duration(days: 15))),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const TextSpan(
                                    text: "-rako itzuli beharko duzu"),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: !apiCall
                                ? ElevatedButton(
                                    onPressed: () {
                                      final form = _formKey.currentState;
                                      if (form!.validate()) {
                                        form.save();
                                        eskatu();
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                themeMain)),
                                    child: const Text('Eskatu'))
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                        ])))));
  }

  eskatu() async {
    setState(() {
      apiCall = true;
    });
    List<int> idLiburuak = <int>[];
    for (Liburua l in globals.cart) {
      idLiburuak.add(l.idLiburua);
    }
    Eskaera eskaera =
        Eskaera(DateTime.now(), itzuli!, izena!, abizena!, helbidea!);
    eskaera.idLiburuak = idLiburuak;
    bool bukatuta = await api.eskatu(eskaera);
    if (bukatuta) {
      globals.cart.clear();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
                title: const Text("Eskerrik asko!"),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                content: Text("Zure eskaera gorde egin da. Gogoratu " +
                    dateFormat.format(itzuli!) +
                    " baino lehen itzuli behar duzula."),
                contentTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text('Ok'),
                  ),
                ]),
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
                title: const Text('Errorea'),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                content: const Text("Errore bat gertatu da, saiatu berriz"),
                contentTextStyle: const TextStyle(color: Colors.black),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ]),
          );
        },
      );
    }
    setState(() {
      apiCall = false;
    });
  }

  Future<String?> getAddress() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    if (_locationData.latitude != null && _locationData.longitude != null) {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              _locationData.latitude!, _locationData.longitude!);
      geocoding.Placemark place1 = placemarks.first;
      return place1.street! +
          " " +
          place1.name! +
          ", " +
          place1.postalCode! +
          " " +
          place1.locality!;
    }

    return null;
  }
}
