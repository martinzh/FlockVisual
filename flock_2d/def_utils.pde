
/// ====================================== /// ====================================== ///
  void setupSystem(){
        // r = vo * dt / l;
    r       = vo / l;
    n       = (int)(r*r*p);
    
    flock   = new Flock(n,tam*r,vo,k,r);

    flockCPY   = new Flock(flock);

    ruido  = new float[n];
    vecPsi = new PVector();
    velPert = new PVector(flock.elements[partPert].vel.x,flock.elements[partPert].vel.y);
    
  }

/// ====================================== /// ====================================== ///

  void setupSystemPred(){
        // r = vo * dt / l;
    r       = vo / l;
    n       = (int)(r*r*p);
    
    pred    = new Agent2D(0.0,vo,0,r);
    flock   = new Flock(n,tam*r,vo,k,r);
    ruido  = new float[n];
    velPert = new PVector();

  }


/// ====================================== /// ====================================== ///

float Factorial(int n){

   int fact = 1;

   for (int i = 2; i <= n ; ++i) {
      fact = fact * i;
   }

   return (float)fact;

}

/// ====================================== /// ====================================== ///

float Fact_Aprox(int n){

   float x = (float)n;

   float fact = sqrt(2*PI*x)*exp((x*log(x))-x);

   return fact;
}

/// ====================================== /// ====================================== ///

public static int getPoisson(double lambda) {
  double L = Math.exp(-lambda);
  double p = 1.0;
  int k = 0;

  do {
    k++;
    p *= Math.random();
  } while (p > L);

  return k - 1;
}

/// ====================================== /// ====================================== ///

void arrow(float x1, float y1, float x2, float y2) {

  float s = 1.3;

  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -s, -s);
  line(0, 0, s, -s);
  popMatrix();
} 

/// ====================================== /// ====================================== ///

 void calcPsi(Flock flock){

    vecPsi.x = 0.0;
    vecPsi.y = 0.0;
    
    for (Agent2D part : flock.elements) {
      vecPsi.add(part.vel);
    }

    psi = sqrt(vecPsi.x * vecPsi.x + vecPsi.y * vecPsi.y)/float(flock.elements.length);

 }

/// ====================================== /// ====================================== ///

void ShowNetwork(Flock flock, int i){
  if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements);
  if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements);
  // flock.elements[i].ShowRadius();
}

void ShowNetwork(Flock flock, int i, PVector posCM){
  if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements, posCM);
  if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements, posCM);
  // flock.elements[i].ShowRadius();
}

/// ====================================== /// ====================================== ///

void ShowVels(Flock flock, int i, PVector posCM){
    if(full == 1) flock.elements[i].ShowPoint(flock.posCM);
    if(fluct == 1) flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM);
}

void ShowVels(Flock flock, int i, PVector posCM, int col, int full, int fluct){
    if(full == 1) flock.elements[i].ShowPoint(flock.posCM, col);
    if(fluct == 1) flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM);
}

/// ====================================== /// ====================================== ///

void ShowPerts(){
  if(pert == 1) {
    for (int j = 0; j < numPerts; ++j) {
      flock.elements[j].ShowPertPoint(flock.posCM, col);
    }
  }
}

void ShowPerts(int partPert){
    if(pert == 1) {
      flockCPY.elements[partPert].ShowPertPoint(flockCPY.posCM, col);
  }
}

/// ====================================== /// ====================================== ///

void drawPartsAndVels(Flock flock){
    for(int i = 0; i < n; i ++){
      // ShowNetwork(i);
      ShowNetwork(flock, i, flock.posCM);
      ShowVels(flock, i, flock.posCM);
  }
}

void drawPartsAndVels(Flock flock, int col, int full, int fluct){
    for(int i = 0; i < n; i ++){
      // ShowNetwork(i);
      ShowNetwork(flock, i, flock.posCM);
      ShowVels(flock, i, flock.posCM, col, full, fluct);
  }
}

