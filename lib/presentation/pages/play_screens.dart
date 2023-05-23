import 'dart:math';

import 'package:do_vui_app/bloc/quiz_bloc.dart';
import 'package:do_vui_app/bloc/quiz_event.dart';
import 'package:do_vui_app/bloc/quiz_state.dart';
import 'package:do_vui_app/data/quizModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_vui_app/data/provider/core.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  bool isCorrectA = false;
  bool isCorrectB = false;
  bool isCorrectC = false;
  bool isCorrectD = false;
  String result = "";

  late AnimationController _controller;
  late Animation<double> _animation;

  // late Animation<double> animation;

  // late AnimationController controller;

  late QuizBloc quizBloc;

  @override
  void initState() {
    super.initState();

    quizBloc = BlocProvider.of<QuizBloc>(context);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    // controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QuizBloc, QuizState>(
          bloc: quizBloc,
          builder: (context, state) {
            if (state is LoadedQuiz) {
              result = state.quizModel.data[heart].dapAn;

              return Stack(children: [
                SizedBox(
                    height: double.infinity,
                    child: Image.asset(
                      "assets/images/play_page/back_ground.png",
                      fit: BoxFit.cover,
                    )),
                Image.asset(
                  "assets/images/play_page/app_bar.png",
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 24,
                            backgroundImage: const AssetImage(
                                'assets/images/play_page/btn.png'),
                            child: Image.asset(
                              "assets/images/play_page/btn_back.png",
                              // height: 40,
                              width: 20,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/images/play_page/heart.png",
                          width: 40,
                        ),
                        BlocListener<QuizBloc, QuizState>(
                          bloc: quizBloc,
                          listener: ((context, state) {
                            if (state is QuizChecked) {
                              if (state.ansState == false) {
                                heart--;
                              }
                            }
                          }),
                          child: Text(
                            '$heart',
                            style: const TextStyle(
                                fontFamily: "UTM_Cookies", fontSize: 30),
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 24,
                          backgroundImage: const AssetImage(
                              'assets/images/play_page/btn.png'),
                          child: Image.asset(
                            "assets/images/play_page/btn_share.png",
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.33,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/play_page/question.png'))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 44,
                            ),
                            Text(
                              'Cấp độ ${indexList + 1}',
                              style: const TextStyle(
                                  fontFamily: 'UTM_Cookies',
                                  fontSize: 40,
                                  color: Color(0xFFfffc00)),
                            ),
                            Text(state.quizModel.data[indexList].cauHoi,
                                style: const TextStyle(
                                    fontSize: 24, color: Color(0xFFffa515)))
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        quizBloc.add(QuizCheckResult(
                            ans: "a",
                            indexList: indexList,
                            quizModel: state.quizModel));

                        _dialogBuilder(context, state.quizModel);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: BlocListener<QuizBloc, QuizState>(
                                bloc: quizBloc,
                                listener: ((context, state) {
                                  if (state is QuizChecked) {
                                    if (state.ans.contains("a")) {
                                      isCorrectA = state.ansChecked;
                                    }
                                  }
                                }),
                                child: Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    image: isCorrectA == false
                                        ? const AssetImage(
                                            "assets/images/play_page/ans.png")
                                        : const AssetImage(
                                            "assets/images/play_page/ans_correct.png")),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          118 /
                                          720,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.quizModel.data[indexList].a,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 118 / 1280,
                            width: MediaQuery.of(context).size.width * 0.16,
                            child: Stack(children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Image(
                                    image: AssetImage(
                                  "assets/images/play_page/dap_an.png",
                                )),
                              ),
                              Align(
                                alignment: Alignment(0, -0.3),
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: "UTM_Cookies",
                                      color: Color(0xFFfffc00)),
                                ),
                              )
                            ]),
                          ),
                        ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        quizBloc.add(QuizCheckResult(
                            ans: "b",
                            indexList: indexList,
                            quizModel: state.quizModel));
                        _dialogBuilder(context, state.quizModel);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: BlocListener<QuizBloc, QuizState>(
                                bloc: quizBloc,
                                listener: ((context, state) {
                                  if (state is QuizChecked) {
                                    if (state.ans.contains("b")) {
                                      isCorrectB = state.ansChecked;
                                    }
                                  }
                                }),
                                child: Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    image: isCorrectB == false
                                        ? const AssetImage(
                                            "assets/images/play_page/ans.png")
                                        : const AssetImage(
                                            "assets/images/play_page/ans_correct.png")),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          118 /
                                          720,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.quizModel.data[indexList].b,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 118 / 1280,
                            width: MediaQuery.of(context).size.width * 0.16,
                            child: Stack(children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Image(
                                    image: AssetImage(
                                  "assets/images/play_page/dap_an.png",
                                )),
                              ),
                              Align(
                                alignment: Alignment(0, -0.3),
                                child: Text(
                                  'B',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: "UTM_Cookies",
                                      color: Color(0xFFfffc00)),
                                ),
                              )
                            ]),
                          ),
                        ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        quizBloc.add(QuizCheckResult(
                            ans: "c",
                            indexList: indexList,
                            quizModel: state.quizModel));
                        _dialogBuilder(context, state.quizModel);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: BlocListener<QuizBloc, QuizState>(
                                bloc: quizBloc,
                                listener: ((context, state) {
                                  if (state is QuizChecked) {
                                    if (state.ans.contains("c")) {
                                      isCorrectC = state.ansChecked;
                                    }
                                  }
                                }),
                                child: Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    image: isCorrectC == false
                                        ? const AssetImage(
                                            "assets/images/play_page/ans.png")
                                        : const AssetImage(
                                            "assets/images/play_page/ans_correct.png")),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          118 /
                                          720,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.quizModel.data[indexList].c,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 118 / 1280,
                            width: MediaQuery.of(context).size.width * 0.16,
                            child: Stack(children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Image(
                                    image: AssetImage(
                                  "assets/images/play_page/dap_an.png",
                                )),
                              ),
                              Align(
                                alignment: Alignment(0, -0.3),
                                child: Text(
                                  'C',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: "UTM_Cookies",
                                      color: Color(0xFFfffc00)),
                                ),
                              )
                            ]),
                          ),
                        ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        quizBloc.add(QuizCheckResult(
                            ans: "d",
                            indexList: indexList,
                            quizModel: state.quizModel));

                        _dialogBuilder(context, state.quizModel);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: BlocListener<QuizBloc, QuizState>(
                                bloc: quizBloc,
                                listener: ((context, state) {
                                  if (state is QuizChecked) {
                                    if (state.ans.contains("d")) {
                                      isCorrectD = state.ansChecked;
                                    }
                                  }
                                }),
                                child: Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    image: isCorrectD == false
                                        ? const AssetImage(
                                            "assets/images/play_page/ans.png")
                                        : const AssetImage(
                                            "assets/images/play_page/ans_correct.png")),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          118 /
                                          720,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.quizModel.data[indexList].d,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))
                          ]),
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  118 /
                                  1280,
                              width: MediaQuery.of(context).size.width * 0.16,
                              child: Stack(children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image(
                                      image: AssetImage(
                                    "assets/images/play_page/dap_an.png",
                                  )),
                                ),
                                Align(
                                  alignment: Alignment(0, -0.3),
                                  child: Text(
                                    'D',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: "UTM_Cookies",
                                        color: Color(0xFFfffc00)),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ]);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, QuizModel? model) {
    var sizeW = MediaQuery.of(context).size.width;
    var sizeH = MediaQuery.of(context).size.height;
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (BuildContext context, anim1, anim2) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          actions: [
            SizedBox(
              height: sizeH * 812 / 1280,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image(
                      height: sizeH * 455 / 1280,
                      image: const AssetImage(
                        "assets/images/play_page/star.png",
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(sizeW * 68 / 728,
                        sizeH * 118 / 1280, sizeW * 128 / 728, 0),
                    child: ScaleTransition(
                      scale: _animation,
                      child: Container(
                        child: const Image(
                            image: AssetImage(
                          "assets/images/play_page/icon_hi.png",
                        )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 316 / 1280,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: sizeW * 63 / 728,
                          top: sizeH * 63 / 1280,
                          right: sizeW * 63 / 728),
                      height: sizeH * 241 / 1280,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/play_page/message.png",
                              ))),
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              model!.data[indexList].giaiThich.isEmpty
                                  ? "bạn thật tài giỏi"
                                  : model.data[indexList].giaiThich,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 500 / 1280,
                    child: Container(
                      width: sizeW * 289 / 728,
                      height: sizeH * 113 / 1280,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/play_page/btn_resume.png",
                              ))),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Center(
                            child: Text(
                          'Chơi tiếp',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    ).then((value) {
      if (indexList == model!.data.length - 1) {
        indexList = 0;
      } else {
        indexList++;
      }
      isCorrectA = false;
      isCorrectB = false;
      isCorrectC = false;
      isCorrectD = false;
      if (heart == 0) {
        indexList = 0;
        heart = 5;
      }
      quizBloc.add(QuizSuccess(index: indexList, model: model));
    });
  }
}
