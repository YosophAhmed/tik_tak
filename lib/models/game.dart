class Player {
  static const String x = 'X';
  static const String o = 'O';
  static const String empty = '';
}

class Game {
  static const int boardBoxes = 9;
  static const double blocSize = 100;

  List<String>? board;

  static List<String>? initialBoard() => List.generate(
        boardBoxes,
        (index) => Player.empty,
      );

  static bool winnerCheck(
      String player, int index, List<int> scoreBoard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == 'X' ? 1 : -1;

    scoreBoard[row] += score;
    scoreBoard[gridSize + col] += score;

    if (row == col) {
      scoreBoard[2 * gridSize] += score;
    }
    if (gridSize - 1 - col == row) {
      scoreBoard[2 * gridSize + 1] += score;
    }
    if (scoreBoard.contains(3) || scoreBoard.contains(-3)) {
      return true;
    }
    return false;
  }
}
