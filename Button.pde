class Button {
  PImage button;
  PImage button_pressed;
  PImage button_highlighter;

  float b_width;
  float b_height;
  float b_xloc;
  float b_yloc;

  boolean hasBeenClicked;

  String functionality;

  // Constructors
  Button(String button_type, float w, float h, float xloc, float yloc) {
    this.b_width = w;
    this.b_height = h;
    this.b_xloc = xloc;
    this.b_yloc = yloc;
    this.functionality = button_type;

    this.hasBeenClicked = false;
    this.button_highlighter = loadImage("highlight.png");

    if (button_type == "play") {
      this.button = loadImage("PlayButton.png");
      this.button_pressed = loadImage("PlayButton_pressed.png");
    } else if (button_type == "best_scores") {
      this.button = loadImage("TopScoresButton.png");
      this.button_pressed = loadImage("TopScoresButton_pressed.png");
    } else if (button_type == "Replay") {
      this.button = loadImage("PlayAgainButton.png");
      this.button_pressed = loadImage("PlayAgainButton_pressed.png");
    } else if (button_type == "Enter") {
      this.button = loadImage("EnterButton.png");
      this.button_pressed = loadImage("EnterButton_pressed.png");
    } else if (button_type == "home") {
      this.button = loadImage("homeButton.png");
      this.button_pressed = loadImage("homeButton_pressed.png");
    }
  }

  // Methods
  void display(String howToDisplay) {
    if (howToDisplay == "unpressed") {
      image(button, b_xloc, b_yloc, b_width, b_height);
    } else if (howToDisplay == "highlighted") {
      image(button_highlighter, b_xloc, b_yloc, b_width*1.5, b_height*2);
      if (hasBeenClicked == true) {
        image(button_pressed, b_xloc, b_yloc, b_width, b_height);
      } else {
        image(button, b_xloc, b_yloc, b_width, b_height);
      }
    }
  }

  void checkButtonHighlight() {
    // Check if the mouse is over the button when clicked
    if (mouseX > b_xloc-b_width/2 && mouseX < b_xloc+b_width/2 &&
      mouseY > b_yloc-b_height/2 && mouseY < b_yloc+b_height/2) {
      this.display("highlighted");
    } else {
      this.display("unpressed");
    }
  }

  void checkClick() {
    // Check if the mouse is over the button when clicked
    if (mouseX > b_xloc-b_width/2 && mouseX < b_xloc+b_width/2 &&
      mouseY > b_yloc-b_height/2 && mouseY < b_yloc+b_height/2) {
      // insert functionality as well
      this.display("highlighted");
      this.functionality();
      hasBeenClicked = true;
    }
  }

  boolean hasBeenClicked() {
    return hasBeenClicked;
  }

  void functionality() {
    if (functionality == "play") {
      isHomeScreen = false;
      isGameScreen = true;
      isLoserScreen = false;
      isWinnerScreen = false;
      isTopScoresScreen = false;
      Current_Player_Score = 0;
      pos_cloud1 = new PVector(-300, 300);
      pos_cloud2 = new PVector(300, 0);
      vel = new PVector(10, 0);
      vel_cloud2 = new PVector(-15, 0);
      x_ball = 300;
      y_ball = 300;
    } else if (functionality == "best_scores") {
      isHomeScreen = false;
      isGameScreen = false;
      isLoserScreen = false;
      isWinnerScreen = false;
      isTopScoresScreen = true;
    } else if (functionality == "Replay") {
      isHomeScreen = false;
      isGameScreen = true;
      isLoserScreen = false;
      isWinnerScreen = false;
      isTopScoresScreen = false;
      Current_Player_Score = 0;
      pos_cloud1 = new PVector(-300, 300);
      pos_cloud2 = new PVector(300, 0);
      vel = new PVector(10, 0);
      vel_cloud2 = new PVector(-15, 0);
      cloud1.displayCloud(pos_cloud1.x, pos_cloud1.y);
      cloud2.displayCloud(pos_cloud2.x, pos_cloud2.y);
      x_ball = 300;
      y_ball = 300;
    } else if (functionality == "Enter") {
      isHomeScreen = false;
      isGameScreen = false;
      isLoserScreen = false;
      isWinnerScreen = false;
      isTopScoresScreen = true;
    } else if (functionality == "home") {
      isHomeScreen = true;
      isGameScreen = false;
      isLoserScreen = false;
      isWinnerScreen = false;
      isTopScoresScreen = false;
      Current_Player_Score = 0;
      pos_cloud1 = new PVector(-300, 300);
      pos_cloud2 = new PVector(300, 0);
      vel = new PVector(10, 0);
      vel_cloud2 = new PVector(-15, 0);
      cloud1.displayCloud(pos_cloud1.x, pos_cloud1.y);
      cloud2.displayCloud(pos_cloud2.x, pos_cloud2.y);
      x_ball = 300;
      y_ball = 300;
    }
  }
}
