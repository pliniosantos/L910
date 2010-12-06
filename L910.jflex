package com.L910;

import java_cup.runtime.*;

%%

%class Lexer
%unicode
%cup
%line
%column

/* %implements java_cup.runtime.Scanner */
%function next_token
%type java_cup.runtime.Symbol

%{
	public Lexer(java.io.InputStream r, SymbolFactory sf){
		this(r);
		this.sf=sf;
	}
	private SymbolFactory sf;
%}

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

%eofval{
  return new java_cup.runtime.Symbol(sym.EOF);
%eofval}

LineTerminator       = \r|\n|\r\n
WhiteSpace           = {LineTerminator} | [ \t\f]
Semi_Ident           = _* [:jletterdigit:]*
Ident                = [:jletter:] { Semi_Ident }*
InputCharacter       = [^\r\n]
TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}

/* Comentarios */
Commentario = {TraditionalComment} | {EndOfLineComment}

%%

/* palavras reservadas */
"int"                       { return symbol(sym.INT); }
"boolean"                   { return symbol(sym.BOOLEAN); }
"string"                    { return symbol(sym.STRING); }
"void"                      { return symbol(sym.VOID); }
"true"                      { return symbol(sym.TRUE); }
"false"                     { return symbol(sym.FALSE); }
"if"                        { return symbol(sym.IF); }
"else"                      { return symbol(sym.ELSE); }
"while"                     { return symbol(sym.WHILE); }
"ref"                       { return symbol(sym.REF); }
"read"                      { return symbol(sym.READ); }
"readln"                    { return symbol(sym.READLN); }
"print"                     { return symbol(sym.PRINT); }
"println"                   { return symbol(sym.PRINTLN); }
"inc"                       { return symbol(sym.INC); }
"dec"                       { return symbol(sym.DEC); }
"return"                    { return symbol(sym.RETURN); }

/* Separadores */
","                         { return symbol(sym.VIRGULA); }
";"                         { return symbol(sym.PTO_VIRGULA); }
"("                         { return symbol(sym.L_PAREN); }
")"                         { return symbol(sym.R_PAREN); }
"{"                         { return symbol(sym.L_CHAVE); }
"}"                         { return symbol(sym.R_CHAVE); }
"["                         { return symbol(sym.L_COLCH); }
"]"                         { return symbol(sym.R_COLCH); }

/* Operadores Aritimeticos */
"+"                         { return symbol(sym.PLUS); }
"-"                         { return symbol(sym.MINUS); }
"*"                         { return symbol(sym.TIMES); }
"/"                         { return symbol(sym.DIV); }
"%"                         { return symbol(sym.RES); }

/* Operadores logicos */
"="                         { return symbol(sym.ATR); }
"=="                        { return symbol(sym.EQ); }
"<"                         { return symbol(sym.LT); }
"<="                        { return symbol(sym.LEQ); }
">"                         { return symbol(sym.MT); }
">="                        { return symbol(sym.MEQ); }
"!"                         { return symbol(sym.NOT); }
"||"                        { return symbol(sym.OR); }
"&&"                        { return symbol(sym.AND); }

/* regras */
{ Ident }                   { return symbol(sym.IDENT, yytext()); }

/* FIM */
{ WhiteSpace }              { /* Ignora */ }
.|\n                        { System.out.println(" --- FIM ---"); throw new Error("Illegal character <"+
                                yytext()+">"); }

