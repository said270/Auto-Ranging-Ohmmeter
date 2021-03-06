/*******************************************************
This program was created by the CodeWizardAVR V3.48b 
Automatic Program Generator
? Copyright 1998-2022 Pavel Haiduc, HP InfoTech S.R.L.
http://www.hpinfotech.ro

Project : test2
Version : 
Date    : 17/05/2022
Author  : 
Company : 
Comments: 


Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

// I/O Registers definitions
#include <mega32a.h>
#include <stdio.h>
#include <delay.h>

#include <math64.h>
// Alphanumeric LCD functions
#include <alcd.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>
#include <stdbool.h>
// Voltage Reference: AREF pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCW;
}

void lcd_WriteResult(unsigned long int result){
int i=0;
unsigned long int num=0;
int Size=0;
unsigned char   lcd_value2[16];
    while (result !=0){
        		num=result%10;
      		result=result/10;
        		lcd_value2[Size]=num;
        		Size++;
                delay_ms(20);
      	}     
           i=Size-1;
           for (i;i>=0;i--){
         		lcd_putchar(lcd_value2[i]+48);
                delay_ms(20);
       	} 

}


void main(void)
{

unsigned long int test=0;
float V_out=0;
unsigned long int    V_in=5;
float     Res_known;
unsigned long int     Res_unknown;
unsigned char   lcd_value[16];

// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (1<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (1<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (1<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
DDRB=0xff;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);

// USART initialization
// USART disabled
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

// Analog Comparator initialization
// Analog Comparator: Off
// The Analog Comparator's positive input is
// connected to the AIN0 pin
// The Analog Comparator's negative input is
// connected to the AIN1 pin
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);

// ADC initialization
// ADC Clock frequency: 125.000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: ADC Stopped
ADMUX=ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (0<<ADPS0);
SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

// SPI initialization
// SPI disabled
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

// TWI initialization
// TWI disabled
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS: PORTC Bit 0
// RD: PORTC Bit 1
// EN: PORTC Bit 2
// D4: PORTC Bit 4
// D5: PORTC Bit 5
// D6: PORTC Bit 6
// D7: PORTC Bit 7
// Characters/line: 16
lcd_init(16);
PORTB=0x00;
while (1)

      { lcd_clear();   
      lcd_puts("Welcome") ;
      delay_ms(300);    
      // Range in milli ohms //
      Res_known=100000;
      lcd_clear();
      PORTB=0x01;
      delay_ms(300);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=1 && test <=4){
          lcd_puts(lcd_value);
           delay_ms(300);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown);  
          lcd_puts(" microohm");
          lcd_puts("    Range 0");
          delay_ms(3000);
           }
           if(test>=4 && test <=2000){
          lcd_puts(lcd_value);
           delay_ms(300);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*2);  
          lcd_puts(" microohm");
          lcd_puts("    Range 0");
          delay_ms(3000);
           }
//           if(test>=1001 && test <=3000){
//          lcd_puts(lcd_value);
//           delay_ms(300);
//           lcd_clear();
//          Res_unknown=((Res_known*V_out)/(V_in-V_out));
//          lcd_puts("R="); 
//          lcd_WriteResult(Res_unknown*1.5);  
//          lcd_puts(" microohm");
//          lcd_puts("    Range 0");
//          delay_ms(3000);
//           }
             
      //  Range near 1 ohm //
      Res_known=1000;
      lcd_clear();
      PORTB=0x02; 
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=0 && test <=100){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*1200);  
          lcd_puts(" microohm");
          lcd_puts("    Range 1");
          delay_ms(3000);
           }
      if(test>=101 && test <=4500){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*1.1);  
          lcd_puts(" milliohm");
          lcd_puts("    Range 1");
          delay_ms(3000);
           }
      
      //  Range near 100 ohm //
      Res_known=100;
      lcd_clear();
      PORTB=0x04;  
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=500 && test <=4100){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*1.1);  
          lcd_puts(" ohm");
          lcd_puts("         Range 2");
          delay_ms(3000);
           }
      
       //  Range near 1k ohm //
      Res_known=1000;
      lcd_clear();
      PORTB=0x08; 
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=400 && test <=4500){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown);  
          lcd_puts(" ohm");
          lcd_puts("         Range 3");
          delay_ms(3000);
           }    
      
      
      //  Range near 10k ohm //
      Res_known=10;
      lcd_clear(); 
      PORTB=0x10;
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=400 && test <=4500){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown);  
          lcd_puts(" kohm");
          lcd_puts("         Range 4");
          delay_ms(3000);
           }    
      
      
      //  Range near 100k ohm //
      Res_known=100;
      lcd_clear(); 
      PORTB=0x20;
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=400 && test <=4000){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown);  
          lcd_puts(" kohm");
          lcd_puts("         Range 5");
          delay_ms(3000);
           }
           
               
       
      
      //  Range near 1Mohm //
      Res_known=1000;
      lcd_clear(); 
      PORTB=0x40;
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=300 && test <=3000){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*0.95);  
          lcd_puts(" kohm");
          lcd_puts("         Range 6");
          delay_ms(3000);
           } 
           
           if(test>=3001 && test <=4900){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*1.015);  
          lcd_puts(" kohm");
          lcd_puts("         Range 6");
          delay_ms(3000);
           } 
           
       
      
      //  Range near 10Mohm //
      Res_known=10;
      lcd_clear();
      PORTB=0x80;
      delay_ms(100);
      V_out=read_adc(0);
      test=((V_out*5000UL)/1024);
      V_out=((V_out*5UL)/1024);
      delay_ms(100);
      sprintf(lcd_value ,"%u",test); 
      
      
      if(test>=200 && test <=4900){
          lcd_puts(lcd_value);
           delay_ms(200);
           lcd_clear();
          Res_unknown=((Res_known*V_out)/(V_in-V_out));
          lcd_puts("R="); 
          lcd_WriteResult(Res_unknown*0.9);  
          lcd_puts(" Mohm");
          lcd_puts("         Range 7");
          delay_ms(3000);
           }   
       //      V_out=read_adc(0);
      //      V_out=((V_out*5000ULL)/1024);
       //      Res_unknown=((Res_known*V_out)/(V_in-V_out));
       //      
        //      sprintf(lcd_value ,"%u",Res_unknown);
      //      lcd_puts(lcd_value);
      //      lcd_puts("ohm");
      //       lcd_clear();
      }
 }
