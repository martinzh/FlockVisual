//---------------------------------------//
// Definicion de la clase Flock
//---------------------------------------//

class Flock
{
    float arr = 5.0;
    
    Agent2D[] elements;

    float[][] locAdjs;
    float[] locAngs;
    float[] inAngs;

    PVector posCM;
    PVector velCM;

/// ====================================== /// ====================================== ///

    Flock(int n, float l, float v, int k, float r)
    {
        elements = new Agent2D[n];
        
        posCM = new PVector();
        velCM = new PVector();

        locAdjs = new float[n][n];
        locAngs = new float[n];
        inAngs  = new float[n];
        ruido  = new float[n];

        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent2D(l, v, k, r);

            for (int j = 0; j < elements[i].links.length; j++) //generar enlaces con otros agentes arbitrarios
            {
                elements[i].links[j] = int(random(n));
            }
        }

        for (int i = 0; i < n; ++i) {
          for (int j = 0; j < n; ++j) {
            locAdjs[i][j] = 0.0;
          }
        }

        for (int i = 0; i < n; ++i) {
          locAngs[i] = inAngs[i] = 0.0;
        }

    }

/// ====================================== /// ====================================== ///

    Flock(Flock flock) // replica
    {
        elements = new Agent2D[n];
        
        posCM = new PVector(flock.posCM.x, flock.posCM.y);
        velCM = new PVector(flock.velCM.x, flock.posCM.y);

        locAdjs = new float[n][n];
        locAngs = new float[n];
        inAngs  = new float[n];
        ruido  = new float[n];

        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent2D(flock.elements[i]);

        }

        for (int i = 0; i < n; ++i) {
          for (int j = 0; j < n; ++j) {
            locAdjs[i][j] = 0.0;
            // locAdjs[i][j] = flock.locAdjs[i][j];
          }
        }

        for (int i = 0; i < n; ++i) {
          locAngs[i] = inAngs[i] = 0.0;

          // locAngs[i] = flock.locAngs[i];
          // inAngs[i] = flock.inAngs[i];
        }

    }

/// ====================================== /// ====================================== ///


    Flock(int n, float l, float v, float r)  // numero de links de poisson
    {
        elements = new Agent2D[n];

        locAdjs = new float[n][n];
        locAngs = new float[n];
        inAngs  = new float[n];
        ruido  = new float[n];

        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent2D(l, v, getPoisson(2), r);

            for (int j = 0; j < elements[i].links.length; j++) //generar enlaces con otros agentes arbitrarios
            {
                elements[i].links[j] = int(random(n));
            }
        }

        for (int i = 0; i < n; ++i) {
          for (int j = 0; j < n; ++j) {
            locAdjs[i][j] = 0.0;
          }
        }

        for (int i = 0; i < n; ++i) {
          locAngs[i] = inAngs[i] = 0.0;
        }
    }

/// ====================================== /// ====================================== ///

    void calcCM(){

        posCM.set(0.0,0.0);
        velCM.set(0.0,0.0);

        for(Agent2D agent : elements){
            posCM.add(agent.pos);
            velCM.add(agent.vel);
        }

        // posCM.div(float(flock.elements.length));
        // velCM.div(float(flock.elements.length));

        posCM.div(float(this.elements.length));
        velCM.div(float(this.elements.length));

    }

/// ====================================== /// ====================================== ///

    void showCM(){

        colorMode(RGB);

        float mult = 3.0;

        stroke(255,0,0);
        strokeWeight(1);

        arrow(0, 0, mult*arr * this.velCM.x, mult*arr * this.velCM.y);

    }

    void showCM(int col){

        colorMode(HSB);

        float mult = 3.0;

        stroke(col,200,200);

        strokeWeight(1);

        arrow(0, 0, mult * arr * this.velCM.x, mult * arr * this.velCM.y);

    }

/// ====================================== /// ====================================== ///

    void setSR() {

        float d;
        float r = elements[0].r;

        for (int i = 0; i < elements.length; ++i) {
            for (int j = i+1; j < elements.length; ++j) {
                d = elements[i].pos.dist(elements[j].pos);
                if (d <= r) {
                    locAdjs[i][j] = locAdjs[j][i] = 1.0;
                }
            }
        }

    }

