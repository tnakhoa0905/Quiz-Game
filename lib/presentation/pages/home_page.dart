import 'package:do_vui_app/bloc/quiz_bloc.dart';
import 'package:do_vui_app/presentation/pages/play_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexList = 0;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(BlocProvider.of<QuizBloc>(context).state);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SizedBox(
              height: double.infinity,
              child: Image.asset(
                "assets/images/home_page/back_ground.png",
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              )),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/images/home_page/btn_share.png",
                      width: 65,
                      height: 65,
                    ),
                    Image.asset(
                      "assets/images/home_page/btn_like.png",
                      width: 65,
                      height: 65,
                    ),
                    Image.asset(
                      "assets/images/home_page/btn_notif.png",
                      width: 65,
                      height: 65,
                    ),
                  ],
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 9 / 10,
                    child: Image.asset("assets/images/home_page/content.png")),
                Text(
                  'Cấp độ ${indexList + 1}',
                  style: const TextStyle(
                      fontFamily: "UTM_Cookies",
                      fontSize: 48,
                      color: Color(0xFFFFfc00)),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlayScreen(indexList: indexList)),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.51,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/home_page/btn_vao.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/home_page/text_vao.png",
                      height: 44,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.51,
                  // height: 100,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_page/btn_game.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/home_page/text_game.png",
                    height: 44,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
