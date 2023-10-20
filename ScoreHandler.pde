class ScoreHandler {
  // See other sketch
  Table old_tb;
  Table new_tb;
  boolean newTable = false;
  int num_times_called;

  // Constructors
  ScoreHandler() {
    this.num_times_called = 0;
    old_tb = loadTable("ScoreKeeper.csv", "header");
    new_tb = new Table();
    new_tb.addColumn("Name");
    new_tb.addColumn("Score");
  }

  // Methods
  Table CheckLocForHighScore(int CurrentHighScore, String CurrentName) {
    int i = 0;
    int highScoreVal;
    String Name;

    if (num_times_called > 0) {
      old_tb = loadTable("ScoreKeeper.csv", "header");
      new_tb = new Table();
      new_tb.addColumn("Name");
      new_tb.addColumn("Score");
    }

    for (TableRow row : old_tb.rows()) {

      highScoreVal = row.getInt("Score");
      Name = row.getString("Name");

      if (CurrentHighScore>highScoreVal) {

        new_tb.addRow(); // Creates an empty row
        new_tb.setString(i, "Name", CurrentName);
        new_tb.setInt(i, "Score", CurrentHighScore);

        // then go through rest of look and replace next position with
        // queque value, then break out of for loop.

        for (int j = 0; j < old_tb.getRowCount()-i-1; j++) {

          highScoreVal = old_tb.getInt(i+j, "Score");
          Name = old_tb.getString(i+j, "Name");
          new_tb.setString(i+j+1, "Name", Name);
          new_tb.setInt(i+j+1, "Score", highScoreVal);
        }
        break;
      } else {
        new_tb.addRow(); // Creates an empty row
        new_tb.setString(i, "Name", Name);
        new_tb.setInt(i, "Score", highScoreVal);
      }
      i++;
    }
    return new_tb;
  }


  void displayScores() {
    if (newTable) {
      displayScores(new_tb);
    } else {
      displayScores(old_tb);
    }
  }

  int return5th_on_ScoreBoard() {
    if (newTable) {
      TableRow row = new_tb.getRow(4);
      return row.getInt("Score");
    } else {
      TableRow row = old_tb.getRow(4);
      return row.getInt("Score");
    }
  }

  void displayScores(Table tb) {
    newTable = true;
    for (int i=0; i<tb.getRowCount(); i++) {
      int highScoreVal = tb.getInt(i, "Score");
      String Name = tb.getString(i, "Name");
      int place = i+1;
      String myString = "Rank: " + place  + ", Name: " + Name + ", Score: " + highScoreVal;
      println(myString);
      saveTable(tb, "ScoreKeeper.csv");
      num_times_called++;
    }
  }
}