/// ====================================== /// ====================================== ///

    void getAngs() {

        PVector vProm = new PVector();
        float k = 0.0;

        for (int i = 0; i < elements.length; ++i) {
            // vProm.x = 0.0;
            // vProm.y = 0.0;
            vProm.set(0.0,0.0);
            k = 0.0;
            for (int j = 0; j < elements.length; ++j) {
                vProm.add(PVector.mult(elements[j].vel,locAdjs[i][j]));
                k += locAdjs[i][j];
            }
            if (k > 0.0) {
                locAngs[i] = calc_ang(elements[i].vel,PVector.div(vProm,k));
            }else {
                locAngs[i] = 0.0;
            }
        }
    }

/// ====================================== /// ====================================== ///

    void getAngsIN() {

        PVector vProm = new PVector();
        float k = elements[0].links.length;

        for (int i = 0; i < elements.length; ++i) {
            // vProm.x = 0.0;
            // vProm.y = 0.0;
            vProm.set(0.0,0.0);
            for (int j = 0; j < k; ++j) {
                vProm.add(elements[elements[i].links[j]].vel);
            }
            if (k > 0.0) {
                inAngs[i] = calc_ang(elements[i].vel,PVector.div(vProm,k));
            }else {
                inAngs[i] = 0.0;
            }
        }
    }

/// ====================================== /// ====================================== ///

    void updateVels(float[] ruido){
        
        setSR();
        getAngs();
        getAngsIN();

        float ang_tot = 0.0;

        for (int i = 0; i < elements.length; ++i) {

            ang_tot = (omega * inAngs[i]) + ((1.0 - omega) * locAngs[i]) + ruido[i];
            elements[i].vel.rotate(ang_tot);
        }

    }
    
    void updateVelsPert(float[] ruido, PVector velPert, int partPert){
        
        setSR();
        getAngs();
        getAngsIN();

        float ang_tot = 0.0;

        for (int i = 0; i < elements.length; ++i) {

            if (i != partPert) {
                ang_tot = omega * (inAngs[i]) + (1.0 - omega) * (locAngs[i]) + ruido[i];
                elements[i].vel.rotate(ang_tot);
            }
        }

        // elements[partPert].vel.x = velPert.x;
        // elements[partPert].vel.y = velPert.y;
        
        elements[partPert].vel.set(velPert);
    }

/// ====================================== /// ====================================== ///

    void Update(float dt, int go, float[] ruido){

        calcCM();

        if (go ==1){

            updateVels(ruido);

            for(Agent2D agent : elements){
                    agent.Move(dt);
                }
        }
    }

    void Update(float dt, int go, float[] ruido, PVector velPert, int partPert){

        calcCM();

        if (go ==1){

            updateVelsPert(ruido, velPert, partPert);

            for(Agent2D agent : elements){
                    agent.Move(dt);
                }
        }
    }

/// ====================================== /// ====================================== ///

//     IntList GetGeomNeigh(Agent2D part){

//         IntList neigh = new IntList();

//         for (int j = 0; j < elements.length; ++j) {

//             float d = part.pos.dist(elements[j].pos);

//             if ( d > 0 && d <= part.r){
//             // neigh.append(elements[j].id);
//             neigh.append(j);
//             }
//         }
//         return neigh;
//     }

// /// ====================================== /// ====================================== ///

//     void ChangeID(IntList neigh, Agent2D part, int nb){

//         part.id = nb;

//         for (int i : neigh) {
//             elements[i].id = part.id;
//         }
//     }

// /// ====================================== /// ====================================== ///

//     void Cluster(){

//         IntList neigh = new IntList();

//         IntList clust_size = new IntList();

//         int cluster = 0;

//         elements[0].id = 0;   
        
//         for (int i = 0; i < elements.length; ++i) {
            
//             neigh = GetGeomNeigh(elements[i]);
//             ChangeID(neigh,elements[i],cluster);

//             // while(neigh.size() > 0){


//             // }
//         }
//     }

/// ====================================== /// ====================================== ///

};
