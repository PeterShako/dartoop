
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

   void main() {
  runApp(MyApp());}

 abstract class Printable {
  void printInfo();}
  class Animal {
  String name;

  Animal(this.name);

  void makeSound() {
    print('$name makes a sound');
  }
 }
  class Dog extends Animal implements Printable {
  String breed;
  Dog(String name, this.breed) : super(name);
    @override
  void makeSound() {
    print('$name barks');
  }
    @override
  void printInfo() {
    print('Name: $name, Breed: $breed');
  }
 }
  class MyApp extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
  return MaterialApp(
 title: 'SHARKO',
 theme: ThemeData(
   primarySwatch: Colors.blue,
   visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
  home: MyHomePage(),
    );
  }}
      class MyHomePage extends StatefulWidget {
     @override
     _MyHomePageState createState() => _MyHomePageState();
 }
    class _MyHomePageState extends State<MyHomePage> {
     List<Dog> dogs = [];
   @override
   void initState() {
    super.initState();
      _readDataFromFile();
  }
    Future<void> _readDataFromFile() async {
      try {
     final file = File('dogs.txt');
   List<String> lines = await file.readAsLines();
    for (var line in lines) {
    var parts = line.split(',');
    if (parts.length == 2) {
     var name = parts[0].trim();
   var breed = parts[1].trim();
   setState(() {
     dogs.add(Dog(name, breed));
          });
        }
      }
    } catch (e) {
      print('Error reading file: $e');
    }
  }
    void printAnimalSounds() {
    for (var dog in dogs) {
      dog.makeSound();
    }
  }
    @override
     Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
   child: Column(
   mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
   for (var dog in dogs) Text('Name: ${dog.name}, Breed: ${dog.breed}'),
  RaisedButton(
   onPressed: () {
  printAnimalSounds();
    },
      child: Text('Make Sounds'),
    ),
  ],
  ),
  ),);
   }}
