
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

void ShowNetwork(int i){
  if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements);
  if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements);
  // flock.elements[i].ShowRadius();
}

void ShowNetwork(int i, PVector posCM){
  if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements, posCM);
  if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements, posCM);
  // flock.elements[i].ShowRadius();
}

/// ====================================== /// ====================================== ///

void radio(float rr){
  for(Agent2D o : flock.elements){
    o.r = rr;
  }
}

/// ====================================== /// ====================================== ///

void reset(){

  float l = tam*r;

  for(Agent2D o : flock.elements){
    o.pos.set(random(-l, l), random(-l, l));
    o.vel = PVector.random2D();
    o.vel.mult(vo);
  }

  // pred.pos.set(random(-l, l), random(-l, l));
  // pred.vel = PVector.random2D();
  // pred.vel.mult(vo);

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
    flock.elements[0].vel.rotate(i*PI);
    flock.elements[0].Move(dt);

    i += 0.001;
  }

  // for (int i = 0; i < numPerts; ++i) {
  //   if(movePert == 1){
  //     flock.elements[i].Move(2*dt);
  //     println("movePert: " + movePert);
  //   }
  // }

}

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