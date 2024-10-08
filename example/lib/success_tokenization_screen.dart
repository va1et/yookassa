import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yookassa_payments_flutter/input_data/saved_card_module_input_data.dart';
import 'package:yookassa_payments_flutter/yookassa_payments_flutter.dart';

class SuccessTokenizationScreen extends StatefulWidget {
  const SuccessTokenizationScreen(
      {Key? key, required this.result, this.tokenizationData, this.repeatData})
      : super(key: key);

  final SuccessTokenizationResult result;
  final TokenizationModuleInputData? tokenizationData;
  final SavedBankCardModuleInputData? repeatData;

  @override
  State<StatefulWidget> createState() => _SuccessTokenizationScreenState();
}

class _SuccessTokenizationScreenState extends State<SuccessTokenizationScreen> {
  late SuccessTokenizationResult result;
  late TokenizationModuleInputData? tokenizationData;
  late SavedBankCardModuleInputData? repeatData;

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
    result = widget.result;
    tokenizationData = widget.tokenizationData;
    repeatData = widget.repeatData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Example App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ListTile(
            leading: Icon(Icons.done, color: Colors.green),
            title: Text("Токен готов"),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              decoration:
                  const InputDecoration(hintText: "3ds / App2App ссылка"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var shopId = "<Идентификатор магазина в ЮKassa>";
                var clientApplicationKey = "<Ключ для клиентских приложений>";
                await YookassaPaymentsFlutter.confirmation(
                    controller.text,
                    result.paymentMethodType,
                    clientApplicationKey,
                    shopId
                );
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          content: Text("Confirmation process is done"),
                        ));
              },
              child: const Text("Подтвердить")),
          TextButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: Text(result.token),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: result.token));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Скопировать'),
                              ),
                            ]));
              },
              child: const Text("Показать токен"))
        ],
      ),
    );
  }
}
