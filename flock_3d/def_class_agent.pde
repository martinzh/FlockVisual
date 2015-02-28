//---------------------------------------//
// Definicion de la clase Agent
//---------------------------------------//

class Agent3D
{
    // L --> tamanio de la caja (cubica) 
    // V --> vel maxima
    // k --> numero de interacciones

    PVector pos, vel;
    int[] links;
    float r;

    Agent3D(float l, float v, int k, float r)
    {

        this.pos = new PVector(random(-l, l), random(-l, l), random(-l, l));
        this.vel = new PVector().random3D();
        
        this.vel.mult(v);

        links = new int[k];
        this.r = r;
    }

     void Move(float dt){
        PVector paso = PVector.mult(vel,dt);
        pos.add(paso);
    }

    void Show(){
        pushMatrix();
        translate(this.pos.x, this.pos.y, this.pos.z);
        noStroke();
        fill(255,200);
        sphere(1);
        stroke(255,200);
        line(0,0,0, 1*this.vel.x , 1*this.vel.y, 1*this.vel.z);
        popMatrix();
    }

    void ShowTopoLinks(Agent3D[] elements){
        stroke(255,0,0,80);
        for (int x : links) {
            line(pos.x, pos.y, pos.z, elements[x].pos.x , elements[x].pos.y, elements[x].pos.z);
            // println(x);
        }
    }

    void ShowGeomLinks(Agent3D[] elements){
        stroke(0,0,255,80);
        for (Agent3D o : elements) {
            if ( pos.dist(o.pos) <= r && pos.dist(o.pos) > 0 ) {
                line(pos.x, pos.y, pos.z, o.pos.x , o.pos.y, o.pos.z);
            }
        }
    }

    public void AlignTopo(Agent3D[] elements){ // con respecto a su vecindad topologica

        // se inicializa como la vel propia para considerarla en el prom    
        PVector prom = new PVector(vel.x, vel.y, vel.z);   

        float n = (float)links.length;

        if (n != 0 ) {
            for (int x : links) {
                prom.add(elements[x].vel);
            }
            prom.mult(1/(n+1));
        }

        if (vel.magSq() != 0 && prom.magSq() != 0) {

            float ang = pt * ( PVector.angleBetween(vel,prom) + ht*random(-PI/2, PI/2)) ;

            PVector axis = new PVector();
            PVector.cross(vel,prom,axis);

            Vec v_axis = new Vec(axis.x,axis.y,axis.z);

            Vec v_vel = new Vec(vel.x,vel.y,vel.z);

            Quat quat = new Quat();

            quat.fromAxisAngle(v_axis,ang);

            v_vel = quat.rotate(v_vel);

            // vel.set(v_vel.vec[0],v_vel.vec[1],v_vel.vec[2]);
            vel.set(v_vel.x(),v_vel.y(),v_vel.z());
        } 
    }

    public void AlignGeom(Agent3D[] elements){ // con respecto a su vecindad geometrica

        // se inicializa como la vel propia para considerarla en el prom    
        PVector prom = new PVector(vel.x, vel.y, vel.z);

        float n = 0;

        for (Agent3D o : elements) {

            float d = pos.dist(o.pos);

            if ( d > 0 && d <= r ) {
                   // println( "r: "+ r + "\td: "+ d);
                   prom.add(o.vel);
                   n += 1;
            }
        }

        // prom.mult(1/(n));

        if (vel.magSq() != 0 && prom.magSq() != 0 && n != 0) {

            prom.mult(1/(n));

            float ang = pg * ( PVector.angleBetween(vel,prom) + hg*random(-PI/2, PI/2)) ;

            PVector axis = new PVector();
            PVector.cross(vel,prom,axis);

            Vec v_axis = new Vec(axis.x,axis.y,axis.z);

            Vec v_vel = new Vec(vel.x,vel.y,vel.z);

            Quat quat = new Quat();

            quat.fromAxisAngle(v_axis,ang);

            v_vel = quat.rotate(v_vel);

            // vel.set(v_vel.vec[0],v_vel.vec[1],v_vel.vec[2]);
            vel.set(v_vel.x(),v_vel.y(),v_vel.z());
        } 
    }

//     public void AlignBoth(Agent3D[] elements){ // con respecto a su vecindad geometrica

//         // se inicializa como la vel propia para considerarla en el prom    
//         PVector prom_top = new PVector(vel.x, vel.y, vel.z);
//         PVector prom_geom = new PVector(vel.x, vel.y, vel.z);

// // ==================================== Prom Geometrico ==============================================


//         float ng = 1;

//         for (Agent3D o : elements) {

//             float d = pos.dist(o.pos);

//             if ( d > 0 && d <= r ) {
//                    // println( "r: "+ r + "\td: "+ d);
//                    prom_geom.add(o.vel);
//                    ng += 1;
//             }
//         }

//         prom_geom.mult(1/(ng));

// // ==================================== Prom Topologico ==============================================

//         float nt = (float)links.length;

//         if (nt != 0 ) {
//             for (int x : links) {
//                 prom_top.add(elements[x].vel);
//             }
//             prom_top.mult(1/(nt+1));
//         }

// // ==================================== Angulos ==============================================        

//         if (vel.magSq() != 0 && prom.magSq() != 0) {

//             float ang = pg * ( PVector.angleBetween(vel,prom) + hg*random(-PI/2, PI/2)) ;

//             PVector axis = new PVector();
//             PVector.cross(vel,prom,axis);

//             Vec v_axis = new Vec(axis.x,axis.y,axis.z);

//             Vec v_vel = new Vec(vel.x,vel.y,vel.z);

//             Quat quat = new Quat();

//             quat.fromAxisAngle(v_axis,ang);

//             v_vel = quat.rotate(v_vel);

//             // vel.set(v_vel.vec[0],v_vel.vec[1],v_vel.vec[2]);
//             vel.set(v_vel.x(),v_vel.y(),v_vel.z());
//         } 
//     }
};