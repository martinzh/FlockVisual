//---------------------------------------//
// Definicion de la clase Flock
//---------------------------------------//

class Flock
{
    // elements --> arreglo con los agentes
    // N --> numero de miembros
    float arr = 5.0;
    
    Agent2D[] elements;
    PVector posCM;
    PVector velCM;

/// ====================================== /// ====================================== ///

    Flock(int n, float l, float v, int k, float r)
    {
        elements = new Agent2D[n];
        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent2D(l, v, k, r, i);

            for (int j = 0; j < elements[i].links.length; j++) //generar enlaces con otros agentes arbitrarios
            {
                elements[i].links[j] = int(random(n));
            }
        }

        posCM = new PVector();
        velCM = new PVector();
    }

/// ====================================== /// ====================================== ///


    Flock(int n, float l, float v, float r)  // numero de links de poisson
    {
        elements = new Agent2D[n];
        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent2D(l, v, getPoisson(2), r, i);

            for (int j = 0; j < elements[i].links.length; j++) //generar enlaces con otros agentes arbitrarios
            {
                elements[i].links[j] = int(random(n));
            }
        }
    }

/// ====================================== /// ====================================== ///

    void calcCM(){

        posCM.x = 0;
        posCM.y = 0;
        
        velCM.x = 0;
        velCM.y = 0;

        for(Agent2D agent : elements){
            posCM.add(agent.pos);
            velCM.add(agent.vel);
        }

        posCM.div(float(flock.elements.length));
        velCM.div(float(flock.elements.length));

    }

/// ====================================== /// ====================================== ///

    void showCM(){

        float mult = 3.0;

        stroke(255,0,0);
        strokeWeight(1);

        arrow(0, 0, mult*arr * velCM.x, mult*arr * velCM.y);

    }

/// ====================================== /// ====================================== ///

    // void setSR(Agent2D[] elements, float[][] locAdjs) {
    void setSR(float[][] locAdjs) {

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

    // void getAngs(Agent2D[] elements, float[][] locAdjs, float[] angs) {
    void getAngs(float[][] locAdjs, float[] angs) {

        PVector vProm = new PVector();
        float k = 0.0;

        for (int i = 0; i < elements.length; ++i) {
            vProm.x = 0.0;
            vProm.y = 0.0;
            k = 0.0;
            for (int j = 0; j < elements.length; ++j) {
                vProm.add(PVector.mult(elements[j].vel,locAdjs[i][j]));
                k += locAdjs[i][j];
            }
            if (k > 0.0) {
                angs[i] = calc_ang(elements[i].vel,PVector.div(vProm,k));
            }else {
                angs[i] = 0.0;
            }
        }
    }

/// ====================================== /// ====================================== ///

    // void getAngsIN(Agent2D[] elements, float[][] locAdjs, float[] angs) {
    void getAngsIN(float[] angs) {

        PVector vProm = new PVector();
        float k = elements[0].links.length;

        for (int i = 0; i < elements.length; ++i) {
            vProm.x = 0.0;
            vProm.y = 0.0;
            for (int j = 0; j < k; ++j) {
                vProm.add(elements[elements[i].links[j]].vel);
            }
            angs[i] = calc_ang(elements[i].vel,PVector.div(vProm,k));
        }
    }

/// ====================================== /// ====================================== ///
    
    void updateVels(float[][] locAdjs, float[] locAngs, float[] inAngs){
        setSR(locAdjs);
        getAngs(locAdjs,locAngs);
        getAngsIN(inAngs);

        float ang_tot = 0.0;

        for (int i = 0; i < elements.length; ++i) {

            // ang_rand = random(-PI, PI);
            // ang_tot = omega * (inAngs[i]) + (1.0 - omega) * (locAngs[i]) + ang_rand*eta;

            ang_tot = omega * (inAngs[i]) + (1.0 - omega) * (locAngs[i]) + random(-PI,PI)*eta;
            elements[i].vel.rotate(ang_tot);
        }

    }
    
/// ====================================== /// ====================================== ///

    // void Update(double dt, double pg, double pt){
    void Update(float dt, int go, float[][] locAdjs, float[] locAngs, float[] inAngs){

        calcCM();

        if (go ==1){

            updateVels(locAdjs, locAngs, inAngs);

            for(Agent2D agent : elements){
                    agent.Move(dt);
                }
        }
    }

/// ====================================== /// ====================================== ///

    // void Update(double dt, double pg, double pt){
    void Update(float dt, int p, Agent2D pred){

        calcCM();

        if (p ==1){
            for(Agent2D agent : elements){
                    agent.AlignBoth(elements);
                    agent.Predator(pred, dt);
                    agent.Move(dt);
                }
        }
    }

/// ====================================== /// ====================================== ///

    void Update(float dt, int p){

        showCM();

        if (p ==1){
            for(Agent2D agent : elements){
                agent.AlignBoth(elements);
                agent.Move(dt);
            }
        }
    }

/// ====================================== /// ====================================== ///

    void Update(float dt, int p, int pert){

        showCM();

        if (pert == 1) {

            if (p ==1){
                for (int i = 0; i < n; ++i) {
                    if(i != 0) flock.elements[i].AlignBoth(elements);
                    flock.elements[i].Move(dt);
                }                
            }
            
        }
        else{

            if (p ==1){
                for(Agent2D agent : elements){
                    agent.AlignBoth(elements);
                    agent.Move(dt);
                }
            }
        }
    }


/// ====================================== /// ====================================== ///


    IntList GetGeomNeigh(Agent2D part){

        IntList neigh = new IntList();

        for (int j = 0; j < elements.length; ++j) {

            float d = part.pos.dist(elements[j].pos);

            if ( d > 0 && d <= part.r){
            neigh.append(elements[j].id);
            }
        }
        return neigh;
    }

/// ====================================== /// ====================================== ///

    void ChangeID(IntList neigh, Agent2D part, int nb){

        part.id = nb;

        for (int i : neigh) {
            elements[i].id = part.id;
        }
    }

/// ====================================== /// ====================================== ///

    void Cluster(){

        IntList neigh = new IntList();

        IntList clust_size = new IntList();

        int cluster = 0;

        elements[0].id = 0;   
        
        for (int i = 0; i < elements.length; ++i) {
            
            neigh = GetGeomNeigh(elements[i]);
            ChangeID(neigh,elements[i],cluster);

            // while(neigh.size() > 0){


            // }
        }
    }

/// ====================================== /// ====================================== ///

};
