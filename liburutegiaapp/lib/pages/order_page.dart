import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:liburutegiaapp/helpers/colors.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                              decoration:
                                  const InputDecoration(labelText: 'Izena'),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi izena mesedez';
                                }
                              },
                              onSaved: (val) => setState(() {})),
                          TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Abizena'),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi abizena mesedez';
                                }
                              },
                              onSaved: (val) => setState(() {})),
                          TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Helbidea',
                                suffixIcon: ClipOval(
                                    child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.location_on),
                                  ),
                                )),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Idatzi helbidea mesedez';
                                }
                              },
                              onSaved: (val) => setState(() {})),
                          Row(children: [
                            Expanded(
                                child: DateTimePicker(
                                  type: DateTimePickerType.dateTimeSeparate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 30)),
                                  dateLabelText: "Data eta Ordua",
                                  dateMask: 'yyyy, MMM d',
                                  selectableDayPredicate: (date) {
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }
                                    return true;
                                  },
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                                flex: 1),
                          ]),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      //_user.save();
                                      //_showDialog(context);
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              themeMain)),
                                  child: const Text('Eskatu'))),
                        ])))));
  }
}
