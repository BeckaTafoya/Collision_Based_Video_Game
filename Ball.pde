class Ball {
  PVector loc;
  // Constructors
  Ball () {
    this.loc = new PVector(300, 300);
  }
  // Methods
  void display(float x, float y) {
    pushMatrix();
    translate(x, y);
    fill(#FC0D0D);
    stroke(#B90404);
    strokeWeight(10);
    ellipse(0, 0, 100, 100);
    pushMatrix();
    float rot = PI*sin(time*0.1)+PI;
    rotate(rot);
    image(flower, 0, 0, 100, 100);
    popMatrix();
    popMatrix();
  }
}
