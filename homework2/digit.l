%{
 #include <stdio.h>
 #include <stdlib.h>
 #include "y.tab.h"
 
int yywrap(void)
{
     return 1;
}
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"\n" { return NEWLINE; }
"(" { return LPAREN; }
")" { return RPAREN; }

((([1-9][0-9]*)|0|(0[1-7][0-7]*)|(0[xX](0|[1-9a-fA-F][0-9a-fA-F]*)))) {
    char* endptr;
    yylval.num = strtoul(yytext, &endptr, 0);
    return NUM;
};


[ \t] ;
 . {
     fprintf(stderr, "lexical error.\n");
     exit(1);
}
%%