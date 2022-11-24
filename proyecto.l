%{
#include "proyecto.tab.h"
%}
%%
"MAIN"  {return PALABRA_RESERVADA_MAIN;}
"DEC"   {return PALABRA_RESERVADA_DEC;}
"INPUT" {return PALABRA_RESERVADA_INPUT;}
"OUTPUT" {return PALABRA_RESERVADA_OUTPUT;}
";" {return SEPARADOR_SENTENCIA;}
"=" {return ASIGNACION;}
"+" {return SUMA;}
"-" {return RESTA;}
"*" {return MULTIPLICACION;}
"/" {return DIVISION;}
"," {return COMA;}
"{" {return INICIO_BLOQUE;}
"}" {return FIN_BLOQUE;}
([a-zA-Z]+[0-9]*)+ {strcpy( yylval.cadena,yytext); return IDENTIFICADOR;}
[0-9]+  {strcpy( yylval.cadena,yytext);return ENTERO;}
.   {}
%%




