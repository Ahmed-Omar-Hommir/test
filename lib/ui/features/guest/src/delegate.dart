import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class GuestDelegate {
  void onTapSignIn(int id);
  void onTapSignUp();
}

extension DelegateEx on BuildContext {
  get delegate => read<GuestDelegate>();
}
