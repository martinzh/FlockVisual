//---------------------------------------//
// Definicion de la clase Agent
//---------------------------------------//

class Agent2D
{
    // L --> tamanio de la caja (cubica) 
    // V --> vel maxima
    // k --> numero de interacciones

    float arr = 5.0; // longitud de la flecha

    PVector pos, vel;
    int[] links;
    float r;
    int id;

/// ====================================== /// ====================================== ///

    Agent2D(float l, float v, int k, float r, int id)
    {
        this.pos = new PVector(random(-l, l), random(-l, l));
        this.vel = new PVector().random2D();

        this.vel.mult(v);

        links = new int[k];
        this.r = r;
        this.id = id;
    }

/// ====================================== /// ====================================== ///

    Agent2D(float l, float v, int k, float r)
    {
        this.pos = new PVector(random(-l, l), random(-l, l));
        this.vel = new PVector().random2D();
        
        this.vel.mult(v);

        links = new int[k];
        this.r = r;
        this.id = 0;
    }

/// ====================================== /// ====================================== ///

     void Move(float dt){

        PVector paso = PVector.mult(vel,dt);
        pos.add(paso);
    }

/// ====================================== /// ====================================== ///

    void Show(){
        stroke(255);
        ellipse(this.pos.x, this.pos.y, 10, 10);
        line(this.pos.x, this.pos.y, this.pos.x + arr*this.vel.x , this.pos.y + arr*this.vel.y);
    }

/// ====================================== /// ====================================== ///

    void Show(int c){
        stroke(map(c,0,n,0,255),255,255);
        ellipse(this.pos.x, this.pos.y, 10, 10);
        line(this.pos.x, this.pos.y, this.pos.x + arr*this.vel.x , this.pos.y + arr*this.vel.y);
    }

/// ====================================== /// ====================================== ///

    void Show_Pred(){
        colorMode(RGB);
        stroke(0,0,255);
        ellipse(this.pos.x, this.pos.y, 5, 5);
        // line(this.pos.x, this.pos.y, this.pos.x + arr*this.vel.x , this.pos.y + arr*this.vel.y);
        arrow(this.pos.x, this.pos.y, this.pos.x + 2*arr*this.vel.x, this.pos.y + 2*arr*this.vel.y);
    }

/// ====================================== /// ====================================== ///

    void ShowPoint(){
        stroke(255);
        // point(pos.x,pos.y);
        line(this.pos.x, this.pos.y, this.pos.x + arr*this.vel.x , this.pos.y + arr*this.vel.y);
    }

    void ShowPoint(PVector posCM){
        strokeWeight(0.5);
        stroke(255,150);
        // point(pos.x,pos.y);
        float x = this.pos.x - posCM.x;
        float y = this.pos.y - posCM.y;

        // line( x , y , x + 3*this.vel.x , y + 3*this.vel.y);
        arrow(x, y, x + arr*this.vel.x, y + arr*this.vel.y);
    }

    void ShowPoint(PVector posCM, float col){

        strokeWeight(1);
        colorMode(HSB);
        stroke(col,255,255);
        // point(pos.x,pos.y);
        float x = this.pos.x - posCM.x;
        float y = this.pos.y - posCM.y;

        // line( x , y , x + 3*this.vel.x , y + 3*this.vel.y);
        arrow(x, y, x + 3*arr*this.vel.x, y + 3*arr*this.vel.y);
        noFill();
        ellipse(x, y, 10, 10);
        colorMode(RGB);
    }

/// ====================================== /// ====================================== ///

    void ShowFluctVel(PVector posCM, PVector velCM){

        float s = 0.0;

        // point(pos.x,pos.y);
        float x = this.pos.x - posCM.x;
        float y = this.pos.y - posCM.y;

        float ux = this.vel.x - velCM.x;
        float uy = this.vel.y - velCM.y;

        PVector u = new PVector(ux,uy);

        float ang = calc_ang(u,velCM);

        // double ang = Math.acos(Math.toRadians(u.x * velCM.x + u.y * velCM.y));

        strokeWeight(0.5);
        colorMode(HSB);

        stroke(map(ang,PI,-PI,0,255),255,255);
        
        // stroke(map((float)ang,0,PI,0,255),255,255);

        arrow(x, y, x + arr*(ux + s), y + arr*(uy + s) );

        colorMode(RGB);

    }

    void ShowFluctVel(PVector posCM, PVector velCM, PVector vecPert, int col){

        float s = 0.09;

        // point(pos.x,pos.y);
        float x = this.pos.x - posCM.x;
        float y = this.pos.y - posCM.y;

        float ux = this.vel.x - vecPert.x;
        float uy = this.vel.y - vecPert.y;

        PVector u = new PVector(ux,uy);

        // PVector pVec = new PVector(vecPert.x - velCM.x, vecPert.y - velCM.y );

        float ang = calc_ang(u,vecPert);

        strokeWeight(0.5);
        colorMode(HSB);

        stroke(map(ang,-PI,PI,col,255),255,255);
        arrow(x, y, x + arr*(ux + s), y + arr*(uy + s) );

        colorMode(RGB);

    }

/// ====================================== /// ====================================== ///

    void ShowTopoLinks(Agent2D[] elements){

        stroke(255,0,0);
        strokeWeight(0.5);

        for (int x : links) {
            line(pos.x, pos.y, elements[x].pos.x , elements[x].pos.y);
            // println(x);
        }
    }

