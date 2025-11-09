%{
#include <stdio.h>
#include <stdlib.h>
int line_number = 1;
void print_token(const char *token_type, const char *lexeme) {
    printf("Line %d: %s → %s\n", line_number, token_type, lexeme);
}
void report_error(const char *lexeme) {
    printf("Line %d: ERROR → %s (invalid token)\n", line_number, lexeme);
}
%}

%option noyywrap

/* Regular Expression Definitions */
DIGIT           [0-9]
LETTER          [a-zA-Z]
UNDERSCORE      [_]
ID              [a-zA-Z_][a-zA-Z0-9_]*
FLOAT           -?[0-9]*\.[0-9]+
INTEGER         -?[0-9]+
WHITESPACE      [ \t]
NEWLINE         \n
/* Khadoos Teacher Language: Keywords (15) */
KHAMOSHI        Khamoshi
DEKHLO          Dekhlo
NAHINTOH        Nahintoh
JABTAK          Jab-tak
SAAREBACHE      Saare-bache
CLASSBAHIR      Class-se-bahir
CHORDO          Chordo
JAWABDO         Jawab-do
KITNENUMBER     Kitne-number
PERCENTOGE      Percentoge
NAAMBATAO       Naam-batao
KUCHNAHIN       Kuch-nahin
HAMESHA         hamesha
FOILHE          Foil-he
FAILHO          Fail-ho

/* Operators */
JAMA            Jama
MINUS           minus
GUNA            guna
TAQSEEM         Taqseem
ZYADA           zyada
KAM             Kam
BARABAR         barabar
AUR             aur
YA              Ya
LIKHD0          likh-do

/* Punctuation */
BAS             bas!
ESHKROZ         Eshuru-Kroz
KNATAMKRO       knatam-Kro

%%

{NEWLINE}           { line_number++; }
{WHITESPACE}        { /* Skip whitespace */ }

{KHAMOSHI}          { print_token("KEYWORD", yytext); }
{DEKHLO}            { print_token("KEYWORD", yytext); }
{NAHINTOH}          { print_token("KEYWORD", yytext); }
{JABTAK}            { print_token("KEYWORD", yytext); }
{SAAREBACHE}        { print_token("KEYWORD", yytext); }
{CLASSBAHIR}        { print_token("KEYWORD", yytext); }
{CHORDO}            { print_token("KEYWORD", yytext); }
{JAWABDO}           { print_token("KEYWORD", yytext); }
{KITNENUMBER}       { print_token("KEYWORD", yytext); }
{PERCENTOGE}        { print_token("KEYWORD", yytext); }
{NAAMBATAO}         { print_token("KEYWORD", yytext); }
{KUCHNAHIN}         { print_token("KEYWORD", yytext); }
{HAMESHA}           { print_token("KEYWORD", yytext); }
{FOILHE}            { print_token("KEYWORD", yytext); }
{FAILHO}            { print_token("KEYWORD", yytext); }

{FLOAT}             { print_token("FLOAT", yytext); }
{INTEGER}           { print_token("INTEGER", yytext); }

{JAMA}              { print_token("OPERATOR", yytext); }
{MINUS}             { print_token("OPERATOR", yytext); }
{GUNA}              { print_token("OPERATOR", yytext); }
{TAQSEEM}           { print_token("OPERATOR", yytext); }
{ZYADA}             { print_token("OPERATOR", yytext); }
{KAM}               { print_token("OPERATOR", yytext); }
{BARABAR}           { print_token("OPERATOR", yytext); }
{AUR}               { print_token("OPERATOR", yytext); }
{YA}                { print_token("OPERATOR", yytext); }
{LIKHD0}            { print_token("OPERATOR", yytext); }

{BAS}               { print_token("PUNCTUATION", yytext); }
{ESHKROZ}           { print_token("PUNCTUATION", yytext); }
{KNATAMKRO}         { print_token("PUNCTUATION", yytext); }


{ID}                { print_token("IDENTIFIER", yytext); }

.                   { report_error(yytext); }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            return 1;
        }
    }
    yylex();
    return 0;
}
