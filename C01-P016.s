// Nombre: Dafne Jael Moguel Benitez
// Número de control: 22211616
// Asignatura: Lenguajes de Interfaz
// Ejercicio: C01-P016 - Tabla de multiplicar (L3)
// Fecha: 2026-11-17
// Asciinema: 

// Solución en alto nivel:
//   void tabla_multiplicar(int64_t n, int64_t *buf) {
//       *buf++ = n * n;                      // prefijo con la longitud
//       for (i = 1; i <= n; i++)
//           for (j = 1; j <= n; j++)
//               *buf++ = i * j;              // productos por filas
//   }
// Como 1 <= n, ambos ciclos se ejecutan al menos una vez.
// Prueba: n = 2 -> [4 | 1, 2, 2, 4] (longitud 4 y luego los productos).

.text
.global tabla_multiplicar

tabla_multiplicar:
    mul x2, x0, x0              // x2 = n * n
    str x2, [x1], #8            // buf[0] = n*n y x1 avanza 8 bytes (post-indexado)
    mov x3, #1                  // x3 = i (fila)
.Lfila:
    mov x4, #1                  // x4 = j (columna)
.Lcol:
    mul x5, x3, x4              // x5 = i * j
    str x5, [x1], #8            // escribe el producto y avanza el puntero
    add x4, x4, #1              // j++
    cmp x4, x0
    b.le .Lcol                  // repite mientras j <= n
    add x3, x3, #1              // i++
    cmp x3, x0
    b.le .Lfila                 // repite mientras i <= n
    ret

// Reflexión personal:
// Decidí no calcular la dirección de cada producto con multiplicaciones y usar
// str con post-incremento, así el puntero avanza solo y los productos quedan
// ordenados por filas. Lo que casi se me pasa fue el prefijo n*n, que ocupa
// la primera posición antes del 1x1. Lo comprobé con n = 2 (1, 2, 2, 4) y con
// n = 12, donde el último producto es 144.
