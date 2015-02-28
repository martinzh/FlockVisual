//---------------------------------------//
// Definicion de la clase Flock
//---------------------------------------//

class Flock
{
    // elements --> arreglo con los agentes
    // N --> numero de miembros
    
    Agent2D[] elements;

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
    }

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

    // void Update(double dt, double pg, double pt){
    void Update(float dt, int p, Agent2D pred){

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

    void Update(float dt, int p){

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

    void ChangeID(IntList neigh, Agent2D part, int nb){

        part.id = nb;

        for (int i : neigh) {
            elements[i].id = part.id;
        }
    }

};
