// Nombre: Dafne Jael Moguel Benitez
// Número de control: 22211616
// Asignatura: Lenguajes de Interfaz
// Ejercicio: C01-P013 - Segundo mayor (L3)
// Fecha: 2026-11-17
// Asciinema: 

// Solución en alto nivel:
//   int64_t segundo_mayor(const int64_t *a, int64_t n) {
//       int64_t mayor = 0, segundo = 0;
//       for (int64_t i = 0; i < n; i++) {
//           if (a[i] > mayor) { segundo = mayor; mayor = a[i]; }
//           else if (a[i] > segundo) { segundo = a[i]; }
//       }
//       return segundo;
//   }
// Una sola pasada, sin ordenar. Como todos son positivos y distintos, 0 sirve
// como valor inicial y no hay empates que manejar.
// Prueba: [2023, 2019, ..., 2012] -> 2025.

.text
.global segundo_mayor

segundo_mayor:
    mov x2, #0                  // x2 = mayor
    mov x3, #0                  // x3 = segundo mayor
    mov x4, #0                  // x4 = indice i
.Lciclo:
    cmp x4, x1                  // i >= n ?
    b.ge .Lfin
    ldr x5, [x0, x4, lsl #3]    // x5 = a[i] (cada int64 ocupa 8 bytes)
    cmp x5, x2
    b.le .Lcompara              // si a[i] <= mayor, quiza sea el segundo
    mov x3, x2                  // el mayor anterior pasa a ser el segundo
    mov x2, x5                  // a[i] es el nuevo mayor
    b .Lsig
.Lcompara:
    cmp x5, x3
    b.le .Lsig                  // si a[i] <= segundo, no cambia nada
    mov x3, x5                  // a[i] es el nuevo segundo
.Lsig:
    add x4, x4, #1              // i++
    b .Lciclo
.Lfin:
    mov x0, x3                  // retorno en x0 (AAPCS64)
    ret

// Reflexión personal:
// Decidí recorrer el arreglo una sola vez guardando el mayor y el segundo en
// registros, en lugar de ordenarlo, que habría sido más código y más trabajo.
// Lo delicado es cuando aparece un nuevo máximo: primero hay que pasar el
// máximo anterior a segundo, porque si no se pierde. Lo comprobé con la
// prueba pública, donde el 2026 queda en medio del arreglo y no al inicio.
