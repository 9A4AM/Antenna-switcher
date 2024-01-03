#include<SoftwareSerial.h>
#define relay_pin 0
SoftwareSerial s_serial(2,3);
char ch;
void setup() 
{
  pinMode(3,OUTPUT);
  pinMode(2,INPUT);
  pinMode(0,OUTPUT);
  s_serial.begin(9600); 

}
void loop() 
{   
  while(s_serial.available())
    {       
       if(s_serial.available()>0)
        {   
          ch = s_serial.read();
          if(ch == '1') 
{
  digitalWrite(relay_pin,HIGH);

}
          if(ch == '0') 
 	{
  digitalWrite(relay_pin,LOW);

} 
        }             
    }   
}             