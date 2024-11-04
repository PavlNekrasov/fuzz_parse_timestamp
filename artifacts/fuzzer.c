#include <config.h>
#include <time-util.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>


int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {

    char *s = (char *)malloc(size + 1);
    if (!s) {
        return 0;
   }


    memcpy(s, data, size);
    s[size] = '\0';

    usec_t ret;
    int result = parse_timestamp(s, &ret);

    free(s);

    return 0;
}