void drawDiff(){

  colorMode(HSB);
  stroke(120,200,200,80);
  float x, xc, y, yc;

  for(int i = 0; i < flock.elements.length; i ++){

    x = flock.elements[i].pos.x - flock.posCM.x;
    y = flock.elements[i].pos.y - flock.posCM.y;

    xc = flockCPY.elements[i].pos.x - flockCPY.posCM.x;
    yc = flockCPY.elements[i].pos.y - flockCPY.posCM.y;

    arrow(x,y,xc,yc);
  }
}
/// ====================================== /// ====================================== ///
  
void setRuido(){
  for (int i = 0; i < ruido.length; ++i) {
    ruido[i] = random(-PI,PI)*eta;
  }
}

/// ====================================== /// ====================================== ///

// void radio(float rr){
//   for(Agent2D o : flock.elements){
//     o.r = rr;
//   }
// }

/// ====================================== /// ====================================== ///

void reset(){

  float l = tam*r;

  int n = flock.elements.length;

  for(int i = 0; i < n; i++){

    flock.elements[i].pos.set(random(-l, l), random(-l, l));
    flock.elements[i].vel = PVector.random2D();
    flock.elements[i].vel.mult(vo);

    flockCPY.elements[i].pos.set(flock.elements[i].pos);
    flockCPY.elements[i].vel.set(flock.elements[i].vel);

  }

  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
        flock.locAdjs[i][j] = 0.0;
        flockCPY.locAdjs[i][j] = 0.0;
      }
  }

  for (int i = 0; i < n; ++i) {
      flock.locAngs[i] = flock.inAngs[i] = 0.0;
      flockCPY.locAngs[i] = flockCPY.inAngs[i] = 0.0;
    }

  flock.calcCM();
  flockCPY.calcCM();

}

/// ====================================== /// ====================================== ///

void clear_back(){
  bac = 255;
}

/// ====================================== /// ====================================== ///

float calc_ang(PVector v1, PVector v2){

  float a1 = atan2(v1.y,v1.x);
  float a2 = atan2(v2.y,v2.x);

  return a2-a1;
}

/// ====================================== /// ====================================== ///

void applyPert(){
  for (int i = 0; i < numPerts; ++i) {
    flock.elements[i].vel.rotate(pertMag*PI);
    if(movePert == 1){
      flock.elements[i].Move(2*dt);
      println("movePert: " + movePert);
    }
  }
}

/// ====================================== /// ====================================== ///

void rampPert(){

  float i = 0;

  while (i < 0.5) {
    // flock.elements[0].Move(dt);
    flock.elements[0].vel.rotate(i*PI);

    i += 0.001;
  }

}

/// ====================================== /// ====================================== ///

void slctP(){
  partPert = int(random(0, flock.elements.length));
  velPert.set(flock.elements[partPert].vel);
}


void setPred(){
  velPert.set(flock.elements[partPert].vel);
}

void turnVelPert(int sign){

    // float dot = velPert.x * flock.elements[partPert].vel.x + velPert.y * flock.elements[partPert].vel.y;

    // println("dot: "+dot);

  // if (dot > 0.0) {
      if (sign == 0) {
        velPert.rotate(radians(speed));
      }else{
        velPert.rotate(-1.0*radians(speed));
      }  
  // }
    // println("velPert: "+velPert);
    // println("pred.vel: "+pred.vel);
  }

/// ====================================== /// ====================================== ///

// void perturbation(){
//     pred.Move(2*dt);
// }

/// ====================================== /// ====================================== ///

// void pred_update(int p){
//  pred.Show_Pred();
//  // pred.Show_Pred();
//  // if (p ==1) pred.Move(dt);
//  pred.pos.x = mouseX - width/2;
//  pred.pos.y = mouseY - height/2;

//  pred.vel.x = mouseX - pmouseX;
//  pred.vel.y = mouseY - pmouseY;
// }

/// ====================================== /// ====================================== ///