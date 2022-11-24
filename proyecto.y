%{
#include <stdio.h>
#include<string.h>
void yyerror(char *mensaje);
int yylex(); 
void nuevatemp(char *s); //genera variables temporales
%}
%union{
    char cadena[50];
}
%token SEPARADOR_SENTENCIA ASIGNACION COMA RESTA POTENCIACION
%token PALABRA_RESERVADA_MAIN PALABRA_RESERVADA_DEC INICIO_BLOQUE FIN_BLOQUE PALABRA_RESERVADA_INPUT
%token PALABRA_RESERVADA_OUTPUT SUMA DIVISION MULTIPLICACION
%token <cadena> ENTERO 
%token <cadena> IDENTIFICADOR
%type <cadena> inicio
%type <cadena> expresion
%type <cadena> termino
%type <cadena> termino2
%type <cadena> factor
%type <cadena> variable
%type <cadena> numero
%%


inicio:  PALABRA_RESERVADA_MAIN INICIO_BLOQUE bloque FIN_BLOQUE  {printf("------------------\n");}  
        ;
bloque: sentencia otra_sentencia
        ;
sentencia: declaracion
        | lectura
        | escritura
        | asignacion
        ;
otra_sentencia: sentencia otra_sentencia
                | 
                ;
declaracion: PALABRA_RESERVADA_DEC variables SEPARADOR_SENTENCIA
           ;
variables: IDENTIFICADOR variables
        | COMA IDENTIFICADOR variables
        |
        ;
lectura: PALABRA_RESERVADA_INPUT IDENTIFICADOR SEPARADOR_SENTENCIA      {printf("call input\npop %s\n",$2);}
        ;
escritura: PALABRA_RESERVADA_OUTPUT IDENTIFICADOR SEPARADOR_SENTENCIA {printf("push %s\ncall output\n",$2);}
        ;
asignacion: variable ASIGNACION expresion SEPARADOR_SENTENCIA   {printf("%s=%s\n",$1,$3);}
         ;
expresion   :   expresion SUMA termino  {nuevatemp($$); printf("%s=%s+%s\n",$$,$1,$3);}
            |   expresion RESTA termino {nuevatemp($$); printf("%s=%s-%s\n",$$,$1,$3);}
            |   termino                 
            ;

termino     :   termino MULTIPLICACION termino2 {nuevatemp($$); printf("%s=%s*%s\n",$$,$1,$3);}
            |   termino DIVISION termino2 {nuevatemp($$); printf("%s=%s/%s\n",$$,$1,$3);}
            |   termino2                  
            ;
termino2    : termino2 POTENCIACION factor {nuevatemp($$); printf("%s=%s^%s\n",$$,$1,$3);}
            | factor 

factor      :   ENTERO    
            |   IDENTIFICADOR
            ;
variable: IDENTIFICADOR;
numero: ENTERO;


%%
void nuevatemp(char *s){
    static int actual = 1;
    sprintf(s,"t%d", actual++);
}
void yyerror(char *mensaje){
    fprintf(stderr, "Error: %s\n", mensaje);
}


int main(){
    yyparse();
    return 0;
}