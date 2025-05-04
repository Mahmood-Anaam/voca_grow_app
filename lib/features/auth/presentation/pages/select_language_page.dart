import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectLanguagePage());
  }

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ImageOverlayWidget(
          image: AssetImage(Assets.imagesTopPolygon),
          alignment: Alignment.topLeft,
          child: ImageOverlayWidget(
            image: AssetImage(Assets.imagesBottomPolygon),
            alignment: Alignment.bottomRight,
            child: ImageOverlayWidget(
              image: AssetImage(Assets.imagesSpiderMan),
              alignment: Alignment.topRight,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthHeader(
                        title: "Let's Talk!",
                        subtitle: 'please select your language',
                        logo: Image.asset(
                          Assets.imagesCartoonCharacters,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),

                      const VerticalSpace(3),

                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 700,
                          minWidth: 400,
                          minHeight: 50,
                          maxHeight: 50,
                        ),
                        child: SubmitButtonWidget(
                          text: "English",
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('lang', 'en');
                            // ignore: use_build_context_synchronously
                            Navigator.push(context, UserTypePage.route());
                          },
                        ),
                      ),
                      const VerticalSpace(3),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 700,
                          minWidth: 400,
                          minHeight: 50,
                          maxHeight: 50,
                        ),
                        child: SubmitButtonWidget(
                          text: "العربية",
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('lang', 'ar');
                            // ignore: use_build_context_synchronously
                            Navigator.push(context, UserTypePage.route());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
