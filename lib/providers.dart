import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tiptop_v2/providers/one_signal_notifications_provider.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider.value(
    value: OneSignalNotificationsProvider(),
  ),
];
