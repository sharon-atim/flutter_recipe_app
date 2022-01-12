import 'package:flutter/material.dart';

import 'recipe.dart';
import 'recipe_detail.dart';

// Main is the entry point for the code when the app launches.
void main() {
  // RecipeApp is the top level widget for the app.
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Recipe Calculator',
      // Replaces the default Material ThemeData with new values.
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.teal,
          secondary: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // SafeArea keeps the app from getting too close to the OS interfaces.
      body: SafeArea(
        // Builds a list.
        child: ListView.builder(
          // The number of rows is the length of the Recipe.samples list.
          itemCount: Recipe.samples.length,
          // Builds a widget tree for each row.
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Navigator widget manages a stack of pages.
                Navigator.push(
                  // Pushes a new Material page onto the stack.
                  context,
                  MaterialPageRoute(
                    // Creates the destination page widget.
                    builder: (context) {
                      return RecipeDetail(recipe: Recipe.samples[index]);
                    },
                  ),
                );
              },

              /// Instructs the itemBuilder to use the custom Card widget,
              /// for each recipe in the samples list.
              // Where the gesture is active.
              child: buildRecipeCard(Recipe.samples[index]),
            );
            // A text widget displays the name of the recipe.
          },
        ),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    // Returns a Card.
    // The Card's child properties are - Padding, Column and Text.
    return Card(
      /// Elevation determines how high off the screen the card is,
      /// affecting its shadow.
      elevation: 2.0,

      /// Shape defines the shape of the card and adds a rounded rectangle,
      /// with a 10.0 corner radius.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        // Padding insets its child's contents by the specified padding value.
        padding: const EdgeInsets.all(16.0),
        // Column has 3 children, Image, SizedBox and Text.
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(recipe.imageUrl)),
            // SizedBox goes inbetween the image and text.
            const SizedBox(
              height: 14.0,
            ),
            Text(
              recipe.label,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
