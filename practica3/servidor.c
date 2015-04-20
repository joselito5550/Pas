#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <mqueue.h>
#include <time.h>
#include <errno.h>
#include <getopt.h>



#include "common.h"

// Apuntador al fichero de log (se utilizará en el ejercicio resumen)
FILE *fLog = NULL;

int main(int argc, char **argv)
{
	// Cola del servidor
	mqd_t mq_server;
	//Cola para enviar mensaje de emparejamiento
	mqd_t mq_emp;

	// Atributos de la cola
	struct mq_attr attr;

	// Buffer para intercambiar mensajes
	char buffer[MAX_SIZE + 1];

	// flag que indica cuando hay que parar
	int must_stop = 0;

	//declarar los argumentos
	int option_index=0;
	static struct option long_options[] =
{
	/* Opciones que no van a actuar sobre un flag */
	/* "opcion", recibe o no un argumento, 0,
		identificador de la opción */
	{"regex",	 required_argument,	   0, 'a'},
	{"ere",no_argument,0,'n'},
	{"help",no_argument,0,'x'},
	/* Necesario para indicar el final de las opciones */
	{0, 0, 0, 0}
};
int c;
int eflag=0;
int hflag=0;
char *rvalue;
while ((c = getopt_long (argc, argv, "a:r:enhx",
									long_options, &option_index))!=-1){
										switch(c){
											case 'a':
											rvalue=optarg;
											break;
											case 'r':
											rvalue=optarg;
											break;
											case 'e':
											eflag=1;
											break;
											case 'n':
											eflag=1;
											break;
											case 'h':
											printf("\n-r  --regex \t introducir la expresion regular\n-e --ere \t expresion regular de tipo ere\n-h --help \t ayuda (pagina actual)");
											break;
											case 'x':
											printf("\n-r  --regex \t introducir la expresion regular\n-e --ere \t expresion regular de tipo ere\n-h --help \t ayuda (pagina actual)");
											break;
										}
									}


	// Inicializar los atributos de la cola
	attr.mq_maxmsg = 10;        // Maximo número de mensajes
	attr.mq_msgsize = MAX_SIZE; // Maximo tamaño de un mensaje

	// Crear la cola de mensajes del servidor
	mq_server = mq_open(SERVER_QUEUE, O_CREAT | O_RDONLY, 0644, &attr);
	//Crear la cola de mensajes de emparejamientos
	mq_emp = mq_open(SERVER_QUEUE, O_CREAT | O_RDONLY,0644,&attr);

	if(mq_server == (mqd_t)-1 ){
        	perror("Error al abrir la cola del servidor");
       		exit(-1);
	}

	do {
		// Número de bytes leidos
		ssize_t bytes_read;

		// Recibir el mensaje
		bytes_read = mq_receive(mq_server, buffer, MAX_SIZE, NULL);
		// Comprar que la recepción es correcta (bytes leidos no son negativos)
		if(bytes_read < 0){
			perror("Error al recibir el mensaje");
			exit(-1);
		}

		// Cerrar la cadena
		buffer[bytes_read] = '\0';

		// Comprobar el fin del bucle
		if (strncmp(buffer, MSG_STOP, strlen(MSG_STOP))==0)
			must_stop = 1;
		else
			printf("Recibido el mensaje: %s\n", buffer);
	// Iterar hasta que llegue el código de salida
	} while (!must_stop);

	// Cerrar la cola del servidor
	if(mq_close(mq_server) == (mqd_t)-1){
		perror("Error al cerrar la cola del servidor");
		exit(-1);
	}

	// Eliminar la cola del servidor
	if(mq_unlink(SERVER_QUEUE) == (mqd_t)-1){
		perror("Error al eliminar la cola del servidor");
		exit(-1);
	}

	return 0;
}





// Función auxiliar, escritura de un log
void funcionLog(char *mensaje) {
	int resultado;
	char nombreFichero[100];
	char mensajeAEscribir[300];
	time_t t;

	// Abrir el fichero
	sprintf(nombreFichero,"log-servidor.txt");
	if(fLog==NULL){
		fLog = fopen(nombreFichero,"at");
		if(fLog==NULL){
			perror("Error abriendo el fichero de log");
			exit(1);
		}
	}

	// Obtener la hora actual
	t = time(NULL);
	struct tm * p = localtime(&t);
	strftime(mensajeAEscribir, 1000, "[%Y-%m-%d, %H:%M:%S]", p);

	// Vamos a incluir la hora y el mensaje que nos pasan
	sprintf(mensajeAEscribir, "%s ==> %s\n", mensajeAEscribir, mensaje);

	// Escribir finalmente en el fichero
	resultado = fputs(mensajeAEscribir,fLog);
	if ( resultado < 0)
		perror("Error escribiendo en el fichero de log");

	fclose(fLog);
	fLog=NULL;
}
