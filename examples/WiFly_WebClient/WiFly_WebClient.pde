
// (Based on Ethernet's WebClient Example)

#include "WiFly.h"


#include "Credentials.h"


//byte server[] = { 66, 249, 89, 104 }; // Google
//byte server[] = { 74, 249, 53, 121 }; // Haselton.us

//Client client(server, 80);
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

  Serial.println("connecting...");

  if (client.connect()) {
    Serial.println("connected");
    Serial.println(WiFly.ip());
    client.println("POST /demos/arduino/ HTTP/1.0");
    client.println();
  } else {
    Serial.println("connection failed");
  }
  
}

void loop() {
  if (client.available()) {
    char c = client.read();
    Serial.print(c);
  }
  
  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    connectionAgain();
    for(;;)
      ;
  }
  
  
  
}

void connectionAgain(){

  delay(5000);
   if (client.connect()) {
    Serial.println("connected");
    Serial.println(client.available());
    Serial.println("before ip");
    Serial.println(WiFly.ip());
    client.println("POST /demos/arduino/?name=scott HTTP/1.1");
    client.println();
  } else {
    Serial.println("connection failed");
  }


}


