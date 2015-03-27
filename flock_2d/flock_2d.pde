/// ====================================== /// ====================================== ///

// Martin Zumaya Hernandez

// Inicio: Agosto - Septiembre 2015

// Simulacion de Flocking en 2D
// con interacciones topologicas de largo alcance
// y geometricas de corto alcance

// Sep·4·2015 --> Red aleatoria todos contra todos
// Mar·27·2015 --> Parametros como en las simulaciones
									 // Traslado a centro de masa
									 // Visualizacion de Fluctuaciones de Velocidad

/// ====================================== /// ====================================== ///

import java.awt.Frame;
import java.awt.BorderLayout;
import java.lang.Math;
import java.util.Scanner;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;

/// ====================================== /// ====================================== ///

// Agent2D pred;
Flock flock;

float l = 100, vo = 1, eta, r, dt, omega ;
int k = 2, n = 1000, go, topo, geom, bac, fluct, full;
float s = 1;

/// ====================================== /// ====================================== ///

void setup() {
	size(800, 800);
	//size(1024, 740, OPENGL);
	smooth();
	background(80);

	//colorMode(HSB);

	cp5 = new ControlP5(this);
	cf = addControlFrame("parameters", 600,200);

	// pred = new Agent2D(l,vo,0,r);

	flock = new Flock(n,l,vo,k,r);
	// flock = new Flock(n,l,vo,r);
}

/// ====================================== /// ====================================== ///

void draw() {

	colorMode(RGB);

	// background(120);
	
	noStroke();
	fill(80,bac);
	rect(0,0,width,height);

	translate(width/2, height/2);

	scale(s);


	flock.calcCM();
	flock.Update(dt,go, flock.posCM);

	// flock.Update(dt,go);
	// flock.Update(dt,go, pred);
	// pred_update(go);

	for(int i = 0; i < n; i ++){
		// Example(i);
		Example(i, flock.posCM);

		if(full == 1) flock.elements[i].ShowPoint(flock.posCM);
		if(fluct == 1) flock.elements[i].ShowFluctVel(flock.posCM, flock.velCM);
	}
	
}

/// ====================================== /// ====================================== ///

void keyPressed() {
	// if (key == 's'){
	// 	background(0);
	// 	s += 0.05;
	// 	// println("s: "+s);
	// }
	// if (key == 'a'){
	// 	background(0);
	// 	s -= 0.05;
	// 	// println("s: "+s);
	// }
	if (key == 'c'){
		background(0);
	}
}

/// ====================================== /// ====================================== ///
