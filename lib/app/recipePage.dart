import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import '../app/recipe.dart';

class RecipePage extends StatelessWidget {
  RecipePage({this.recipe});

  final Recipe recipe;
  //TODO: recipe.ingredients
  final _ingred = generateWordPairs().take(10).toList();

  @override
  Widget build(BuildContext context) {

    Widget titleSection = new Container(
      padding: const EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0, bottom: 22.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    recipe.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
                new Text(
                  recipe.desc,
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    //TODO: Change WordPair to String after DB connected
    Widget _buildIngredientTile(WordPair wp) {
      return new Container(
        margin: const EdgeInsets.all(1.0),
        height: 18.0,
        child: new ListTile(
          title: new Text(
            wp.asString,
            style: new TextStyle(fontSize: 12.0),
          ),
        ),
      );
    }

    Widget ingredientsSection = new Container(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 22.0),
      child: new ExpansionTile( 
        title: new Text("Ingredients"),
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
        initiallyExpanded: true,
        children: _ingred.map(_buildIngredientTile).toList(),
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.only(top: 0.0, left: 32.0, right: 32.0, bottom: 32.0),
      child: new Text(
        recipe.manual,
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );

    Widget recipePage = new ListView(
      children: <Widget>[
        new Hero(
          tag: recipe.tag,
          child: new Image.asset(
            recipe.photo,
            width: 1600.0,
            height: 280.0,
            fit: BoxFit.cover,
          ),
        ),
        
        titleSection,
        ingredientsSection,
        textSection,
      ],
    );

    return recipePage;
  }
}
