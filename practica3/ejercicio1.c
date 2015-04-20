#include <unistd.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <pwd.h>
#include <grp.h>
#include <unistd.h>
#include <string.h>

//mostrar los datos en español
void mostrares(struct passwd *pw,int gflag){
	 	printf("Nombre:%s\n",pw->pw_gecos);
		printf("ID:%d\n",pw->pw_uid);
		printf("Contraseña:%s\n",pw->pw_passwd);
		printf("Home:%s\n",pw->pw_dir);
		printf("Interprete predeterminado:%s\n",pw->pw_shell);
		if(gflag==1){
			struct group *gr;
			gr = getgrgid(pw->pw_gid);
			printf("Grupo ID:%d\n",pw->pw_gid);
			printf("Nombre del grupo: %s\n",gr->gr_name);
	 	}
}

//mostrar los datos en ingles
void mostraren(struct passwd *pw,int gflag){
printf("User name:%s\n",pw->pw_gecos);
		printf("User ID:%d\n",pw->pw_uid);
		printf("Password:%s\n",pw->pw_passwd);
		printf("Home:%s\n",pw->pw_dir);
		printf("Default shell:%s\n",pw->pw_shell);
		if(gflag==1){
			struct group *gr;
			gr = getgrgid(pw->pw_gid);
			printf("Group number:%d\n",pw->pw_gid);
			printf("Group name: %s\n",gr->gr_name);
		}
}

int
main (int argc, char **argv)
{
	int eflag=0,sflag=0,gflag=0;
	char *lang;
	int c;
	char *nvalue=NULL;
	int uvalue=0;
	struct passwd *pw;
	opterr=0;
	 while ((c = getopt (argc, argv, "esgn:u:")) != -1){
	 	switch(c)
	 	{
	 		case 'n':
	 		nvalue=optarg;
	 		break;

	 		case 'u':
	 		uvalue=atoi(optarg);
	 		break;
			//se mostrará en ingles
	 		case 'e':
	 		eflag=1;
	 		break;
			//se mostrará en español
			case 's':
			sflag=1;
			break;
			//se mostrara la informacion del grupo GID y nombre del grupo
			case 'g':
			gflag=1;
			break;

	 		case '?':
	 		break;
	 		default:
	 		abort();
	 	}
	 }

	 //Comprobamos que no esta la opcion 'n' y 'u'
	 if (nvalue!=NULL && uvalue!=0){
	 	printf("Error in parametres\n");
	 	exit -1;
	 }
	if(nvalue==NULL && uvalue==0){
		nvalue=getenv("USER");
	}

	 //si es por nvalue
	 if(nvalue!=NULL){
	 	lang=getenv("LANG");
			 	if((pw = getpwnam(nvalue))==NULL)
			 	{
			 		printf("Error");
			 		exit -1;
			 	}
				 if(sflag == 1){
					mostrares(pw,gflag);
			 		}
	 	else if(eflag == 1){
	 	mostraren(pw,gflag);
	 	}
	 	else{
	 		if(strstr(lang,"ES")){
	 		mostrares(pw,gflag);
	 		}
	 		else if(strstr(lang,"EN")){
	 		mostraren(pw,gflag);
	 	  }
	 	}
		}


	 if (uvalue!=0){
	 	lang=getenv("LANG");
	 	if((pw = getpwuid(uvalue))==NULL)
	 	{
	 		printf("Error");
	 		exit -1;
	 	}
		mostrares(pw,gflag);
	 }

	 return 0;
}
