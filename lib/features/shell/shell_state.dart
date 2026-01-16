import 'package:equatable/equatable.dart';

class ShellState extends Equatable {
  final int index;

  const ShellState({this.index = 0});

  ShellState copyWith({int? index}) {
    return ShellState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
