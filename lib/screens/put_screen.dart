import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/model/api_model.dart';

import '../provider/api_provider.dart';

class PutScreen extends StatefulWidget {
  final ApiModel model;
  const PutScreen({super.key, required this.model});

  @override
  State<PutScreen> createState() => _PutScreenState();
}

class _PutScreenState extends State<PutScreen> {
  final title = TextEditingController();
  final body = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    title.text = widget.model.title;
    body.text = widget.model.body;

    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Post Data"),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update Post",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CupertinoColors.activeGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    validator: provider.titleValidate,
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 5,
                    validator: provider.bodyValidate,
                    controller: body,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            if (globalKey.currentState!.validate()) {
                              final model = ApiModel(
                                id: widget.model.id,
                                userId: widget.model.userId,
                                title: title.text.trim(),
                                body: body.text.trim(),
                              );

                              await provider.putData(model);
                              // print("ERROR: ${provider.errorMessage}");
                              if(!mounted){
                                return;
                              }
                              if (provider.errorMessage.isEmpty) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("data update successfully"),
                                  ),
                                );
                                title.clear();
                                body.clear();
                              }
                              Navigator.pop(context);
                            }
                          },
                    child: provider.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("put Data"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
