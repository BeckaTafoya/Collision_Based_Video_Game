PImage title;
PImage high_score;
PImage high_score_board_title;
PImage cloud;
PImage bird_flock;
PImage game_over_text;
PImage boo_ghost;
PImage flower;

PShape metal;

Button playButton;
Button ReplayButton;
Button bestButton;
Button bestButton2;
Button bestButton3;
Button EnterButton;
Button homeButton;

EntryBox NameEntry_box;
Table TOP_SCORE_TABLE;
int Current_Player_Score = 0;
int Fifth_Highest_Score;

boolean isHomeScreen = true;
boolean isGameScreen = false;
boolean isLoserScreen = false;
boolean isWinnerScreen = false;
boolean isTopScoresScreen = false;

Ball player_Ball;
float x_ball = 300;
float y_ball = 300;

Cloud cloud1;
Cloud cloud2;

float time = 0;
PVector accel = new PVector(0, -1);
PVector vel = new PVector(10, 0);
PVector vel_cloud2 = new PVector(-15, 0);
PVector pos_cloud1 = new PVector(-300, 300);
PVector pos_cloud2 = new PVector(300, 0);

//ScoreHandler score_handler;

void setup() {
  //score_handler = new ScoreHandler();

  // Load all of my images
  title = loadImage("title.png");
  high_score = loadImage("high_score_title.png");
  high_score_board_title = loadImage("high_score_board.png");
  cloud = loadImage("cloud.png");
  bird_flock = loadImage("birds.png");
  game_over_text = loadImage("GameOver.png");
  boo_ghost = loadImage("ghost.jpg");
  flower = loadImage("flower.png");
  metal = loadShape("metal.svg");
  TOP_SCORE_TABLE = loadTable("ScoreKeeper.csv", "header");

  cloud1 = new Cloud();
  cloud2 = new Cloud();
  player_Ball = new Ball();

  size(600, 600);
  imageMode(CENTER);

  // Button parameters
  float play_w = 200;
  float play_h = 100;
  float play_xloc = width/2;
  float play_yloc = height*2/3;

  float best_w = 200;
  float best_h = 50;
  float best_xloc = width/2;
  float best_yloc = height*4/5;

  float Enter_w = 100;
  float Enter_h = 50;
  float Enter_xloc = width*3/4;
  float Enter_yloc = height*3/5;

  float best3_xloc = width/2;
  float best3_yloc = height*10/11;

  // Create button objects
  playButton = new Button("play", play_w, play_h, play_xloc, play_yloc);
  ReplayButton = new Button("Replay", play_w, play_h, play_xloc, play_yloc);
  bestButton = new Button("best_scores", best_w, best_h, best_xloc, best_yloc);
  bestButton2 = new Button("best_scores", best_w, best_h, best_xloc, best_yloc);
  bestButton3 = new Button("best_scores", best_w, best_h, best3_xloc, best3_yloc);
  EnterButton = new Button("Enter", Enter_w, Enter_h, Enter_xloc, Enter_yloc);
  homeButton = new Button("home", 50, 50, 300, 550);
  NameEntry_box = new EntryBox(width*3/7-10, Enter_yloc, 275, 30);
  Fifth_Highest_Score = NameEntry_box.return5th_on_ScoreBoard();
}
void draw() {
  if (isHomeScreen == true) {
    displayHomeScreen();
  } else if (isGameScreen) {
    displayGameScreen();
  } else if (isLoserScreen) {
    displayLoserScreen();
  } else if (isWinnerScreen) {
    displayWinnerScreen();
  } else if (isTopScoresScreen) {
    displayTopScoreScreen();
  }
}
void displayGameScreen() {
  Fifth_Highest_Score = NameEntry_box.return5th_on_ScoreBoard();
  background(#7EE4FF);
  player_Ball.display(x_ball, y_ball);
  Current_Player_Score += 1;
  println(Current_Player_Score);
  // handle the physics of the clouds
  float time_step = 0.1;
  time += time_step;
  if (vel.y > -100) {
    vel = vel.add(accel.copy().mult(time_step));
  }
  if (pos_cloud1.y < -400) {
    pos_cloud1.y = 400;
  } else {
    pos_cloud1 = pos_cloud1.add(vel.copy().mult(time_step));
  }
  if (pos_cloud1.x < - 300 || pos_cloud1.x > 300) {
    vel.x = -vel.x;
  }
  cloud1.displayCloud(pos_cloud1.x, pos_cloud1.y);
  // check collision
  if (cloud1.checkCollision(x_ball, y_ball)) {
    // check for high score
    if (Current_Player_Score > Fifth_Highest_Score) {
      // they won
      isGameScreen = false;
      isWinnerScreen = true;
    } else {
      // they lost
      isGameScreen = false;
      isLoserScreen = true;
    }
  }

  // REPEAT FOR CLOUD 2 - hard coding because I'm tired:
  if (vel_cloud2.y > -100) {
    vel_cloud2 = vel_cloud2.add(accel.copy().mult(time_step));
  }
  if (pos_cloud2.y < -400) {
    pos_cloud2.y = 400;
  } else {
    pos_cloud2 = pos_cloud2.add(vel_cloud2.copy().mult(time_step));
  }
  if (pos_cloud2.x < - 300 || pos_cloud2.x > 300) {
    vel_cloud2.x = -vel_cloud2.x;
  }
  cloud2.displayCloud(pos_cloud2.x, pos_cloud2.y);
  // check collision
  if (cloud2.checkCollision(x_ball, y_ball)) {
    // check for high score
    if (Current_Player_Score > Fifth_Highest_Score) {
      // they won
      isGameScreen = false;
      isWinnerScreen = true;
    } else {
      // they lost
      isGameScreen = false;
      isLoserScreen = true;
    }
  }
}
void displayHomeScreen() {
  background(#7EE4FF);
  image(cloud, width/5, height/6, width/4, height/6);
  image(cloud, width*5/6, height/6, width/4, height/6);
  image(bird_flock, width/2, height*4/6, width, height/3);
  image(title, width/2, height/3, 500, 300);
  playButton.checkButtonHighlight();
  bestButton.checkButtonHighlight();
};

void displayLoserScreen() {
  background(0);
  image(game_over_text, width/2, height/2, height*3/4, width/5);
  image(boo_ghost, width/2, height/4, height/4, width/4);
  ReplayButton.checkButtonHighlight();
  bestButton2.checkButtonHighlight();
}

void displayWinnerScreen() {
  background(0);
  image(high_score, width/2, height/3, width*3/4, width/3);
  shape(metal, width/6, height*4/5, 100, 100);
  shape(metal, width*4/6, height*4/5, 100, 100);
  EnterButton.checkButtonHighlight();
  bestButton3.checkButtonHighlight();
  NameEntry_box.display();
}

void displayTopScoreScreen() {
  background(0);
  image(high_score_board_title, width/2, height/4, width, height/4);
  int yspacer = 0;
  int place = 0;
  for (TableRow row : TOP_SCORE_TABLE.rows()) {
    place ++;
    yspacer+=60;
    int highScoreVal = row.getInt("Score");
    String Name = row.getString("Name");
    String myString = place  + ". Name: " + Name + ", Score: " + highScoreVal;
    fill(255);
    textSize(30);
    textAlign(LEFT, CENTER);
    text(myString, 50, 150+yspacer);
  }
  homeButton.checkButtonHighlight();
}

void mousePressed() {
  if (isHomeScreen) {
    playButton.checkClick();
    bestButton.checkClick();
  } else if (isLoserScreen) {
    ReplayButton.checkClick();
    bestButton2.checkClick();
  } else if (isWinnerScreen) {
    EnterButton.checkClick();
    if (EnterButton.hasBeenClicked()) {
      TOP_SCORE_TABLE = NameEntry_box.submitData();
    }
    bestButton3.checkClick();
    NameEntry_box.checkClick();
  } else if (isTopScoresScreen) {
    homeButton.checkClick();
  }
}

void keyPressed() {
  if (isWinnerScreen) {
    //if (keyCode != SHIFT) {
    NameEntry_box.handleKey(key);
    //}
  }
  if (isGameScreen) {
    if (keyCode == LEFT) {
      // only translate if it's going to be within the screen
      if (x_ball > 0) {
        x_ball = x_ball - 20;
      }
    }
    if (keyCode == RIGHT) {
      // only translate if it's going to be within the screen
      if (x_ball < 600) {
        x_ball = x_ball + 20;
      }
    }
  }
}
