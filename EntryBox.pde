class EntryBox {
  float W;
  float H;
  float x_loc;
  float y_loc;
  boolean displayCursor = false;
  StringBuilder data = new StringBuilder();
  int theirScore;
  
  ScoreHandler score_handler;

  // Constructors
  EntryBox(float xloc, float yloc, float w, float h) {
    this.W = w;
    this.H = h;
    this.x_loc = xloc;
    this.y_loc = yloc;
    //This handles the score only when we have a winner
    this.score_handler = new ScoreHandler();
  }
  // Methods
  void display() {
    fill(255);
    rectMode(CENTER);
    rect(x_loc, y_loc, W, H);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    if (displayCursor == true) {
      text(data.toString()+"|", x_loc, y_loc);
    } else {
      text(data.toString(), x_loc, y_loc);
    }
  }


  void checkClick() {
    // Check if the mouse is over the button when clicked
    if (mouseX > x_loc-W/2 && mouseX < x_loc+W/2 &&
      mouseY > y_loc-H/2 && mouseY < y_loc+H/2) {
      // insert functionality as well
      displayCursor = true;
      this.display();
    } else {
      displayCursor = false;
    }
  }

  void handleKey(char key) {
    if (displayCursor == true) {
      if (key != '\n' && key != BACKSPACE) {
        if (data.toString().length() < 15) {
          data.append(key);
        }
      } else if (key == BACKSPACE && data.length() > 0) {
        data.deleteCharAt(data.length() - 1);
      } else if (key == ENTER) {
        TOP_SCORE_TABLE = submitData();
      }
    }
  }

  Table submitData() {
    String theirName = data.toString(); 
    Table tb_newWinner = score_handler.CheckLocForHighScore(Current_Player_Score, theirName);
    score_handler.displayScores(tb_newWinner);
    isTopScoresScreen = true;
    isWinnerScreen = false;
    return tb_newWinner; 
  }
  
  int return5th_on_ScoreBoard(){
  return score_handler.return5th_on_ScoreBoard();
  }
}
