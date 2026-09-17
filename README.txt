There are two steps:
1. Firstly, build basic environments inside docker:
  A. Build FS(Debian version: trixie)

cd escape
ESCAPE_ROOT=$(pwd)
sudo docker build -t escape_env .
  B. Build Kernel 
  C. Build QEMU
2. Then, quit docker, run QEMU:
