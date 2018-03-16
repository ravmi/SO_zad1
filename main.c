/*
zbior N - liczby z przedzialu 0.255
*/
#include <stdbool.h>
#include <fcntl.h>
#include <unistd.h>

#define CHUNK_SIZE 4096
#define SET_SIZE 256

int main(int argc, char **argv) {
    char* filepath = argv[1];
    
    int fdsc = open(filepath, O_RDONLY);
    int read_size;
    bool first_time = true;


    bool set[SET_SIZE] = { false };
    bool occurences[SET_SIZE] = { false };
    bool buf[CHUNK_SIZE];
    while (read_size = read(fdsc, buf, CHUNK_SIZE)) {
        for(int i = 0 ; i < read_size; i++) {
            int val = buf[i];
            if (first_time) {
                if (val == 0) {
                    first_time = false;
                }
                else {
                    if (set[val]) {
                        return 1;
                    }
                    else {
                        set[val] = true;
                    }
                }
            }
            else {
                if (val == 0) {
                    for(int i = 0; i < SET_SIZE; i++) {
                        occurences[i] = false;
                    }
                }
                else {
                    if(!set[val]) {
                        return 1;
                    }
                    else {
                        if (occurences[val]) {
                            return 1;
                        }
                        else {
                            occurences[val] = true;
                        }
                    }
                }
            }
        }
    }
    return 0;
}
