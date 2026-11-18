// Nombre: Dafne Jael Moguel Benitez
// Número de control: 22211616
// Asignatura: Lenguajes de Interfaz
// Ejercicio: C01-P041 - Velocidad de descarga (L2)
// Fecha: 2026-11-17
// Asciinema: 

// Solución en alto nivel:
//   (int64_t, int64_t) velocidad(int64_t mbps) {
//       milesimas_MBps = mbps * 125;   // mbps / 8 = MB/s ; x 1000 milesimas
//       milesimas_GBh  = mbps * 450;   // MB/s x 3600 s / 1000 MB por GB, x 1000
//       return (milesimas_MBps, milesimas_GBh);
//   }
// Al simplificar las fracciones solo quedan multiplicaciones enteras, así que
// el resultado es exacto y no hay redondeo.
// Pruebas: 8 -> 1000, 3600 ; 2263 -> 282875, 1018350.

.text
.global velocidad

velocidad:
    mov x2, #125                // factor: 1000 / 8
    mul x3, x0, x2              // x3 = mbps * 125 (milesimas de MB/s)
    mov x2, #450                // factor: 0.45 GB/h por Mbps, en milesimas
    mul x1, x0, x2              // x1 = mbps * 450 (milesimas de GB/h)
    mov x0, x3                  // primer resultado en x0, segundo ya esta en x1
    ret

// Reflexión personal:
// Antes de programar simplifiqué las fórmulas: Mbps/8 son MB/s, y en milésimas
// eso es multiplicar por 125; para GB/h el factor sale de 3600/1000/8, o sea
// 0.45, que en milésimas es 450. Así ambos resultados son enteros exactos. La
// dificultad fue que x0 es entrada y también salida, por eso guardo el primer
// resultado en x3 y solo al final lo paso a x0. Lo comprobé con 8 y con 2263.
