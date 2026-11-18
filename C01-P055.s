// Nombre: Dafne Jael Moguel Benitez
// Número de control: 22211616
// Asignatura: Lenguajes de Interfaz
// Ejercicio: C01-P055 - Promedio de una lista (L3)
// Fecha: 2026-11-17
// Asciinema: 

// Solución en alto nivel:
//   double promedio(const int64_t *a, int64_t n) {
//       int64_t suma = 0;
//       for (int64_t i = 0; i < n; i++) suma += a[i];
//       return (double)suma / (double)n;
//   }
// Se suma en enteros (exacto) y se divide una sola vez al final.
// Con 64 elementos de hasta 1,000,000 la suma cabe de sobra en 64 bits.
// Pruebas: [2902, 2903] -> 2902.5 ; [-3, -2] -> -2.5.

.text
.global promedio

promedio:
    mov x2, #0                  // x2 = suma
    mov x3, #0                  // x3 = indice i
.Lciclo:
    cmp x3, x1                  // i >= n ?
    b.ge .Lfin
    ldr x4, [x0, x3, lsl #3]    // x4 = a[i]
    add x2, x2, x4              // suma += a[i]
    add x3, x3, #1              // i++
    b .Lciclo
.Lfin:
    scvtf d0, x2                // d0 = (double) suma, conversion con signo
    scvtf d1, x1                // d1 = (double) n
    fdiv d0, d0, d1             // d0 = suma / n; el resultado double va en d0
    ret

// Reflexión personal:
// Decidí sumar todo en enteros y dividir una sola vez al final con fdiv, así
// no acumulo errores de redondeo en cada paso. Usé scvtf, que convierte con
// signo, y por eso los negativos funcionan sin tratamiento especial. Aprendí
// que un double se devuelve en d0 y no en x0. Lo comprobé con [-3, -2], que
// debe dar -2.5.
