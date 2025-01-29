import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService {
  static const String apiKey = "e0d224ac19be4ba8a0ca30e0e61ccd97";
  static const String baseUrl = "https://api.spoonacular.com/recipes/random";

  Future<List<Recipe>> fetchRecipes({int count = 5}) async {
    final response = await http.get(Uri.parse("$baseUrl?apiKey=$apiKey&number=$count"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Recipe> recipes = (data['recipes'] as List).map((recipe) {
        return Recipe(
          title: recipe['title'],
          description: recipe['summary'],
          imageUrl: recipe['image'],
          ingredients: (recipe['extendedIngredients'] as List)
              .map((ing) => ing['original'].toString())
              .toList(),
          steps: (recipe['analyzedInstructions'].isNotEmpty)
              ? (recipe['analyzedInstructions'][0]['steps'] as List)
                  .map((step) => step['step'].toString())
                  .toList()
              : [],
        );
      }).toList();

      return recipes;
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}
