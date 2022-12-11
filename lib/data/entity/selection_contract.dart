import 'package:equatable/equatable.dart';

abstract class  SelectionContract extends Equatable{

  String getName();
  String? getSubtitle();
  String getID();
}