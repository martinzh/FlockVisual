/// ====================================== /// ====================================== ///

// Martin Zumaya Hernandez

// Inicio: Agosto - Septiembre 2014

// Simulacion de Flocking en 2D
// con interacciones topologicas de largo alcance
// y geometricas de corto alcance

// Sep·4·2014 ----> Red aleatoria todos contra todos
// Mar·27·2015 ---> Parametros como en las simulaciones
									 // Traslado a centro de masa
									 // Visualizacion de Fluctuaciones de Velocidad
// Abr·8·2015 ---->	Arreglo de GUI
									// Incluye perturbaciones y visualizacione
									
/// ====================================== /// ====================================== ///

import java.awt.Frame;
import java.awt.BorderLayout;
import java.lang.Math;
import java.util.Scanner;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;

/// ====================================== /// ====================================== ///

Flock flock;
// Agent2D pred;

float l = 0.1; // regimen de velocidad
float vo = 1.0;
// float eta; // magnitud de ruido
float eta; // magnitud de ruido
float r; // radio de interaccion local
float dt = 1.0;
float omega; // peso relativo entre vecindades 
float pertMag;
int k = 1, n, go, topo, geom, bac, fluct, full, pert, numPerts, movePert;
float s = 1;
float p = 10; // densidad 
float tam = 10; // region cuadrada inicial
int col = 80;

/// ====================================== /// ====================================== ///

void setup() {

	size(800, 800);
	smooth();

	background(80);

	cp5 = new ControlP5(this);
	cf = addControlFrame("parameters", 300, 280);

	r = vo * dt / l;
	n = (int)(r*r*p);

	// pred = new Agent2D(l,vo,0,r);

	flock = new Flock(n,tam*r,vo,k,r);
	// flock = new Flock(n,l,vo,r);

}

/// ====================================== /// ====================================== ///

void draw() {

	colorMode(RGB);

	noStroke();
	fill(80,bac);
	rect(0,0,width,height);

	translate(width/2, height/2);

	scale(s);

	flock.calcCM();
	
	// flock.Update(dt, go);
	flock.Update(dt, go);
	

	// flock.Update(dt,go);
	// flock.Update(dt,go, pred);
	// pred_update(go);

	for(int i = 0; i < n; i ++){

		// ShowNetwork(i);
		ShowNetwork(i, flock.posCM);

		if(full == 1) flock.elements[i].ShowPoint(flock.posCM);
		if(fluct == 1) flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM);
	}
		
	if(pert == 1) {
		for (int j = 0; j < numPerts; ++j) {
			
			flock.elements[j].ShowPoint(flock.posCM, col);
		}
			// if(i == 0) flock.elements[i].ShowPoint(flock.posCM, col);
			// flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM, flock.elements[0].vel,col);
			// flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM);
	}
	
}

/// ====================================== /// ====================================== ///

// void keyPressed() {
// 	if (key == 's'){
// 		background(0);
// 		s += 0.05;
// 		// println("s: "+s);
// 	}
// 	if (key == 'a'){
// 		background(0);
// 		s -= 0.05;
// 		// println("s: "+s);
// 	}
// 	if (key == 'c'){
// 		background(0);
// 	}
// }

/// ====================================== /// ====================================== ///
