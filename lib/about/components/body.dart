import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stockin/global.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../size.dart';
import '../../theme.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.all(getHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "About StockIn",
                  style: TextStyle(
                    fontSize: getHeight(28),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: getHeight(40)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getHeight(140)),
                  child: Text(
                    GlobalParams.aboutInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getHeight(18),
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(20)),
                Divider(
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.4)),
                SizedBox(height: getHeight(20)),
                Text(
                  "What We Excel In",
                  style: TextStyle(
                    fontSize: getHeight(24),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: getHeight(40)),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: getHeight(40),
                  runSpacing: getHeight(40),
                  children: [
                    AboutCard(
                      aboutExcel: GlobalParams.aboutExcel[0],
                      gradient: LinearGradient(
                        colors: [IndexColors.colors[4], IndexColors.colors[3]],
                      ),
                    ),
                    AboutCard(
                      aboutExcel: GlobalParams.aboutExcel[1],
                      gradient: LinearGradient(
                        colors: [IndexColors.colors[3], IndexColors.colors[5]],
                      ),
                    ),
                    AboutCard(
                      aboutExcel: GlobalParams.aboutExcel[2],
                      gradient: LinearGradient(
                        colors: [IndexColors.colors[5], IndexColors.colors[3]],
                      ),
                    ),
                    AboutCard(
                      aboutExcel: GlobalParams.aboutExcel[3],
                      gradient: LinearGradient(
                        colors: [IndexColors.colors[3], IndexColors.colors[4]],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(20)),
                Divider(
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.4)),
                SizedBox(height: getHeight(20)),
                Text(
                  "</Developers>",
                  style: TextStyle(
                    fontSize: getHeight(24),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: getHeight(40)),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: getHeight(40),
                  runSpacing: getHeight(40),
                  children: [
                    AboutTeamCard(
                      name: "Akshay Vhatkar",
                      email: "akshay.vhatkar@spit.ac.in",
                      linkedIn: "akshay-vhatkar",
                      borderColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      bgColor: IndexColors.colors[0].withOpacity(0.1),
                    ),
                    AboutTeamCard(
                      name: "Vatsal Shah",
                      email: "vatsal.shah@spit.ac.in",
                      linkedIn: "vatsal-shah-0b1b64230",
                      borderColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      bgColor: IndexColors.colors[5].withOpacity(0.1),
                    ),
                    AboutTeamCard(
                      name: "Shubh Shah",
                      email: "shubh.shah@spit.ac.in",
                      linkedIn: "shubh-shah-2b2034203",
                      borderColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      bgColor: IndexColors.colors[1].withOpacity(0.1),
                    ),
                    AboutTeamCard(
                      name: "Krish Shah",
                      email: "krish.shah@spit.ac.in",
                      linkedIn: "krishshah10",
                      borderColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      bgColor: IndexColors.colors[4].withOpacity(0.1),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class AboutTeamCard extends StatelessWidget {
  const AboutTeamCard({
    Key? key,
    required this.name,
    required this.borderColor,
    required this.bgColor,
    required this.email,
    required this.linkedIn,
  }) : super(key: key);
  final String name, email, linkedIn;
  final Color borderColor, bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse("https://www.linkedin.com/in/$linkedIn/")),
      splashColor: bgColor.withOpacity(0.05),
      hoverColor: bgColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: getHeight(250),
          height: getHeight(180),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: getHeight(100),
                height: getHeight(100),
                decoration: BoxDecoration(
                  color: borderColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: getHeight(90),
                    height: getHeight(90),
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: getHeight(50),
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: getHeight(16),
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  SizedBox(height: getHeight(5)),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: getHeight(12),
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class AboutCard extends StatelessWidget {
  const AboutCard({
    Key? key,
    required this.aboutExcel,
    required this.gradient,
  }) : super(key: key);
  final String aboutExcel;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      width: getHeight(250),
      height: getHeight(130),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            aboutExcel,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getHeight(16),
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
