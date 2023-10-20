class Cloud {
  float R_middle_circle = 100;
  float R_side_circle = 75;

  PVector loc_CenterCircle;
  PVector loc_LeftCircle;
  PVector loc_RightCircle;

  // Constructors

  Cloud () {
    this.loc_CenterCircle = new PVector(0.0, 0.0);
    this.loc_LeftCircle = new PVector(0.0, 0.0);
    this.loc_RightCircle = new PVector(0.0, 0.0);
  }

  //Methods
  void displayCloud(float x_loc_fromCenter, float y_loc_fromCenter) {
    noStroke();
    fill(255);
    pushMatrix();
    translate(x_loc_fromCenter, y_loc_fromCenter);
    pushMatrix();
    ellipse(width/2, height/2, R_middle_circle, R_middle_circle);
    ellipse(width/2-R_side_circle*sin(40), height/2-R_side_circle*cos(40), R_side_circle, R_side_circle);
    ellipse(width/2+R_side_circle*sin(40), height/2-R_side_circle*cos(40), R_side_circle, R_side_circle);
    rectMode(CENTER);
    rect(width/2, height/2-R_side_circle*cos(40), R_side_circle+25, R_side_circle);
    popMatrix();
    popMatrix();

    loc_CenterCircle.x = x_loc_fromCenter + width/2;
    loc_CenterCircle.y = y_loc_fromCenter + height/2;

    loc_LeftCircle.x = x_loc_fromCenter + width/2-R_side_circle*sin(40);
    loc_LeftCircle.y = y_loc_fromCenter + height/2-R_side_circle*cos(40);

    loc_RightCircle.x = x_loc_fromCenter + width/2+R_side_circle*sin(40);
    loc_RightCircle.y = y_loc_fromCenter + height/2-R_side_circle*cos(40);
  }

  PVector ReturnCloud_CenterCircle_Loc() {
    return loc_CenterCircle;
  }

  PVector ReturnCloud_LeftCircle_Loc() {
    return loc_LeftCircle;
  }

  PVector ReturnCloud_RightCircle_Loc() {
    return loc_RightCircle;
  }

  boolean checkCollision(float xball, float yball) {
    // Ball will remain at y = 300, x will move between 0 and 600.
    float xc_Ball = xball;
    float yc_Ball = yball;

    //check center cloud circle.
    float xc_centerCloud = ReturnCloud_CenterCircle_Loc().x;
    float yc_centerCloud = ReturnCloud_CenterCircle_Loc().y;
    float xc_dist_from_centerCloud = xc_centerCloud - xc_Ball;
    float yc_dist_from_centerCloud = yc_centerCloud - yc_Ball;
    float dist_from_centerCloud = sqrt(xc_dist_from_centerCloud*xc_dist_from_centerCloud + yc_dist_from_centerCloud*yc_dist_from_centerCloud);
    boolean collision_w_centerCloudCircle = dist_from_centerCloud<R_middle_circle/2+50;

    //check left cloud circle.
    float xc_leftCloud = ReturnCloud_LeftCircle_Loc().x;
    float yc_leftCloud = ReturnCloud_LeftCircle_Loc().y;
    float xc_dist_from_leftCloud = xc_leftCloud - xc_Ball;
    float yc_dist_from_leftCloud = yc_leftCloud - yc_Ball;
    float dist_from_leftCloud = sqrt(xc_dist_from_leftCloud*xc_dist_from_leftCloud + yc_dist_from_leftCloud*yc_dist_from_leftCloud);
    boolean collision_w_leftCloudCircle = dist_from_leftCloud<R_side_circle/2+50;

    //check right cloud circle.
    float xc_rightCloud = ReturnCloud_RightCircle_Loc().x;
    float yc_rightCloud = ReturnCloud_RightCircle_Loc().y;
    float xc_dist_from_rightCloud = xc_rightCloud - xc_Ball;
    float yc_dist_from_rightCloud = yc_rightCloud - yc_Ball;
    float dist_from_rightCloud = sqrt(xc_dist_from_rightCloud*xc_dist_from_rightCloud + yc_dist_from_rightCloud*yc_dist_from_rightCloud);
    boolean collision_w_rightCloudCircle = dist_from_rightCloud<R_side_circle/2+50;

    if (collision_w_centerCloudCircle || collision_w_leftCloudCircle || collision_w_rightCloudCircle) {
      return true;
    } else {
      return false;
    }
  }
}
