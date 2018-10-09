/*++++++++++++++++++++++++++++++++++++++++++
Dateiname: Ampel3
Autor:	G.Jaeger	                  
Datum:	09.10.2018
++++++++++++++++++++++++++++++++++++++++++*/
#include <at89c5131.h>

	//h = Hauptstrasse
	sbit h_Gruen = P1^1; 
	sbit h_Gelb = P1^3;
	sbit h_Rot = P1^5;
	//n = Nebenstrasse
	sbit n_Gruen = P1^4;
	sbit n_Gelb = P1^2;
	sbit n_Rot = P1^0;
	//Interrupt für zuruecksetzen der 'Flag'
	sbit i_ex0 = P3^2;
	sbit i_ex1 = P3^3;
	
//Funktionsprototypen
void zeit(int);
void nebenstrasse();
void hauptstrasse();

void i_EX0 (void) interrupt 0 {
 
		zeit(100);
		nebenstrasse();
		zeit(50);
		hauptstrasse();
		//clear interrupt 
		i_ex0 = 1;
		
}

void i_EX1 (void) interrupt 2 {

	zeit(100);
	nebenstrasse();
	zeit(50);
	hauptstrasse();
	
	//clear interrupt 
	i_ex1 = 1;
}

void main(){
	
	//init Interrupt 
	//Externer Interrupt 0 mit Taktflanke
	EX0 = 1;
	IT0 = 1;
	
	//Externer Interrupt 1 mit Taktflanke
	EX1 = 1;
	IT1 = 1;
	
	EA 	= 1;
		
	//Ampel setup
	P1 = 0;
	h_Gruen = 1;
	n_Rot = 1;
	
	while(1){
		
	}
	
}
		
void zeit(int timer){

		do{
			timer =- 1;
		}while(timer > 0);
	
}

void hauptstrasse(){
	
		n_Gruen = 0;
		n_Gelb = 1;
		h_Gelb = 1;
		
		zeit(10);
		
		n_Gelb = 0;
		n_Rot = 1;
		h_Rot = 0;
		h_Gelb = 0;
		h_Gruen = 1;
	
}

void nebenstrasse(){
	
		h_Gruen = 0;
		h_Gelb = 1;
		n_Gelb = 1;
		
		zeit(10);
		
		h_Gelb = 0;
		h_Rot = 1;
		n_Rot = 0;
		n_Gelb = 0;
		n_Gruen = 1;
	
}
