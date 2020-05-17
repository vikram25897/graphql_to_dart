import 'dart:io';

class FileConstants{
  FileConstants._();
  static FileConstants _instance = FileConstants._();
  factory FileConstants() => _instance;

//  File queriesFile;
//  File mutationsFile;
//  File subscriptionsFile;
  Directory modelsDirectory;
}