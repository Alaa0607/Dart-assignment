import 'dart:io';

class TicTacToe {
  late List<List<String>> board;
  late String currentPlayer;

  TicTacToe() {
    board = List.generate(3, (_) => List.generate(3, (_) => ' '));
    currentPlayer = 'X';
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int position) {
    if (position < 1 || position > 9) {
      print('Invalid move. Please enter a number between 1 and 9.');
      return false;
    }

    var row = (position - 1) ~/ 3;
    var col = (position - 1) % 3;

    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      return true;
    } else {
      print('Cell already occupied. Choose another position.');
      return false;
    }
  }

 bool checkWin() {
  // Check rows
  for (var row in board) {
    if (row.every((cell) => cell == currentPlayer)) {
      return true;
    }
  }

  // Check columns
  for (var col = 0; col < 3; col++) {
    if (board.every((row) => row[col] == currentPlayer)) {
      return true;
    }
  }

  // Check diagonals
  if ((board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) ||
      (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer)) {
    return true;
  }

  return false;
}


  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    print('Welcome to Tic-Tac-Toe!');

    do {
      printBoard();
      print('Player $currentPlayer, enter your move (1-9): ');

      var validMove = false;
      do {
        var input = stdin.readLineSync();
        var position = int.tryParse(input ?? '');

        validMove = (position != null) ? makeMove(position) : false;
      } while (!validMove);

      if (checkWin()) {
        printBoard();
        print('Player $currentPlayer wins!');
        break;
      }

      if (isBoardFull()) {
        printBoard();
        print('It\'s a draw!');
        break;
      }

      switchPlayer();
    } while (true);

    printBoard(); // Display the final board state
  }
}

void main() {
  do {
    var game = TicTacToe();
    game.play();

    print('Do you want to play again? (yes/no): ');
    var playAgain = stdin.readLineSync()?.toLowerCase();

    if (playAgain != 'yes') {
      print('Thanks for playing. Goodbye!');
      break;
    }
  } while (true);
}
