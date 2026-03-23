#include <Arduino.h>

volatile int sumaInt = 0;
volatile float sumaFloat = 0.0;

// Cantidad de repeticiones
const long ITERACIONES = 70000000; 

void ejecutarPruebas() {
  Serial.println("\n===================================");
  Serial.print("Frecuencia actual de la CPU: ");
  Serial.print(getCpuFrequencyMhz());
  Serial.println(" MHz");
  Serial.println("===================================");

  // --- PRUEBA 1: ENTEROS ---
  sumaInt = 0; 
  Serial.println("\n[PRUEBA ENTEROS]");
  Serial.println("Realizando sumas de enteros...");

  unsigned long tiempoInicio = millis();
  
  for (long i = 0; i < ITERACIONES; i++) {
    sumaInt += 1;
  }
  
  unsigned long tiempoFin = millis(); 
  float segundosInt = (tiempoFin - tiempoInicio) / 1000.0;

  Serial.print("Resultado final (int): ");
  Serial.println(sumaInt);
  Serial.print("Tiempo de ejecucion (int): ");
  Serial.print(segundosInt);
  Serial.println(" segundos");

  // --- PRUEBA 2: FLOTANTES ---
  sumaFloat = 0; // Reset
  Serial.println("\n[PRUEBA FLOTANTES]");
  Serial.println("Realizando sumas de numeros flotantes...");

  tiempoInicio = millis();
  
  for (long i = 0; i < ITERACIONES; i++) {
    sumaFloat += 1.5;
  }
  
  tiempoFin = millis();
  float segundosFloat = (tiempoFin - tiempoInicio) / 1000.0;

  Serial.print("Resultado final (float): ");
  Serial.println(sumaFloat);
  Serial.print("Tiempo de ejecucion (float): ");
  Serial.print(segundosFloat);
  Serial.println(" segundos");

  Serial.println("\n-----------------------------------");
  Serial.println("Fin de pruebas para esta frecuencia");
  Serial.println("-----------------------------------\n");
}

void setup() {
  Serial.begin(115200);
  delay(3000);

  Serial.println("=== INICIANDO EXPERIMENTO ===");
  Serial.println("Se evaluara el tiempo de ejecucion con distintas frecuencias de CPU\n");

  // Frecuencia base 80 MHz
  Serial.println(">>> Configurando CPU a 80 MHz...");
  setCpuFrequencyMhz(80);
  ejecutarPruebas();

  // Duplicamos la frecuencia a 160 MHz
  Serial.println(">>> Configurando CPU a 160 MHz...");
  setCpuFrequencyMhz(160);
  ejecutarPruebas();

  Serial.println("=== EXPERIMENTO FINALIZADO ===");
}

void loop() {}
