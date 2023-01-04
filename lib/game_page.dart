import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tic_tak_toe/constants/colors.dart';
import 'package:tic_tak_toe/widgets/custom_button.dart';
import 'package:tic_tak_toe/widgets/custom_snackbar.dart';

import 'models/game.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: GameBody(),
    );
  }
}

class GameBody extends StatefulWidget {
  const GameBody({Key? key}) : super(key: key);

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  String lastValue = 'X';
  Game game = Game();
  bool gameOver = false;
  int turn = 0;
  String result = '';
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    game.board = Game.initialBoard();
    debugPrint(game.board.toString());
  }

  @override
  Widget build(BuildContext context) {
    double boardSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'It\'s $lastValue turn'.toUpperCase(),
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 50.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: boardSize,
            width: boardSize,
            child: GridView.count(
              crossAxisCount: Game.boardBoxes ~/ 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: EdgeInsets.zero,
              children: List.generate(
                Game.boardBoxes,
                (index) => GestureDetector(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index].isEmpty) {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = Game.winnerCheck(
                                lastValue,
                                index,
                                scoreBoard,
                                3,
                              );
                              if(gameOver)
                                {
                                  result = '$lastValue is the winner!';
                                  showSnackBar(context: context, message: result);
                                }
                              else if(!gameOver && turn == 9)
                                {
                                  result = 'It\'s a Draw!';
                                  showSnackBar(context: context, message: result);
                                  gameOver = true;
                                }
                              lastValue == 'X'
                                  ? lastValue = 'O'
                                  : lastValue = 'X';
                            });
                          }
                        },
                  child: Container(
                    height: Game.blocSize,
                    width: Game.blocSize,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == 'X'
                              ? Colors.blueAccent
                              : Colors.pinkAccent,
                          fontSize: 80.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomButton(
            onTap: (){
              setState(() {
                game.board = Game.initialBoard();
                lastValue = 'X';
                gameOver = false;
                turn = 0;
                result = '';
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            label: 'Restart',
            color: AppColors.accentColor,
            width: boardSize,
            height: 50,
          ),
        ],
      ),
    );
  }
}
