import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQ extends StatelessWidget {
  void _createEmail() async {
    const emailaddress =
        "mailto:karanowalekar270399@gmail.com?subject=I have a Question.";

    if (await canLaunch(emailaddress)) {
      await launch(emailaddress);
    } else {
      print("[ERROR] Unable to sned email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Frequently Asked Questions",
            style: GoogleFonts.muli(
                fontSize: 25,
                color: Color.fromRGBO(31, 31, 38, 0.8),
                fontWeight: FontWeight.w600),
          ),
        ),
        FAQQuestions(
          question: "1st Question",
          answer: "Answer to 1st question",
        ),
        FAQQuestions(
          question: "2st Question",
          answer: "Answer to 2st question",
        ),
        FAQQuestions(
          question: "3st Question",
          answer: "Answer to 3st question",
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Still have a question?",
            style: GoogleFonts.muli(
                fontSize: 25,
                color: Color.fromRGBO(31, 31, 38, 0.8),
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          width: 500,
          padding: const EdgeInsets.all(10),
          child: Text(
            "If you cannot find answer to your question in our FAQ, you can always contact us. We will answer to you shortly!",
            style: GoogleFonts.muli(
              fontSize: 15,
              color: Color.fromRGBO(31, 31, 38, 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: _createEmail,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
                width: 45,
                child: Image.asset(
                  "assets/Images/chat.png",
                  color: Color.fromRGBO(234, 87, 83, 1),
                )),
          ),
        )
      ],
    );
  }
}

class FAQQuestions extends StatelessWidget {
  final question;
  final answer;
  FAQQuestions({@required this.question, @required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 250, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200], width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: ExpandablePanel(
        header: Text(
          "  $question",
          style: GoogleFonts.muli(
            fontSize: 17,
            color: Color.fromRGBO(31, 31, 38, 0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        collapsed: null,
        expanded: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            answer,
            style: GoogleFonts.muli(
              fontSize: 15,
              color: Color.fromRGBO(31, 31, 38, 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
