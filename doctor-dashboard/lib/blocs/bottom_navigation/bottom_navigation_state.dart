import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
}

class InitialBottomNavigationState extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class ChatPageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class NotesPageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class DoctorPageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class SettingPageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class DiaryCreatePageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}
