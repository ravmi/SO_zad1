/*
zbior N - liczby z przedzialu 0.255
*/
#include <stdbool.h>
#include <fcntl.h>
#include <unistd.h>

#define CHUNK_SIZE 4096
#define SET_SIZE 256

int main(int argc, char **argv) {
    if (argc != 2) {
        return 1;
    }

    
    /* Open file */
    int fdsc = open(argv[1], O_RDONLY);
    if (fdsc == -1) {
        return 1;
    }

    ssize_t loaded_chunk_size;
    bool zero_occured = false;
    int should_be_counter = 0;
    int current_counter = 0;

    /* Tablica set trzyma opis zbioru N */
    /* Tablica occured trzyma które elementy już wystąpiły (potrzebne dopiero po minieciu pierwszego 0) */
    /* buf is the data that was read from the file */
    bool set[SET_SIZE] = { false };
    bool occurences[SET_SIZE] = { false };
    char buf[CHUNK_SIZE];
    while (loaded_chunk_size = read(fdsc, buf, CHUNK_SIZE)) {
        if (loaded_chunk_size == -1) {
            return 1;
        }
        /* reading byte after byte*/
        for(int i = 0; i < loaded_chunk_size; i++) {
            int val = buf[i];
            if (!zero_occured) {
                if (val == 0) {
                    zero_occured = true;
                }
                else {
                    if (set[val]) {
                        return 1;
                    }
                    else {
                        set[val] = true;
                        ++should_be_counter;
                    }
                }
            }
            else {
                if (val != 0) {
                    if (!set[val]) {
                        return 1;
                    }
                    if (occurences[val]) {
                        return 1;
                    }
                    else {
                        occurences[val] = true;
                        ++current_counter;
                    }
                }
                else {
                    if (current_counter != should_be_counter) {
                        return 1;
                    }
                    else {
                        current_counter = 0;
                        for(int i = 0; i < SET_SIZE; i++) {
                            occurences[i] = false;
                        }
                    }
                }
            }
        }
    }
    if (!zero_occured) {
        return 1;
    }
    return 0;
}
