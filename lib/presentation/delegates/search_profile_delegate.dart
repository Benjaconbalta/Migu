import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:migu/domain/entities/Tutor.dart';

class SearchProfileDelegate extends SearchDelegate<Tutor?> {
  @override
  String get searchFieldLabel => "Buscar Perfil";

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
    
      FadeIn(
        animate: query.isNotEmpty,
        duration: Duration(milliseconds: 100),
        child: IconButton(
          
            onPressed: () => query="",
            icon:const Icon(Icons.clear)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          return close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("resultos");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text("sugerencias");
  }
}