    void ShowTopoLinks(Agent2D[] elements, PVector posCM){

        stroke(255,0,0);
        strokeWeight(0.5);

        for (int k : links) {

            float x1 = pos.x - posCM.x;
            float y1 = pos.y - posCM.y;

            float x2 = elements[k].pos.x - posCM.x;
            float y2 = elements[k].pos.y - posCM.y;

            line(x1, y1, x2, y2);
        }
    }

/// ====================================== /// ====================================== ///

    void ShowGeomLinks(Agent2D[] elements){
        
        stroke(0,0,255);
        strokeWeight(0.5);

        for (Agent2D o : elements) {
            if ( pos.dist(o.pos) <= r && pos.dist(o.pos) > 0 ) {
                line(pos.x, pos.y, o.pos.x , o.pos.y);
            }
        }
    }

    void ShowGeomLinks(Agent2D[] elements, PVector posCM){

        colorMode(HSB);
        stroke(50,200,200,150);
        strokeWeight(0.5);

        for (Agent2D o : elements) {
            if ( pos.dist(o.pos) <= r && pos.dist(o.pos) > 0 ) {

            float x1 = pos.x - posCM.x;
            float y1 = pos.y - posCM.y;

            float x2 = o.pos.x - posCM.x;
            float y2 = o.pos.y - posCM.y;

            line(x1, y1, x2, y2);
            }
        }
    }

/// ====================================== /// ====================================== ///

    void ShowRadius(){
        stroke(0,255,0);
        ellipse(pos.x, pos.y, r, r);
    }

/// ====================================== /// ====================================== ///

    public void AlignTopo(Agent2D[] elements){ // con respecto a su vecindad topologica

        // se inicializa como la vel propia para considerarla en el prom    
        // PVector prom = new PVector(vel.x, vel.y);
        PVector prom = new PVector();

        float n = (float)links.length;

        if (n != 0 ) {
            for (int x : links) {
                prom.add(elements[x].vel);
            }
            prom.mult(1/(n));
            // prom.mult(1/(n+1));
        }

        if (vel.magSq() != 0 && prom.magSq() != 0) {

            float phi = PI;

            float ang = omega * ( PVector.angleBetween(vel,prom) + eta *random(-phi, phi)) ;
            // println("ang: "+ang);
            // println(vel);
            vel.rotate(ang);
        } 
    }

/// ====================================== /// ====================================== ///

    public void AlignGeom(Agent2D[] elements){ // con respecto a su vecindad topologica

        // se inicializa como la vel propia para considerarla en el prom    
        PVector prom = new PVector(vel.x, vel.y);

        float n = 1;

        for (Agent2D o : elements) {

            float d = pos.dist(o.pos);

            if ( d > 0 && d <= r ) {
                   // println( "r: "+ r + "\td: "+ d);
                   prom.add(o.vel);
                   n += 1;
            }
        }

        prom.mult(1/(n));

        if (vel.magSq() != 0 && prom.magSq() != 0 ) {

            float phi = PI;

            float ang = (1-omega) * ( PVector.angleBetween(vel,prom) + eta * random(-phi, phi)) ;
            // println("ang: "+ang);
            // println(vel);
            vel.rotate(ang);
        } 
    }

/// ====================================== /// ====================================== ///

    public void AlignBoth(Agent2D[] elements){ // con respecto a su vecindad topologica

        // se inicializa como la vel propia para considerarla en el prom    
        // PVector prom = new PVector(vel.x, vel.y);
        PVector prom_topo = new PVector();

        float n_t = (float)links.length;

        if (n_t != 0 ) {
            for (int x : this.links) {
                prom_topo.add(elements[x].vel);
            }
            prom_topo.div(n_t);
        }

    //=============================================================================

        // se inicializa como la vel propia para considerarla en el prom    
        PVector prom_geom = new PVector(vel.x, vel.y);

        float n_g = 1;
        float ang_top = 0;
        float ang_geom = 0;

        for (Agent2D o : elements) {

            float d = pos.dist(o.pos);

            if ( d > 0 && d <= r ) {
                   // println( "r: "+ r + "\td: "+ d);
                   prom_geom.add(o.vel);
                   n_g += 1;
            }
        }

        // if (n_g != 0) prom_geom.mult(1/(n_g+1));
        prom_geom.div(n_g);

    //=============================================================================

        float phi = PI;

        if (vel.magSq() != 0 && prom_topo.magSq() != 0) {


            ang_top =  calc_ang(vel,prom_topo) ;
            // println(vel);
            // vel.rotate(ang);
        } 

        if (vel.magSq() != 0 && prom_geom.magSq() != 0 ) {
            ang_geom = calc_ang(vel,prom_geom) ;
            // println(vel);
            // vel.rotate(ang);
        } 

        float ang = omega * ang_top + (1-omega) * ang_geom + eta*random(-phi,phi);

        // println("ang_top: "+ ang_top + "\tang_geom: "+ ang_geom + "\tang: "+ ang);

        vel.rotate(ang);

    }

/// ====================================== /// ====================================== ///

    void Predator( Agent2D pred, float dt){

        if (pos.dist(pred.pos) <= 10*r ) {
            float ang = calc_ang(vel,pred.vel) ;
            vel.rotate(-ang/4);
            Move(4*dt);
        }
    }

/// ====================================== /// ====================================== ///

};