%{
    #include<stdio.h>
    #include "directives.h"

    int tok;

%}

delim       [ \t\n]
ws          {delim}+
letter      [a-zA-Z]
digit       [0-9]

id          {letter}({letter}|{digit})*
int_num     [+-]?[0-9]+
str         \"(([^""])|(\\\"))*\"   
comment     "#".* 

%%

{ws}        {}


".data"     { return T_DATA_DIRECTIVE;}
".space"    { return T_SPACE_DIRECTIVE;}
".byte"     { return T_BYTE_DIRECTIVE;}
".half"     { return T_HALF_DIRECTIVE;}
".word"     { return T_WORD_DIRECTIVE;}
".asciiz"   { return T_ASCIIZ_DIRECTIVE;}
".text"     { return T_TEXT_DIRECTIVE;}
".globl"    { return T_GLOBL_DIRECTIVE;}
<<EOF>>     { return T_END_DIRECTIVE;}
"$zero"     { return T_REG;}
"$at"       { return T_REG;}
"$v0"       { return T_REG;}
"$v1"       { return T_REG;}

"$a0"       { return T_REG;}
"$a1"       { return T_REG;}
"$a2"       { return T_REG;}
"$a3"       { return T_REG;}

"$t0"       { return T_REG;}
"$t1"       { return T_REG;}
"$t2"       { return T_REG;}
"$t3"       { return T_REG;}
"$t4"       { return T_REG;}
"$t5"       { return T_REG;}
"$t6"       { return T_REG;}
"$t7"       { return T_REG;}

"$s0"       { return T_REG;}
"$s1"       { return T_REG;}
"$s2"       { return T_REG;}
"$s3"       { return T_REG;}
"$s4"       { return T_REG;}
"$s5"       { return T_REG;}
"$s6"       { return T_REG;}
"$s7"       { return T_REG;}

"$t8"       { return T_REG;}
"$t9"       { return T_REG;}

"$k0"       { return T_REG;}
"$k1"       { return T_REG;}

"$gp"       { return T_REG;}
"$sp"       { return T_REG;}
"$fp"       { return T_REG;}
"$ra"       { return T_REG;}

":"         { return T_COLON;}
","         { return T_COMMA;}
"("         { return T_LB;}
")"         { return T_RB;}

"move"      { return T_MOVE;}
"add"       { return T_ADD;}
"addu"      { return T_ADDU;}
"subu"      { return T_SUBU;}
"li"        { return T_LOAD_IMMEDIATE;}
"la"        { return T_LOAD_ADDRESS;}
"lw"        { return T_LOAD_WORD;}
"sw"        { return T_STORE_WORD;}
"syscall"   { return T_SYSCALL;}
"j"         { return T_JUMP;}
"mult"      { return T_MULT;}
"mflo"      { return T_MFLO;}
"mfhi"      { return T_MFHI;}


{str}       { return T_STRING; }
{int_num}   { return T_INT_NUM;}
{id}        { return T_ID;}
{comment}   {  }

%%

void handleAdd();
void handleSub();
void handleDataDirective();
void handleLoadWord();
void handleLoadImmediate();
void handleStoreWord();
void handleTextDirective();
void hundleLoadAddress();
void hundleMove();
void hundleMult();
void hundleMflo();
void hundleMfhi();

int yywrap(){
    return T_END_DIRECTIVE;
}

int main(){
    printf("\n%s\n",__FUNCTION__);
    tok = yylex();
    while(tok != T_END_DIRECTIVE)
    {
        switch(tok)
        {
            case T_DATA_DIRECTIVE:
                tok = yylex();
                handleDataDirective();
                break;

            case T_TEXT_DIRECTIVE:
                tok = yylex();
                handleTextDirective();
                break;

            default:
                printf("ERROR!\n");
                exit(0);
                break;
        }
    }
}

