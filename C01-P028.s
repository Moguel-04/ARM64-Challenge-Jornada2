// Nombre: Dafne Jael Moguel Benitez
// Número de control: 22211616
// Asignatura: Lenguajes de Interfaz
// Ejercicio: C01-P028 - Cambio en billetes y monedas (L3)
// Fecha: 2026-11-17
// Asciinema: 

// Solución en alto nivel:
//   void cambio(int64_t monto, int64_t *out) {
//       int64_t den[11] = {100000, 50000, 20000, 10000, 5000, 2000,
//                          1000, 500, 200, 100, 50};   // en centavos
//       *out++ = 11;
//       for (int i = 0; i < 11; i++) {
//           int64_t cuenta = monto / den[i];
//           monto = monto - cuenta * den[i];            // residuo
//           *out++ = cuenta;
//       }
//   }
// Algoritmo voraz: con estas denominaciones usar primero la mayor siempre da
// el menor número de piezas.
// Pruebas: 44750 -> [0,0,2,0,0,2,0,1,1,0,1] ; 0 -> once ceros.

.text
.global cambio

cambio:
    mov x2, #11
    str x2, [x1], #8            // prefijo: la cantidad de conteos (11)
    adr x3, denominaciones      // x3 apunta a la tabla de denominaciones
    mov x4, #11                 // x4 = cuantas denominaciones faltan
.Lciclo:
    ldr x5, [x3], #8            // x5 = denominacion actual; x3 avanza 8 bytes
    udiv x6, x0, x5             // x6 = monto / denominacion
    msub x0, x6, x5, x0         // monto = monto - x6 * denominacion (residuo)
    str x6, [x1], #8            // escribe el conteo y avanza la salida
    subs x4, x4, #1             // una denominacion menos; actualiza banderas
    b.ne .Lciclo
    ret

.balign 8                       // la tabla queda alineada a 8 bytes
denominaciones:                 // en centavos: $1000 ... $0.50
    .quad 100000, 50000, 20000, 10000, 5000, 2000
    .quad 1000, 500, 200, 100, 50

// Reflexión personal:
// Decidí guardar las denominaciones en una tabla y recorrerla con un ciclo,
// para no repetir once veces el mismo bloque de código. ARM64 no tiene una
// instrucción de módulo, así que obtuve el residuo con udiv y msub. El caso
// límite fue el monto 0, que debe escribir el prefijo 11 y once ceros. Lo
// comprobé con 0 y con el ejemplo 44750.
