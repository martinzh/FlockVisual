//---------------------------------------//
// Definicion de la clase Agent
//---------------------------------------//

class Agent2D
{
    // L --> tamanio de la caja (cubica) 
    // V --> vel maxima
    // k --> numero de interacciones

    PVector pos, vel;
    int[] links;
    float r;
    int id;

    Agent2D(float l, float v, int k, float r, int id)
    {
        this.pos = new PVector(random(-l, l), random(-l, l));
        this.vel = new PVector().random2D();
        
        // this.vel = PVector.random2D();

        this.vel.mult(v);

        links = new int[k];
        this.r = r;
        this.id = id;
    }

    Agent2D(float l, float v, int k, float r)
    {
        this.pos = new PVector(random(-l, l), random(-l, l));
        this.vel = new PVector().random2D();
        
        // this.vel = PVector.random2D();

        this.vel.mult(v);

        links = new int[k];
        this.r = r;
        this.id = 0;
    }

     void Move(float dt){

        // PVector paso = vel.mult(dt);
        PVector paso = PVector.mult(vel,dt);
        pos.add(paso);
    }

    void Show(){
        stroke(255);
        ellipse(this.pos.x, this.pos.y, 10, 10);
        line(this.pos.x, this.pos.y, this.pos.x + 3*this.vel.x , this.pos.y + 3*this.vel.y);
    }

    void Show(int c){
        stroke(map(c,0,n,0,255),255,255);
        ellipse(this.pos.x, this.pos.y, 10, 10);
        line(this.pos.x, this.pos.y, this.pos.x + 3*this.vel.x , this.pos.y + 3*this.vel.y);
    }

    void Show_Pred(){
        stroke(255,255,255);
        ellipse(this.pos.x, this.pos.y, 10, 10);
        line(this.pos.x, this.pos.y, this.pos.x + 3*this.vel.x , this.pos.y + 3*this.vel.y);
    }

    void ShowPoint(){
        stroke(255);
        // point(pos.x,pos.y);
        line(this.pos.x, this.pos.y, this.pos.x + 3*this.vel.x , this.pos.y + 3*this.vel.y);
        
    }

    void ShowTopoLinks(Agent2D[] elements){
        stroke(255,0,0);
        for (int x : links) {
            line(pos.x, pos.y, elements[x].pos.x , elements[x].pos.y);
            // println(x);
        }
    }

    void ShowGeomLinks(Agent2D[] elements){
        stroke(0,0,255);
        for (Agent2D o : elements) {
            if ( pos.dist(o.pos) <= r && pos.dist(o.pos) > 0 ) {
                line(pos.x, pos.y, o.pos.x , o.pos.y);
            }
        }
    }

    void ShowRadius(){
        stroke(0,255,0);
        ellipse(pos.x, pos.y, r, r);
    }

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

            float ang = w * ( PVector.angleBetween(vel,prom) + h *random(-phi, phi)) ;
            // println("ang: "+ang);
            // println(vel);
            vel.rotate(ang);
        } 
    }

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

            float ang = (1-w) * ( PVector.angleBetween(vel,prom) + h * random(-phi, phi)) ;
            // println("ang: "+ang);
            // println(vel);
            vel.rotate(ang);
        } 
    }

    public void AlignBoth(Agent2D[] elements){ // con respecto a su vecindad topologica

        // se inicializa como la vel propia para considerarla en el prom    
        // PVector prom = new PVector(vel.x, vel.y);
        PVector prom_topo = new PVector();

        float n_t = (float)links.length;

        if (n_t != 0 ) {
            for (int x : this.links) {
                prom_topo.add(elements[x].vel);
            }
            prom_topo.mult(1/(n_t));
            // prom.mult(1/(n+1));
        }

        //======================================================================================================

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
        prom_geom.mult(1/(n_g));

        //======================================================================================================

        float phi = PI;

        if (vel.magSq() != 0 && prom_topo.magSq() != 0) {


            // ang_top =  PVector.angleBetween(vel,prom_topo) + ht*random(-phi, phi) ;
            // ang_top =  calc_ang(vel,prom_topo) + ht*random(-phi, phi) ;
            ang_top =  calc_ang(vel,prom_topo) ;
            // println(vel);
            // vel.rotate(ang);
        } 

        // if (vel.magSq() != 0 && prom_geom.magSq() != 0 && n_g != 0) {
        if (vel.magSq() != 0 && prom_geom.magSq() != 0 ) {
            // ang_geom = PVector.angleBetween(vel,prom_geom) + hg*random(-phi, phi) ;
            // ang_geom = calc_ang(vel,prom_geom) + hg*random(-phi, phi) ;
            ang_geom = calc_ang(vel,prom_geom) ;
            // println(vel);
            // vel.rotate(ang);
        } 

        float ang = w * ang_top + (1-w) * ang_geom + h*random(-phi,phi);

        // println("ang_top: "+ ang_top + "\tang_geom: "+ ang_geom + "\tang: "+ ang);

        vel.rotate(ang);

    }

    void Predator( Agent2D pred, float dt){

        if (pos.dist(pred.pos) <= 10*r ) {
            float ang = calc_ang(vel,pred.vel) ;
            vel.rotate(-ang/4);
            Move(4*dt);
        }
    }
};