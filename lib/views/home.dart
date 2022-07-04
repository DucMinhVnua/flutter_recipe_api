import 'package:flutter/material.dart';
import 'package:recipe_list/models/recipe.dart';
import 'package:recipe_list/models/recipe_api.dart';
import 'package:recipe_list/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu, color: Colors.black),
              SizedBox(
                width: 10,
              ),
              Text('Food Recipes', style: TextStyle(color: Colors.black))
            ],
          )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: ((context, index) => RecipeCard(
                  title:_recipes[index].name,
                  rating: _recipes[index].rating.toString(),
                  cookTime: _recipes[index].totalTime,
                  thumbnailUrl: _recipes[index].images
              )),
            ),
    );
  }
}
