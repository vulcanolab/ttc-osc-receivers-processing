void swirl (float x, float y, PImage img){
  //x et y sont les coordonées du doigt
  int x1 = x - r < 0 ? 0 : int(x) - r;
  int x2 = x + r > width ? width : int(x) + r;
  int y1 = y - r < 0 ? 0 : int(y) - r;
  int y2 = y + r > height ? height : int(y) + r;
  PVector m = new PVector(x, y);
  
  for (int i = x1; i < x2; i ++) {
    for (int j = y1; j < y2; j ++) {
      PVector p = new PVector(i, j);
      p.sub(m);
      float l = p.mag();
      if (l < r) {
        p.rotate(map(l, 0, r, rot, 0));        
        p.add(m);
        int newX = round(constrain(p.x, 0, width-1));
        int newY = round(constrain(p.y, 0, height-1));
        pixels[j * width + i] = img.pixels[newY * width + newX];
      }
    }
  }
}
