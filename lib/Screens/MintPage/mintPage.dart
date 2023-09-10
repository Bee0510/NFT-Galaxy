// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftgallery/Components/AppBar.dart';
import 'package:nftgallery/NFT/API/getContracts.dart';
import 'package:nftgallery/NFT/API/mint.dart';

import '../ContractDeployPage/deploy.dart';

class mintPage extends StatefulWidget {
  const mintPage({super.key});

  @override
  State<mintPage> createState() => _mintPageState();
}

class _mintPageState extends State<mintPage> {
  final _formkey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _cntownadress =
      TextEditingController(text: '0x011f77017E0E02739489C629f7473671DFdF2464');
  TextEditingController _cntadress = TextEditingController();
  TextEditingController _quan = TextEditingController(text: '0');
  final String walletad = '0x011f77017E0E02739489C629f7473671DFdF2464';
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;

  pickImage(ImageSource source) async {
    XFile? xFileImage = await picker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        image = File(xFileImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 21, 21, 100),
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: image != null
                            ? Image.file(image!)
                            : Text(
                                'No Image Selected',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () => pickImage(ImageSource.gallery),
                              child: Text('Pick from gallery')),
                          ElevatedButton(
                              onPressed: () => pickImage(ImageSource.camera),
                              child: Text('Pick from camera')),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => value!.isEmpty ? 'No name?' : null,
                      style: TextStyle(color: Colors.white),
                      controller: _name,
                      decoration: InputDecoration(
                          labelText: 'Name of NFT',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: border2(),
                          enabledBorder: border2(),
                          errorBorder: border2()),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Description time' : null,
                      style: TextStyle(color: Colors.white),
                      controller: _description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: border2(),
                        enabledBorder: border2(),
                        errorBorder: border2(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your contract address' : null,
                      style: TextStyle(color: Colors.white),
                      controller: _cntadress,
                      decoration: InputDecoration(
                        labelText: 'Contract address',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: border2(),
                        enabledBorder: border2(),
                        errorBorder: border2(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _quan,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: border2(),
                        enabledBorder: border2(),
                        errorBorder: border2(),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownMenu<IconLabel>(
                      controller: iconController,
                      enableFilter: true,
                      leadingIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Chain',
                        style: TextStyle(color: Colors.grey),
                      ),
                      textStyle: TextStyle(color: Colors.white),
                      dropdownMenuEntries: iconEntries,
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1)),
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            if (image != null) {
                              mintNFT(
                                  image!.path,
                                  _name.text,
                                  _description.text,
                                  iconController.text,
                                  _cntadress.text,
                                  walletad,
                                  _quan.text);
                            } else {
                              Text('No image yet');
                            }
                          }
                        },
                        child: Text('Mint NFT'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder border2() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white, width: 1));
  }
}
