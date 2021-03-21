import 'package:flutter_html/flutter_html.dart';
import 'package:tiptop_v2/UI/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/app_scaffold.dart';
import 'package:tiptop_v2/models/static_page.dart';
import 'package:tiptop_v2/providers/app_provider.dart';

class TermsPage extends StatefulWidget {
  static const routeName = '/terms';

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _isLoading = false;
  StaticPage _terms;

  @override
  void initState() {
    _fetchAndSetContent();
    super.initState();
  }

  Future<void> _fetchAndSetContent() async {
    setState(() {
      _isLoading = true;
    });
    final responseData = await AppProvider().get(endpoint: 'terms-and-conditions');
    StaticPageResponse staticPageResponse = StaticPageResponse.fromJson(responseData);
    _terms = staticPageResponse.staticPage;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: RefreshIndicator(
        onRefresh: _fetchAndSetContent,
        child: _isLoading
            ? Center(child: AppLoader())
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                child: Html(
                  shrinkWrap: true,
                  data: """${_terms.content.formatted}""",
                ),
              ),
      ),
    );
  }
}