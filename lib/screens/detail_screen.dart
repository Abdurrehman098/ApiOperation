import 'package:flutter/material.dart';
import 'package:rest_api_practice/model/api_model.dart';

class DetailScreen extends StatelessWidget {
  final ApiModel apiModel;
  const DetailScreen({super.key , required this.apiModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Detail Screen"),centerTitle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(


          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(child: Text(apiModel.id.toString())),

                    SizedBox(width: 5,),
                    Expanded(child: Text(apiModel.title ,style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                ),

                Divider(color: Colors.grey.shade300,
                thickness: 1,),

                Text("Description", style: TextStyle(color: Colors.blue ,fontWeight: FontWeight.w600),),
                Text(apiModel.body),
              ],
            ),
          ),
        ),
      ),



    );
  }
}
