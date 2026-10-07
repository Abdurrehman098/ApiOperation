import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/provider/api_provider.dart';
import 'package:rest_api_practice/screens/detail_screen.dart';
import 'package:rest_api_practice/screens/post_screen.dart';
import 'package:rest_api_practice/screens/put_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      Provider.of<ApiProvider>(context , listen: false).getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context , provider ,child) {
        return Scaffold(

          appBar: AppBar(title: Text("Get Data"),
          centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body:provider.isLoading ? Center(child: CircularProgressIndicator(),) :
              provider.errorMessage.isNotEmpty ? Center(child: Text(provider.errorMessage),)
              :Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.get.length,
                      itemBuilder: (context, index) {
                      final gets = provider.get[index];

                      return InkWell(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(apiModel: gets),));
                        },

                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                gets.id.toString(),
                              ),
                            ),

                            title: Text(
                              gets.title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),

                            subtitle: Text(
                              gets.body,style: TextStyle(overflow: TextOverflow.ellipsis , ),maxLines: 2,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PutScreen(model:gets )));
                                }, icon:Icon(Icons.edit) , color: Colors.green,),
                                IconButton(onPressed:provider.isLoading? null : ()async{
                                  await provider.deleteData(gets.id!); if (!context.mounted) { return; } if (provider.errorMessage.isEmpty) { ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text("Post deleted successfully"), ), ); } },
                                 icon: Icon(Icons.delete) , color: Colors.red,)

                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          )
                        ),

                        onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen() ));
                    }, child:Text("Add Post ")),
                  ),

                ],
              ),


        );
      }
    );
  }
}
