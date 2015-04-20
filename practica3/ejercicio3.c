#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <mqueue.h>
#include <errno.h>
#include <sys/wait.h>

#define MAX_SIZE    5
#define QUEUE_NAME  "/una_cola"

int main() {
	// Buffer para la lectura/escritura
	char buffer[MAX_SIZE + 1];
	ssize_t nbytes;
	const int BSIZE = 100;
	// Resultado de las operaciones
	int resultado;

			int i;
  //para guardar la direccion ficheros
  int fildes[2];

	// Para realizar el fork
	pid_t rf;
	int died, status;

	// Numero aleatorio a generar
	int numeroAleatorio;

//llamamos a la funcion pipe
status=pipe(fildes);
if(status==-1){
	printf("\nocurrio un error en la llamada a 'pipe'\n");
}

	// Realizar el fork
	rf = fork();

	//llamar a la funcion int pipe(int fildes[2]);
	switch (rf)
	{
		// Error
		case -1:
			printf ("No he podido crear el proceso hijo \n");
			exit(1);

		// Hijo
		case 0:
			sleep(1);
			printf ("[HIJO]: mi PID es %d y mi PPID es %d\n", getpid(), getppid());
			close(fildes[1]);
			for(i=0;i<5;i++){
			nbytes=read(fildes[0],buffer, BSIZE);
			// Imprimimos el mensaje recibido
			printf("[HIJO]: el mensaje recibido es \"%s\"\n", buffer);
		}
			close(fildes[0]);
			printf("[HIJO]:Tuberia cerrada, salgo...\n");


			break;

		// Padre
		default:

			printf ("[PADRE]: mi PID es %d y el PID de mi hijo es %d \n", getpid(), rf);
			// Rellenamos el buffer que vamos a enviar
			// Semilla de los números aleatorios,
			//    establecida a la hora actual
			srand(time(NULL));
			for(i=0;i<5;i++){
			// Número aleatorio entre 0 y 4999
			numeroAleatorio = rand()%5000;
			sprintf(buffer,"%d",numeroAleatorio);

			printf("[PADRE]: genero el mensaje \"%s\"\n",buffer);
			write(fildes[1],buffer,BSIZE);
			}
			close(fildes[0]);

			// Mandamos el mensaje
			close(fildes[1]);
			printf("[PADRE]:Cerrando proceso...\n");
			died=wait(&status);
			exit (1);
	}

	exit(0);
}
