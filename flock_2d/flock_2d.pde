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
									// Incluye perturbaciones y visualizaciones
// May·6·2015 ---->	Perturbaciones con giro

									
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
Flock flockCPY;
int colorCPY = 10;

Agent2D pred;
PVector velPert;

PVector vecPsi;
float psi;

float l = 0.1; // regimen de velocidad
float vo = 1.0;
float eta; // magnitud de ruido
float r; // radio de interaccion local
float dt = 1.0;
float omega; // peso relativo entre vecindades 
float pertMag;
int k = 1, n, go, topo, geom, bac, fluct, drwCPY, fullCPY, fluctCPY,
		full, pert, numPerts, movePert, movePred, drwDIF,
		shCM, turnPred, dirRot, partPert = 0;
float s = 1;
float p = 10; // densidad 
float tam = 10; // region cuadrada inicial
int col = 80;
float speed, beh = 1.0;

float[] ruido;

int t = 0;

/// ====================================== /// ====================================== ///

void setup() {

	size(400, 400);
	smooth();

	background(80);

	cp5 = new ControlP5(this);
	cf = addControlFrame("parameters", 450, 420);

	setupSystem();
	// setupSystemPred();

	PFont font = createFont("Courier",10);
	textFont(font, 10);
}

/// ====================================== /// ====================================== ///

void draw() {

	colorMode(RGB);

	noStroke();
	fill(80,bac);
	rect(0,0,width,height);

	translate(width/2, height/2);

	scale(s);

	setRuido();

	if (movePred == 0) {
		flock.Update(dt,go,ruido);
		flockCPY.Update(dt,go,ruido);
	}else{
		if(turnPred == 1) turnVelPert(dirRot);
		flock.Update(dt,go,ruido);
		flockCPY.Update(dt,go,ruido,velPert, partPert);
	}

	if(shCM == 1) {
		flock.showCM();
		flockCPY.showCM(colorCPY);
	}

	calcPsi(flock);
	calcPsi(flockCPY);
	
	// pred.Show_Pred();

	drawPartsAndVels(flock);

	if(drwCPY == 1) drawPartsAndVels(flockCPY, colorCPY, fullCPY, fluctCPY);
	if(drwDIF == 1) drawDiff();

	// ShowPerts();
	ShowPerts(partPert);

	// if(movePred == 1) perturbation();

	t ++;
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
