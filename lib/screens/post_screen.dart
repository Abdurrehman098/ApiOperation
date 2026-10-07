import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/model/api_model.dart';
import 'package:rest_api_practice/provider/api_provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final globalKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final body = TextEditingController();
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    Text("Add Post" ,textAlign: TextAlign.center , style: TextStyle(color: CupertinoColors.activeGreen , fontWeight: FontWeight.bold , fontSize: 25 ),),
                
                    SizedBox(height: 10,),
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
                        foregroundColor: Colors.white
                      ),
                      onPressed:provider.isLoading ? null :() async {
                        if (globalKey.currentState!.validate()) {
                          final model = ApiModel(
                            title: title.text.trim(),
                            body: body.text.trim(),
                          );
                
                          await provider.postData(model);
                          // print("ERROR: ${provider.errorMessage}");
                
                          if (provider.errorMessage.isEmpty) {
                
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("post added successfully"),
                
                
                              ),
                
                            );
                            title.clear();
                            body.clear();
                          }
                        }
                
                      },
                      child:provider.isLoading ? CircularProgressIndicator(color: Colors.white,) :  Text("Post Data"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
