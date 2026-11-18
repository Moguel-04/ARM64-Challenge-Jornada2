#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
typedef struct { int64_t a, b; } par;   // 16 bytes: AAPCS64 lo devuelve en x0 y x1
int64_t segundo_mayor(const int64_t *, int64_t);
void tabla_multiplicar(int64_t, int64_t *);
void cambio(int64_t, int64_t *);
par velocidad(int64_t);
double promedio(const int64_t *, int64_t);
int main(void) {
    int64_t a[] = {2023,2019,2015,2026,2022,2018,2014,2025,2021,2017,2013,2024,2020,2016,2012};
    assert(segundo_mayor(a, 15) == 2025);
    int64_t t[145];
    tabla_multiplicar(2, t);
    assert(t[0]==4 && t[1]==1 && t[2]==2 && t[3]==2 && t[4]==4);
    tabla_multiplicar(12, t);
    assert(t[0]==144 && t[1]==1 && t[144]==144);
    int64_t c[12], e[] = {11,0,0,2,0,0,2,0,1,1,0,1};
    cambio(44750, c);
    for (int i = 0; i < 12; i++) assert(c[i] == e[i]);
    cambio(0, c);
    assert(c[0]==11 && c[5]==0 && c[11]==0);
    par p = velocidad(8);
    assert(p.a==1000 && p.b==3600);
    p = velocidad(2263);
    assert(p.a==282875 && p.b==1018350);
    int64_t d[] = {2902, 2903}, f[] = {-3, -2};
    assert(fabs(promedio(d,2) - 2902.5) < 1e-9);
    assert(fabs(promedio(f,2) + 2.5) < 1e-9);
    puts("OK");
}