void handleDataDirective(){
    printf("\n.data\n");
    while(tok == T_ID)
    {
        tok = yylex();
        if(tok == T_COLON)
        {
            tok = yylex();
            if(tok == T_WORD_DIRECTIVE)
            {
                printf("word - ");
                tok = yylex();
                if(tok == T_INT_NUM)
                {
                    printf("SUCCESS\n");
                }
            }
            else if(tok == T_SPACE_DIRECTIVE)
            {
                printf("space - ");
                tok = yylex();
                if(tok == T_INT_NUM)
                {
                    printf("SUCCESS\n");
                }
            }
            else if(tok == T_ASCIIZ_DIRECTIVE)
            {
                printf("asciiz - ");
                tok = yylex();
                if(tok == T_STRING)
                {
                    printf("SUCCESS\n");
                }
                
            }
        }
        tok = yylex();
    }
}

void handleTextDirective(){
    printf("\n.text\n");
    while(tok == T_ID){
        tok = yylex();
        if(tok == T_COLON){
            tok = yylex();
            while(tok != T_END_DIRECTIVE)
            {
                switch(tok)
                {
                    case T_LOAD_WORD:
                        handleLoadWord();
                        break;

                    case T_LOAD_IMMEDIATE:
                        handleLoadImmediate();
                        break;

                    case T_STORE_WORD:
                        handleStoreWord();
                        break;

                    case T_ADD:
                        handleAdd();
                        break;

                    case T_SUB:
                        handleSub();
                        break;

                    case T_LOAD_ADDRESS:
                        hundleLoadAddress();
                        break;

                    case T_MOVE:
                        hundleMove();
                        break;

                    case T_MULT:
                        hundleMult();
                        break;

                    case T_MFLO:
                        hundleMflo();
                        break;

                    case T_MFHI:
                        hundleMfhi();
                        break;


                }
                tok = yylex();
            }
        }
    }
}


void hundleMult(){
    printf("mult - ");
    tok = yylex();
    if(tok == T_REG){
        
        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_REG){

                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR!\n");
}

void hundleMflo(){
    printf("mflo - ");
    tok = yylex();
    if(tok == T_REG){

        printf("SUCCESS\n");
        return;
    }
    printf("ERROR!\n");
}

void hundleMfhi(){
    printf("mfhi - ");
    tok = yylex();
    if(tok == T_REG){

        printf("SUCCESS\n");
        return; 
    }
    printf("ERROR!\n");
}

void hundleMove(){
    printf("move - ");
    tok = yylex();
    if(tok == T_REG){

        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_REG){

                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR!\n");
}
 
void hundleLoadAddress(){
    printf("la - ");
    tok = yylex();
    if(tok == T_REG){

        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_ID){

                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR!\n");
    
}

void handleLoadWord()
{
    printf("lw - ");
    tok = yylex();
    if(tok == T_REG){
        
        tok = yylex();
        if(tok == T_COMMA){     

            tok = yylex();
            if(tok = T_ID){
                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR\n");
}

void handleLoadImmediate()
{
    printf("li - ");
    tok = yylex();
    if(tok == T_REG){
        
        tok = yylex();
        if(tok == T_COMMA){     

            tok = yylex();
            if(tok == T_INT_NUM){
                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR\n");
}

void handleStoreWord()
{
    printf("sw - ");
    tok = yylex();
    if(tok == T_REG){

        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_ID){
                printf("SUCCESS\n");
                return;
            }
        }
    }
    printf("ERROR\n");
}

void handleAdd(){
    printf("add - ");
    tok = yylex();
    if(tok == T_REG){

        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_REG){

                tok = yylex();
                if(tok == T_COMMA){

                    tok = yylex();
                    if(tok == T_REG){
                        printf("SUCCESS\n");
                        return;
                    }
                }
            }
        }
    }
    printf("ERROR\n");
}

void handleSub()
{
    printf("sub - ");
    tok = yylex();
    if(tok == T_REG){
        
        tok = yylex();
        if(tok == T_COMMA){

            tok = yylex();
            if(tok == T_REG){

                tok = yylex();
                if(tok == T_COMMA){

                    tok = yylex();
                    if(tok == T_REG){
                        printf("SUCESS\n");
                        return;
                    }
                }
            }
        }
    }
    printf("ERROR\n");
}