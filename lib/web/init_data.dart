
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/')
abstract class InitData{

  @GET("/tasks")
  Future<List<Task>> getTasks();
}

class Task{
  String? id;
  String? name;
  String? avatar;
  String? createdAt;

  Task({this.id, this.name, this.avatar, this.createdAt});

}