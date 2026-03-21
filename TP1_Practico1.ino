#include <Arduino.h>

// Usamos 'volatile' para forzar a la CPU a hacer las cuentas y evitar 
// que el compilador optimice y borre los bucles mágicamente.
volatile int sumaInt = 0;
volatile float sumaFloat = 0.0;

// Cantidad de repeticiones (ajústalo si tarda mucho o muy poco)
const long ITERACIONES = 50000000; 

void ejecutarPruebas() {
  Serial.print("Frecuencia actual de la CPU: ");
  Serial.print(getCpuFrequencyMhz());
  Serial.println(" MHz");
  Serial.println("-----------------------------------");

  // --- PRUEBA 1: ENTEROS ---
  Serial.println("Iniciando prueba con Enteros (int)...");
  unsigned long tiempoInicio = millis(); // Anotamos el tiempo de inicio
  
  for (long i = 0; i < ITERACIONES; i++) {
    sumaInt += 1;
  }
  
  unsigned long tiempoFin = millis(); // Anotamos el tiempo final
  float segundosInt = (tiempoFin - tiempoInicio) / 1000.0;
  Serial.print("Tiempo (Int): ");
  Serial.print(segundosInt);
  Serial.println(" segundos\n");

  // --- PRUEBA 2: FLOTANTES ---
  Serial.println("Iniciando prueba con Flotantes (float)...");
  tiempoInicio = millis();
  
  for (long i = 0; i < ITERACIONES; i++) {
    sumaFloat += 1.5;
  }
  
  tiempoFin = millis();
  float segundosFloat = (tiempoFin - tiempoInicio) / 1000.0;
  Serial.print("Tiempo (Float): ");
  Serial.print(segundosFloat);
  Serial.println(" segundos\n\n");
}

void setup() {
  Serial.begin(115200); // Recordá poner el Monitor Serie a esta velocidad
  delay(3000); // Damos unos segundos para abrir el Monitor Serie

  Serial.println("=== INICIANDO EXPERIMENTO ===");

  // Configuramos la CPU a 80 MHz y probamos
  setCpuFrequencyMhz(80);
  ejecutarPruebas();

  // Duplicamos la frecuencia a 160 MHz y probamos de nuevo
  setCpuFrequencyMhz(160);
  ejecutarPruebas();
  
  Serial.println("=== EXPERIMENTO FINALIZADO ===");
}

void loop() {
  // Dejamos el loop vacío porque el experimento ya se corrió en el setup
}
