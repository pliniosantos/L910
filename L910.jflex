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

%%

/* Palavras reservadas */

"int"                       { System.out.println("Tipo INT"); return symbol(sym.INT); }
"boolean"                   { System.out.println("Tipo BOOLEAN"); return symbol(sym.BOOLEAN); }

/* Simbolos */
","                         { System.out.println("VIRGULA"); return symbol(sym.VIRGULA); }
";"                         { System.out.println("PTO_VIRGULA"); return symbol(sym.PTO_VIRGULA); }

/* regras */
{ Ident }                   { System.out.println("eh um IDENT"); return symbol(sym.IDENT, yytext()); }

/* FIM */
{ WhiteSpace }              { /* Ignora */ }
.|\n                        { System.out.println(" --- FIM ---"); throw new Error("Illegal character <"+
                                yytext()+">"); }

