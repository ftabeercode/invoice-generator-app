import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() =>
      _CompanyInfoScreenState();
}

class _CompanyInfoScreenState
    extends State<CompanyInfoScreen> {

  final companyNameController =
  TextEditingController();

  final addressController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    final box = Hive.box("company");

    companyNameController.text =
        box.get("name", defaultValue: "");

    addressController.text =
        box.get("address",
            defaultValue: "");

    emailController.text =
        box.get("email",
            defaultValue: "");

    phoneController.text =
        box.get("phone",
            defaultValue: "");
  }

  void saveCompanyInfo() {
    final box = Hive.box("company");

    box.put(
      "name",
      companyNameController.text,
    );

    box.put(
      "address",
      addressController.text,
    );

    box.put(
      "email",
      emailController.text,
    );

    box.put(
      "phone",
      phoneController.text,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Company Information Saved!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Company Information",
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: ListView(
          children: [

            TextField(
              controller:
              companyNameController,
              decoration:
              const InputDecoration(
                labelText:
                "Company Name",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              addressController,
              decoration:
              const InputDecoration(
                labelText:
                "Company Address",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              emailController,
              decoration:
              const InputDecoration(
                labelText:
                "Company Email",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
              phoneController,
              decoration:
              const InputDecoration(
                labelText:
                "Company Phone",
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width:
              double.infinity,
              child:
              ElevatedButton(
                onPressed:
                saveCompanyInfo,
                child:
                const Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}