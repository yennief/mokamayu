import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mokamayu/constants/constants.dart';
import 'package:mokamayu/widgets/widgets.dart';

class ClothesForm extends StatefulWidget {
  final File? photo;

  const ClothesForm({Key? key, required this.photo}) : super(key: key);

  @override
  _ClothesFormState createState() => _ClothesFormState();
}

class _ClothesFormState extends State<ClothesForm> {
  String? _type = "";
  String? _size = "";
  String? _name = "";
  List<String>? _TagManager = [];

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      onSaved: (value) => _name = value!,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        if (value.length > 20) {
                          return 'Maximum lenght is 20 characters';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 26,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter your clothes name',
                        labelStyle: TextStylesManager.h4(),
                        focusedBorder: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            bottom: 0, top: 11, right: 15),
                      )),
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("Type",
                              style: TextStylesManager
                                  .paragraphRegularSemiBold18()))),
                  DropdownMenuFormField(
                      list: TagManager.types,
                      onSaved: (value) => _type = value!,
                      validator: (value) {
                        if (value == "Type") {
                          return 'Przypau';
                        }
                        return null;
                      },
                      initialValue: TagManager.types[0]),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: Text("Size",
                              style: TextStylesManager
                                  .paragraphRegularSemiBold18()))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: ChoiceChipsFormField(
                        autoValidate: true,
                        validator: (value) {
                          if (value == "") {
                            return 'Wybrano M';
                          }
                          return null;
                        },
                        onSaved: (value) => _size = value!,
                        chipsList: const ["XS", "S", "M", "L", "XL", "XXL"],
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: Text("Style",
                              style: TextStylesManager
                                  .paragraphRegularSemiBold18()))),
                  FilterChipsFormField(
                      chipsList: const ["XS", "S", "M", "L", "XL", "XXL"],
                      onSaved: (value) => _TagManager = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          print("styles = []");
                          return "null";
                        }
                      }),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        print("Valid$_type$_size$_name$_TagManager");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Valid')),
                        );
                      } else {
                        _formKey.currentState!.save();
                        print("NotValid$_type$_size$_name$_TagManager");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Not Valid')));
                      }
                    },
                    child: const Text('Add clothes'),
                  ),
                ]))));
  }
}
