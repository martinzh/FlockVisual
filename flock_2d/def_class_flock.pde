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
        strokeWeight(2);

        // arrow(posCM.x, posCM.y, posCM.x + arr * velCM.x, posCM.y + arr * velCM.y);
        arrow(0, 0, mult*arr * velCM.x, mult*arr * velCM.y);

    }

/// ====================================== /// ====================================== ///

    // void Update(double dt, double pg, double pt){
    void Update(float dt, int p, Agent2D pred){

        calcCM();

        for(Agent2D agent : elements){

            // agent.Show();
            agent.ShowPoint();

            if (p ==1){
                // agent.AlignTopo(elements);
                // agent.AlignGeom(elements);
                agent.AlignBoth(elements);
                agent.Predator(pred, dt);
                agent.Move(dt);
            }
        }
    }

/// ====================================== /// ====================================== ///

    void Update(float dt, int p){

        calcCM();

        for(Agent2D agent : elements){

            // agent.Show();
            agent.ShowPoint();

            if (p ==1){
                // agent.AlignTopo(elements);
                // agent.AlignGeom(elements);
                agent.AlignBoth(elements);
                agent.Move(dt);
            }
        }
    }

/// ====================================== /// ====================================== ///

    void Update(float dt, int p, PVector posCM){

        showCM();

        for(Agent2D agent : elements){

            // agent.Show();
            // agent.ShowPoint(posCM);

            if (p ==1){
                // agent.AlignTopo(elements);
                // agent.AlignGeom(elements);
                agent.AlignBoth(elements);
                agent.Move(dt);
            }
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

};
