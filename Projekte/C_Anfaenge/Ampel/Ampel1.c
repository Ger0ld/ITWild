/*++++++++++++++++++++++++++++++++++++++++++
Dateiname: Ampel1
Autor:	G.Jaeger	                  
Datum:	09.10.2018
++++++++++++++++++++++++++++++++++++++++++*/
#include <at89c5131.h>
	
	sbit a_Gruen = P1^0;
	sbit a_Gelb = P1^1;
	sbit a_Rot = P1^2	;	
	sbit f_Gruen = P1^3;
	sbit f_Rot = P1^4;
	
void zeit();
void gruen();
void gelb();
void rot();
	
void main(){
	
	P1 = 0;
	a_Gruen = 1;
	f_Rot = 1;
	
	while(1){
		
		gruen();
		zeit();
		gelb();
		zeit();
		rot();
		zeit();
			
		
	}
	
}

void zeit(){
	
	unsigned int timer = 14000;
	
	do{
		timer--;
	}while(timer > 0);
	
}

void rot(){
	
	a_Gelb = 0;
	a_Rot = 1;
	
	f_Rot = 0;
	f_Gruen = 1;
	
}

void gelb(){
	
	f_Gruen = 0;
	f_Rot = 1;
	
	a_Gelb = 1;
	
}

void gruen(){

	a_Gelb = 0;
	a_Rot = 0;
	a_Gruen = 1;
	
}
