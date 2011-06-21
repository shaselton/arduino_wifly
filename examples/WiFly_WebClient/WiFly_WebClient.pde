
// (Based on Ethernet's WebClient Example)
/*

  SpiUartTerminal - tool to help troubleshoot problems with WiFly shield

  This code will initialise and test the SC16IS750 UART-SPI bridge then enable you
  to send commands to the WiFly module.

  Copyright (c) 2010 SparkFun Electronics. http://sparkfun.com LGPL 3.0

 */



#include "WiFly.h"
#include "Credentials.h"

int newClient = true;
Client client("haselton2011.com", 80);

void setup() {
  
  Serial.begin(9600);
  WiFly.begin();
  if (!WiFly.join(ssid, passphrase)) {
    Serial.println("Association failed.");
    while (1) {
      // Hang on failure.
    }
  }  
  /*
   if (client.connect()) {
    Serial.println("connected");
    Serial.println(client.available());
    Serial.println("before ip");
    client.println("GET /demos/arduino/ HTTP/1.0");
    client.println();
  } else {
    Serial.println("connection failed");
  }
*/

  
}

void loop() {
  
  while(client.available()) {
    char c = client.read();
    Serial.print(c);
  }
  newClient = false;
  
   // Serial.println("connecting...");
  
    if (client.connect()) {
      Serial.println("connected");
      Serial.println(WiFly.ip());
      client.println("POST /demos/arduino/ HTTP/1.0");
      client.println();
      //counter++;
    } else {
      Serial.println("connection failed");
    }
    
  // TODO: mzkd z vunction that checks if the client is connected AND still in the state of non-stopped?
  
  if (!client.connected() && client.available()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    //connectionAgain();
    //for(;;)
    //  ;
    newClient = true;
    client.start();//("haselton2011.com", 80);
     delay(5000);
  }
  
  if (newClient){
  
    Serial.println("connected");
    Serial.println(client.available());
    Serial.println("before ip");
    client.println("GET /demos/arduino/ HTTP/1.0");
    client.println();
   
  } 
  
}

void connectionAgain(){

  delay(5000);
   if (client.connect()) {
    Serial.println("connected");
    Serial.println(client.available());
    Serial.println("before ip");
    client.println("GET /demos/arduino/?name=scott HTTP/1.1");
    client.println();
  } else {
    Serial.println("connection failed");
  }


}


