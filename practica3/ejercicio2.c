#include <unistd.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <pwd.h>
#include <grp.h>
#include <unistd.h>
#include <string.h>
#include <getopt.h>

void  spain(struct group *gr){
  printf("Nombre del grupo: %s\n",gr->gr_name);
  printf("ID del grupo: %d\n",gr->gr_gid);
}

void english(struct group *gr){
  printf("Group name: %s\n",gr->gr_name);
  printf("Group ID: %d\n",gr->gr_gid);
}

void help(){
  printf("\n-h --help \t <esta ayuda>\n-g --group \t<nombre del grupo>\n-e --english \t<mostrar en ingles>\n-s --spanish \t<mostrar en español>\t");
}

int  main(int argc, char **argv){
  int c;
  opterr=0;
  char *avalue=NULL;
  char *gvalue=NULL;
  int hflag=0,eflag=0,sflag=0;
  int option_index = 0;
  struct group *gr;
  struct passwd *pw;
  char *value=NULL;
  static struct option long_options[] =
	{
		/* Opciones que no van a actuar sobre un flag */
		/* "opcion", recibe o no un argumento, 0,
		   identificador de la opción */
		{"group",	required_argument,  0, 'a'},
    {"help",no_argument, 0,'h'},
    {"english",no_argument,0,'e'},
    {"spanish",no_argument,0,'s'},
		/* Necesario para indicar el final de las opciones */
		{0, 0, 0, 0}
	};
  //aqui ponemos los que tienen un solo guion
  while((c = getopt_long (argc, argv, "sehg:",
		                long_options, &option_index))!=-1){
    switch(c){
      case 'g':
      gvalue=optarg;
      break;
      case 'a':
      avalue=optarg;
      break;
      case 'h':
      hflag=1;
      break;
      case 'e':
      eflag=1;
      break;
      case 's':
      sflag=1;
      break;
    }
  }

  if (hflag==1){
    help();
    exit (0);
  }

  if(gvalue!=NULL && avalue==NULL) {
    value=gvalue;
    gr=getgrnam (value);
  }else if(gvalue==NULL && avalue!=NULL) {
    value=avalue;
    gr=getgrnam (value);
 }else{
   avalue=getenv("USER");
   pw=getpwnam(avalue);
   gr=getgrgid(pw->pw_gid);
 }
  if(gr!=NULL){
    if(eflag==1 && sflag==0){
      english(gr);
    }
    else if(eflag==0 && sflag==1){
      spain(gr);
    }
    else if(eflag==0 && sflag==0){
      char *lang=NULL;
      lang=getenv("LANG");
      if(strstr(lang,"ES")){
        spain(gr);
      }
      else english(gr);
    }
}
else printf("Error, grupo no encontrado \n");
return 0;
}
