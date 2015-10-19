import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;

 
%%

%line
%column
%unicode
%public
%class Lexer
%implements sym
%cup

%{	
    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}


ws = [ \t\r\n]
coment = "/*"~"*/"
delim = "("|")"|"["|"]"|"{"|"}"

digit = [1-9] 
id = (_|[a-z]|[A-Z])(_|[a-z]|[A-Z]|{digit}|0)*
numeroI = ({digit}+(0|{digit})*)|0 
fraci = {numeroI}+(\.numeroI*)

%%
"class" {System.out.println(yytext());}
"public" {System.out.println(yytext());}
"extends" {System.out.println(yytext());}
"static" {System.out.println(yytext());}
"void" {System.out.println(yytext());}
"int" {System.out.println(yytext().toString());}
"boolean" {System.out.println(yytext());}
"while" {System.out.println(yytext());}
"if" {System.out.println(yytext());}
"else" {System.out.println(yytext());}
"return" {System.out.println(yytext());}
"||" {System.out.println(yytext());}
"&&" {System.out.println(yytext());}
"==" {System.out.println(yytext());}
"!=" {System.out.println(yytext());}
"<" {System.out.println(yytext());}
"<=" {System.out.println(yytext());}
">" {System.out.println(yytext());}
">=" {System.out.println(yytext());}
("+" | "-" | "*" | "/" | "%") {System.out.println(yytext());} 
"false" {System.out.println(yytext());}
"true" {System.out.println(yytext());}
"this" {System.out.println(yytext());}
"new" {System.out.println(yytext());}
{ws} {}
{coment} {}
{delim} {System.out.println(yytext());}
{digit} {System.out.println(yytext());}
{id} {System.out.println(yytext());}
{numeroI} {System.out.println(yytext());}
{fraci} {System.out.println(yytext());}