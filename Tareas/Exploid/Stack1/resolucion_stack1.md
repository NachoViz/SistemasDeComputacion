
#sudo apt install gcc-multilib


Ejecutá este comando gigante en tu terminal:
gcc -m32 -no-pie -fno-stack-protector -ggdb -mpreferred-stack-boundary=2 -z execstack -o stack1 stack1.c

