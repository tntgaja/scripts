#include <stdio.h>

void __attribute__((constructor)) init() {
    printf("File .so được chèn thành công!\n");
}
