// ignore_for_file: prefer_const_constructors, prefer_final_fields, camel_case_types, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftgallery/NFT/API/deployContracts.dart';
import '../../Components/AppBar.dart';

class deploy extends StatefulWidget {
  const deploy({super.key});

  @override
  State<deploy> createState() => _deployState();
}

class _deployState extends State<deploy> {
  final _formkey = GlobalKey<FormState>();
  String contractAddress = '';
  TextEditingController _cntname = TextEditingController();
  TextEditingController _cntsymname = TextEditingController();
  TextEditingController _cntownadress =
      TextEditingController(text: '0x011f77017E0E02739489C629f7473671DFdF2464');
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }
    Future<void> _copyToClipboard() async {
      await Clipboard.setData(ClipboardData(text: contractAddress));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Copied to clipboard'),
      ));
    }

    void getData() async {
      try {
        final response = await deployNFTContract(_cntname.text,
            _cntsymname.text, iconController.text, _cntownadress.text);
        setState(() {
          contractAddress = response ?? '';
          _isloading = false;
        });
        print('Contract : $contractAddress');
        if (contractAddress.isNotEmpty) {
          // Show a dialog with the contract address
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Contract Deployed Successfully',
                    style: TextStyle(color: Colors.green)),
                content: Text('Contract Address: $contractAddress'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Copy to Clipboard'),
                    onPressed: () {
                      _copyToClipboard();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          contractAddress = '';
        });
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 21, 21, 100),
      appBar: appBar(),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your contract name' : null,
                  style: TextStyle(color: Colors.white),
                  controller: _cntname,
                  decoration: InputDecoration(
                      labelText: 'Contract name',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: border2(),
                      enabledBorder: border2(),
                      errorBorder: border2()),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your contract symbol' : null,
                  style: TextStyle(color: Colors.white),
                  controller: _cntsymname,
                  decoration: InputDecoration(
                      labelText: 'Contract symbol',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: border2(),
                      enabledBorder: border2(),
                      errorBorder: border2()),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your owner address' : null,
                  style: TextStyle(color: Colors.white),
                  controller: _cntownadress,
                  decoration: InputDecoration(
                      labelText: 'Owner address',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: border2(),
                      enabledBorder: border2(),
                      errorBorder: border2()),
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
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
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
                        setState(() {
                          _isloading = true;
                        });
                        getData();
                      }
                    },
                    child: Text(
                      'Deploy',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                SizedBox(height: 30),
                Container(
                  child: Column(
                    children: [
                      Text(
                        contractAddress == ''
                            ? ''
                            : 'Deployed Contaract Address',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 300,
                        child: Text(
                          contractAddress == '' ? '' : contractAddress,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _copyToClipboard();
                          },
                          icon: Icon(
                            Icons.copy,
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
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

enum IconLabel {
  smile('goerli', Icons.sentiment_satisfied_outlined),
  cloud(
    'fuji',
    Icons.cloud_outlined,
  ),
  brush('ethereum', Icons.brush_outlined),
  heart('polygon', Icons.favorite),
  mumbai('mumbai', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
