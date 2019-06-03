import 'package:flutter/material.dart';
import './ui/home.dart';
void main(){

  runApp(MaterialApp(
    title: "New App",
    home: new Home(category: "",name:"Breaking News"),
  ));
}