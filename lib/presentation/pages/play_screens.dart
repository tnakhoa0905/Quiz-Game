import 'package:do_vui_app/bloc/quiz_bloc.dart';
import 'package:do_vui_app/bloc/quiz_event.dart';
import 'package:do_vui_app/bloc/quiz_state.dart';
import 'package:do_vui_app/data/quizModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  var indexLists = 0;
  bool isCorrect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object');
    print("aaa");
    BlocProvider.of<QuizBloc>(context).add(FectchQuiz());
    // print(BlocProvider.of<QuizBloc>(context).add(FectchQuiz()));
    print('*-*-*-*-*-*-*-*-*-*-*-*-*');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            print(state);
            if (state is LoadingQuiz) {
              print("loaidng");
              return CircularProgressIndicator();
            }
            if (state is FailedQuiz) {
              print("failed");
              return Container(
                child: Text(state.message),
              );
            }

            if (state is LoadedQuiz) {
              print("loađed");
              print(indexLists);
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
                        CircleAvatar(
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
                        const Spacer(),
                        Image.asset(
                          "assets/images/play_page/heart.png",
                          width: 40,
                        ),
                        const Text(
                          '5',
                          style: TextStyle(
                              fontFamily: "UTM_Cookies", fontSize: 30),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 24,
                          backgroundImage: const AssetImage(
                              'assets/images/play_page/btn.png'),
                          child: Image.asset(
                            "assets/images/play_page/btn_share.png",
                            // height: 40,
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
                              'Cấp độ ${indexLists + 1}',
                              style: TextStyle(
                                  fontFamily: 'UTM_Cookies',
                                  fontSize: 40,
                                  color: Color(0xFFfffc00)),
                            ),
                            Text(state.quizModel.data[indexLists].cauHoi,
                                style: const TextStyle(
                                    fontSize: 24, color: Color(0xFFffa515)))
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('a');
                        if (state.quizModel.data[indexLists].dapAn
                            .contains(state.quizModel.data[indexLists].a)) {
                          setState(() {
                            isCorrect = true;
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            _dialogBuilder(context, "hehe", state.quizModel);
                          });
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  image: const AssetImage(
                                      "assets/images/play_page/ans.png")),
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
                                        state.quizModel.data[indexLists].a,
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
                                    // fit: BoxFit.fitHeight,
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
                        print('b');
                        if (state.quizModel.data[indexLists].dapAn
                            .contains(state.quizModel.data[indexLists].b)) {
                          setState(() {
                            isCorrect = true;
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            _dialogBuilder(context, "hehe", state.quizModel);
                          });
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  image: const AssetImage(
                                      "assets/images/play_page/ans.png")),
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
                                        state.quizModel.data[indexLists].b,
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
                                    // fit: BoxFit.fitHeight,
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

                    // Todo test case
                    GestureDetector(
                      onTap: () {
                        print('c');
                        if (state.quizModel.data[indexLists].dapAn
                            .contains(state.quizModel.data[indexLists].c)) {
                          setState(() {
                            isCorrect = true;
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            _dialogBuilder(context, "hehe", state.quizModel);
                          });
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  image: isCorrect == false
                                      ? AssetImage(
                                          "assets/images/play_page/ans.png")
                                      : AssetImage(
                                          "assets/images/play_page/ans_correct.png")),
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
                                        state.quizModel.data[indexLists].c,
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
                                    // fit: BoxFit.fitHeight,
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
                        print('d');
                        if (state.quizModel.data[indexLists].dapAn
                            .contains(state.quizModel.data[indexLists].d)) {
                          setState(() {
                            isCorrect = true;
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            _dialogBuilder(context, "hehe", state.quizModel);
                          });
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 118 / 1280,
                        child: Stack(children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  image: const AssetImage(
                                      "assets/images/play_page/ans.png")),
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
                                        state.quizModel.data[indexLists].d,
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
                                      // fit: BoxFit.fitHeight,
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
            return Container(
              child: Text('sai mẹ rồi'),
            );
          },
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, String title, QuizModel? model) {
    var sizeW = MediaQuery.of(context).size.width;
    var sizeH = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
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
                      image: AssetImage(
                        "assets/images/play_page/star.png",
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(sizeW * 68 / 728,
                        sizeH * 118 / 1280, sizeW * 128 / 728, 0),
                    child: Image(
                        width: MediaQuery.of(context).size.height * 473 / 728,
                        image: const AssetImage(
                          "assets/images/play_page/icon_hi.png",
                        )),
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
                              '$title',
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
                          if (indexLists == model!.data.length - 1) {
                            indexLists = 0;
                          } else {
                            indexLists++;
                          }
                          isCorrect = false;
                          Navigator.pop(context);
                          context.read<QuizBloc>().add(
                              QuizSuccess(index: indexLists, model: model));
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
    );
  }
}
