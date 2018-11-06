/*++++++++++++++++++++++++++++++++++++++++++
Dateiname: Ampel3
Autor:	G.Jaeger	                  
Datum:	09.10.2018
++++++++++++++++++++++++++++++++++++++++++*/
#include <at89c5131.h>

	//h = Hauptstrasse
	sbit h_gruen = P1^1; 
	sbit h_gelb = P1^3;
	sbit h_rot = P1^5;
	//n = Nebenstrasse
	sbit n_gruen = P1^4;
	sbit n_gelb = P1^2;
	sbit n_rot = P1^0;
	//Interrupt für zuruecksetzen der 'Flag'
	sbit i_ex0 = P3^2;
	sbit i_ex1 = P3^3;
	
	int ampel_status;
	int reload_time_h = 250;
	int reload_time_l = 250;

//Funktionsprototypen
void interrupt_timer();

void i_EX0 (void) interrupt 0 {
	
	if(TR0 == 0){
		TF0 = 1;
	}
	//clear interrupt 
	i_ex0 = 1;
		
}

void i_EX1 (void) interrupt 2 {

	if(TR0 == 0){
		TF0 = 1;
	}
	//clear interrupt 
	i_ex1 = 1;
}

void i_t1 (void) interrupt 1{
	
	interrupt_timer();
	
}

void interrupt_timer(){

	//Reload Timer
	if (ampel_status == 1 || ampel_status == 3){
		TL0 = reload_time_l + ((256 - reload_time_l) / 2) ;
		TH0 = reload_time_h + ((256 - reload_time_h) / 2) ;
	}else{
		TL0 = reload_time_l;
		TH0 = reload_time_h;
	}
	
	switch(ampel_status){
		case 0: 
		
			h_rot = 0;
			h_gelb = 0;
			h_gruen = 1;
		
			n_gelb = 0;
			n_rot = 1;
			
			TR0 =~ TR0;

			break;
		case 1:
			
			h_gruen = 0;
			h_gelb = 1;
		
			n_gelb = 1;
			
			break;
		
		case 2:
			
			h_gelb = 0;
			h_rot = 1;
		
			n_gelb = 0;
			n_rot = 0;
			n_gruen = 1;
		
			break;
		
		case 3:
			
			h_gelb = 1;
				
			n_gruen = 0;
			n_gelb = 1;
		
			break;
	}
	
	if(TR0 == 1){
		ampel_status += 1;
		if(ampel_status == 4){
			ampel_status = 0;
		}
	}

}

void main(){
	
	//init Interrupt 
	//Externer Interrupt 0 mit Taktflanke
	EX0 = 1;
	IT0 = 1;
	
	//Externer Interrupt 1 mit Taktflanke
	EX1 = 1;
	IT1 = 1;
	
	//Timer 0 Interrupt
	ET0 = 1;
	
	EA 	= 1;

	TMOD = 1;
	TR0 = 0;

	TH0 = reload_time_h;
	TL0 = reload_time_l;
	
	//Ampel setup
	P1 = 0;
	h_gruen = 1;
	n_rot = 1;
	
	while(1){}
	
}
