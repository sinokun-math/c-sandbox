#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main() {
  int fd = open("lowlevel.txt", O_WRONLY | O_CREAT | O_APPEND, 0644);
  if (fd < 0) return 1;

  const char *msg = "Low-level write!\n";
  write(fd, msg, strlen(msg));
  close(fd);
  return 0;
}