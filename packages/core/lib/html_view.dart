import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart';

class HtmlView extends StatelessWidget {
  final String url;
  const HtmlView(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HtmlPageCubit, String?>(
        bloc: HtmlPageCubit(null)..start(url),
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator.adaptive();
          }
          return HtmlWidget(state);
        });
  }
}

class HtmlPageCubit extends Cubit<String?> {
  HtmlPageCubit(super.initialState);

  Future<void> start(String url) async {
    var response = await Client().get(Uri.parse(url));
    emit(response.body);
  }
}
