import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MailView extends StatefulWidget {
  const MailView({super.key});

  @override
  State<MailView> createState() => _MailViewState();
}

class _MailViewState extends State<MailView> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          TextField(
            controller: _toController,
            decoration: const InputDecoration(labelText: 'Destinatário'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Assunto'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _bodyController,
            decoration: const InputDecoration(labelText: 'Mensagem'),
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _sendEmail(context),
            child: const Text('Enviar E-mail'),
          ),
        ]),
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _toController.text,
      query: encodeQueryParameters(<String, String>{
        'subject': _titleController.text,
        'body': _bodyController.text,
      }),
    );

    // final Uri emailUri = Uri(
    //   scheme: 'mailto',
    //   path: _toController.text,
    // queryParameters: {
    //   'subject': _titleController.text,
    //   'body': _bodyController.text,
    // },
    // );

    if (await launchUrl(emailLaunchUri)) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o cliente de e-mail')),
      );
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
