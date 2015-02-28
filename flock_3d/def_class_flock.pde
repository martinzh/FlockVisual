//---------------------------------------//
// Definicion de la clase Flock
//---------------------------------------//

class Flock
{
    // elements --> arreglo con los agentes
    // N --> numero de miembros
    
    Agent3D[] elements;

    Flock(int n, float l, float v, int k, float r)
    {
        elements = new Agent3D[n];
        for (int i = 0; i < n; i++)
        {
            elements[i] = new Agent3D(l, v, k, r);

            for (int j = 0; j < elements[i].links.length; j++) //generar enlaces con otros agentes arbitrarios
            {
                elements[i].links[j] = int(random(n));
            }
        }
    }

    void Update(float dt, int p ){

        for(Agent3D agent : elements){

            agent.Show();

            if (p == 1){
                agent.AlignTopo(elements);
                agent.AlignGeom(elements);
                agent.Move(dt);
            }
        }
    }
};
