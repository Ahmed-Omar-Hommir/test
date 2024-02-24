import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'guest_page.dart';

class GuestComposer {
  Widget compose() {
    return Provider(
      create: (context) => '',
      child: GuestScreen(),
    );
  }
}
