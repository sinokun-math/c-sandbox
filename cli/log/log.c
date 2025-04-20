#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s \"Your message here\"\n", argv[0]);
    return 1;
  }

  FILE *file = fopen("log.txt", "a"); // Open in append mode
  if (file == NULL) {
    perror("Failed to open log file");
    return 1;
  }
  // Get current time
  time_t *now;
  *now = time(NULL);
  struct tm *t =localtime(now);

  // Format timestamp
  char timestamp[20];
  strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", t);

  // Write to file
  fprintf(file, "[%s] %s\n", timestamp, argv[1]);
  fclose(file);

  printf("Message logged.\n");
  return 0;
}
