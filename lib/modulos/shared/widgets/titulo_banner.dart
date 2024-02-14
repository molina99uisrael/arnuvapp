import 'package:flutter/material.dart';
import 'package:arnuvapp/config/constants/environment.dart';

class TituloBanner extends StatelessWidget {
  const TituloBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Column(
      children: [
        const Spacer(flex: 4),
        RichText(
          text: TextSpan(
            style: textStyles.bodyLarge!
                .copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 24),
            children: const <TextSpan>[
              TextSpan(
                text: Environment.nombreApp,
                style: TextStyle(fontWeight: FontWeight.w300)),
            ]
          )
        ),
        const Spacer( flex: 4),
      ],
    );
  }
}

class TituloBannerHome extends StatelessWidget {
  const TituloBannerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 180,
      color: textStyles.primaryColor,
      width: size.width,
      child: Text(
        Environment.nombreApp,
        style: textStyles.textTheme.titleMedium!.copyWith(
          color: textStyles.primaryColorLight
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}