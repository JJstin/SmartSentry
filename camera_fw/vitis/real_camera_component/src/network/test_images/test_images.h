#include "xil_types.h"

struct test_image {
    u8 * buf;
    int size;
};

void get_next_image(struct test_image * img);

