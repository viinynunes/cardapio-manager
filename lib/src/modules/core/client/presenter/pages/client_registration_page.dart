import 'package:cardapio_manager/src/modules/core/client/infra/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:string_validator/string_validator.dart';

import '../../domain/entities/client.dart';

class ClientRegistrationPage extends StatefulWidget {
  const ClientRegistrationPage({Key? key, this.client}) : super(key: key);

  final Client? client;

  @override
  State<ClientRegistrationPage> createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocus = FocusNode();

  late Client newClient;

  @override
  void initState() {
    super.initState();

    nameFocus.requestFocus();

    if (widget.client != null) {
      newClient = ClientModel.fromClient(widget.client!);
      nameController.text = widget.client!.name;
      emailController.text = widget.client!.email;
      phoneController.text = widget.client!.phone;
    }
  }

  _initNewClient() {
    newClient = Client(
        id: widget.client == null ? '' : widget.client!.id,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.client == null ? 'Novo Cliente' : nameController.text,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nameController.text = '';
                emailController.text = '';
                phoneController.text = '';
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _initNewClient();
            Modular.to.pop(newClient);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    focusNode: nameFocus,
                    decoration: InputDecoration(
                        hintText: 'Nome',
                        label: const Text('Nome'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textInputAction: TextInputAction.next,
                    validator: (name) {
                      if (name!.length < 2) {
                        return 'Nome inválido';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        label: const Text('Email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (!isEmail(email!)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        hintText: 'Telefone',
                        label: const Text('Telefone'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    validator: (phone) {
                      if (phone!.length != 11) {
                        return 'Telefone inválido';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
