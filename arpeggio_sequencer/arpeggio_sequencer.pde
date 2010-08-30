int modeSwitch = 5;
int tempoPot = 0;
int synth1 = 3;
int synth2 = 4;
int currentSynth = synth1;
int mode = 1;
int counter = 0;

void setup() {
  Serial.begin(9600);
  pinMode(modeSwitch, INPUT);
  pinMode(synth1, OUTPUT);
  pinMode(synth2, OUTPUT);
}

void loop() {
  // READ TEMPO
  // bpm is milliseconds * measures * seconds
  // bpm = (tempo*2) * 4 * 60
  int tempo = analogRead(tempoPot);
  
  // READ MODE
  mode = digitalRead(modeSwitch);

  Serial.print("Mode: "); Serial.println(mode);
  Serial.print("Tempo: "); Serial.println(tempo);
  Serial.print("Counter: "); Serial.println(counter);
  Serial.println("---");
  
  // SEND TRIGGER
  if (mode == HIGH) {
    if ((counter%2) == 0) { currentSynth = synth1; }
    else                  { currentSynth = synth2; }
  } else {
    if (counter < 4)      { currentSynth = synth1; }
    else                  { currentSynth = synth2; }
  }
  digitalWrite(currentSynth, HIGH);
  delay(100);
  digitalWrite(currentSynth, LOW);
  
  // INCREMENT COUNTER
  counter += 1;
  if (counter == 8) { counter = 0; }
  
  // WAIT
  delay(tempo);
}

