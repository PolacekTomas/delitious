import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'recipe.dart';
import 'recipePage.dart';

class GridRecipeViewer extends StatefulWidget {
  const GridRecipeViewer(this.type);

  final String type;

  @override
  _GridRecipeViewerState createState() => new _GridRecipeViewerState(type);
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: new Text(text),
    );
  }
}

class GridRecipeItem extends StatelessWidget {
  GridRecipeItem({
    @required this.recipe,
  }) : assert(recipe != null);

  final Recipe recipe;

  void showRecipe(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              recipe.name,
              style: new TextStyle(color: Colors.white,),
            ),
          ),
          body: new SizedBox.expand(
            child: new RecipePage(
              recipe: recipe,
            ),
          ),
        );
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = new GestureDetector(
      onTap: () { showRecipe(context); },
      child: new Hero(
        tag: recipe.tag,
        child: new Image.asset(
          recipe.photo,
          fit: BoxFit.cover,
        ),
      ),
    );

    return new GridTile(
      footer: new GestureDetector(
        child: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new _GridTitleText(recipe.name),
          subtitle: new _GridTitleText(recipe.desc),
        ),
      ),
      child: image,
    );
  }
}

class _GridRecipeViewerState extends State<GridRecipeViewer> {
  _GridRecipeViewerState(this.type);

  final String type;
  DatabaseReference ref;
  List<Recipe> recipes = <Recipe>[];

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.reference().child("recipes/$type");
    ref.onChildAdded.listen(
        (event) {
          recipes.add(new Recipe.fromSnapshot(event.snapshot));
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    final Orientation orientation = MediaQuery.of(context).orientation;

    return new Column(
      children: <Widget>[
        new Expanded(
          child: new SafeArea(
            top: false,
            bottom: false,
            child: new FutureBuilder(
              future: ref.once(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return new Center(child: new CircularProgressIndicator(),);
                return GridView.count(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                  children: recipes.map((Recipe recipe) {
                    return new GridRecipeItem(
                    recipe: recipe,
                  );
                  }).toList()
                );
              },
            ),
          ),
        )
      ],
    );
  }

}