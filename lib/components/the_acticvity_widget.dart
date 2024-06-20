import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'the_acticvity_model.dart';
export 'the_acticvity_model.dart';

class TheActicvityWidget extends StatefulWidget {
  const TheActicvityWidget({
    super.key,
    this.theActivityDoc,
  });

  final ActivitiesRecord? theActivityDoc;

  @override
  State<TheActicvityWidget> createState() => _TheActicvityWidgetState();
}

class _TheActicvityWidgetState extends State<TheActicvityWidget> {
  late TheActicvityModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TheActicvityModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
