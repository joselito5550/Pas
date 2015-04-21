#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <mqueue.h>
#include <time.h>
#include <getopt.h>
#include <errno.h>

#include "common.h"

// Apuntador al fichero de log (se utilizará en el ejercicio resumen)
FILE *fLog = NULL;

int main(int argc, char **argv)
{
	// Cola del servidor
	mqd_t mq_server;

	//Cola para enviar mensaje de emparejamiento
	mqd_t mq_emp;

	//atributos de la cola
	struct mq_attr attr;

	attr.mq_maxmsg = 10;        // Maximo número de mensajes
	attr.mq_msgsize = MAX_SIZE; // Maximo tamaño de un mensaje

	// Buffer para intercambiar mensajes
	char buffer[MAX_SIZE];

//abrir cola de emparejamientos
//mq_emp=mq_open(CLIENT_QUEUE, O_CREAT | O_RDONLY, 0644, &attr);
	// Abrir la cola del servidor
	mq_server = mq_open(SERVER_QUEUE, O_WRONLY);
	if(mq_server == (mqd_t)-1 ){
        	perror("Error al abrir la cola del servidor");
       		exit(-1);
	}
/*	if(mq_emp==(mqd_t)-1){
		perror("Error al abrir la cola de emparejamiento");
		exit(-1);
	}*/

	printf("Mandando mensajes al servidor (escribir \"%s\" para parar):\n", MSG_STOP);

	do {
		printf("> ");
		fflush(stdout);                  // Limpiar buffer de salida

		memset(buffer, 0, MAX_SIZE);     // Poner a 0 el buffer
		fgets(buffer, MAX_SIZE, stdin);  // Leer por teclado
		buffer[strlen(buffer)-1] = '\0'; // Descartar el salto de línea

		// Enviar y comprobar si el mensaje se manda
		if(mq_send(mq_server, buffer, MAX_SIZE, 0) != 0){
			perror("Error al enviar el mensaje");
			exit(-1);
		}
		ssize_t bytes_read;

		// Recibir el mensaje
		bytes_read = mq_receive(mq_emp, buffer, MAX_SIZE, NULL);
		// Comprar que la recepción es correcta (bytes leidos no son negativos)
		if(bytes_read < 0){
			perror("Error al recibir el mensaje");
			exit(-1);
		}

	// Iterar hasta escribir el código de salida
	} while (strncmp(buffer, MSG_STOP, strlen(MSG_STOP)));

	// Cerrar la cola del servidor
	if(mq_close(mq_server) == (mqd_t)-1){
		perror("Error al cerrar la cola del servidor");
		exit(-1);
	}

	//cerrar la cola de emparejamiento
	if(mq_close(mq_emp)==(mqd_t)-1){
		perror("Error al cerrar la cola de emparejamiento");
		exit(-1);
	}

	if(mq_unlink(CLIENT_QUEUE) == (mqd_t)-1){
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
	sprintf(nombreFichero,"log-cliente.txt");
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
