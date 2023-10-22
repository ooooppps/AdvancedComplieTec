%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>
    #define YYDEBUG 1
%}

%union{
    int num;
}

%token <num> NUM
%token ADD SUB MUL DIV NEWLINE LPAREN RPAREN

%type <num> expr term factor

%%
    line_list : line_list line
                |line;
    line:  expr NEWLINE {
        printf("(dec)>>%d\n", $1);
        printf("(oct)>>%o\n", $1);
        printf("(hex)>>%x\n", $1);
    };

    expr: term  
        |expr ADD term {$$ = $1 + $3;}
        | expr SUB term {$$ = $1 - $3;}
        | LPAREN expr RPAREN {$$ = $2;};
    term: factor
        | term MUL factor {$$ = $1 * $3;}
        | term DIV factor {$$ = $1 / $3;}
        | SUB factor {$$ = -$2;};
    factor: NUM;
%%

int yyerror(const char *s){
    extern char *yytext;
    fprintf(stderr, "error:%s, and maybe nearby %s\n", s, yytext);
    printf("%s, maybe nearby %s\n", s, yytext);
    return 0;
}

int main(){
    extern int yyparse(void);
    extern FILE* yyin;
    yyin = stdin;
    if (yyparse()){
        printf("error!error!error!\n");
        return 1;
    }
}

