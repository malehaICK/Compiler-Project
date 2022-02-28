grammar com ;

root : declaration function;
declaration : ('*' declarationlist '"' declarationtype '"')+  ;
declarationlist : 'include' ;
declarationtype : term ('.' term)? ;

function: main_func sub_func;

main_func : typeSpecifier 'main' '[' ']' block ;
sub_func : typeSpecifier 'subfunc' '[' (typeSpecifier term (',')?)+ ']' block ;


block : '(' statement ')' ;

statement :
	(var_stat
	|loop_stat
	|condition_stat
	|output_stat
	|break_stat
	|ifswitch
	|return_stat
	|method_call)+
	;

var_stat : 
	typeSpecifier expr (','expr)* ':' | expr ':'  ;
loop_stat: 
	for_stat| while_stat ;
for_stat: 
	'for' '[' forexpr ']' block ;
forexpr: 
	var '=' term ',' expr ',' var incr_op ;
while_stat:
	'while''['whilexpr']' block ;
whilexpr: 
	expr ',' expr;
condition_stat: 
	'IF' '[' expr ']' block ('ELIF' '[' expr ']' block)* ('ELSE' block)? 
		| 'SWITCH' '[' expr ']' block;
ifswitch : 
	'(' expr ')' 
	| (term ('('expr')')* '~' (output_stat|expr|break_stat) )+ ;
expr :   expr binop expr | expr relop expr | expr logical_op expr 
	| '(' expr ')'| expr term | term;
binop : 
	'plus' | 'minus' | 'multiply' | 'divide' ;
relop : 
	'greater than equal' | 'less than' | 'greater than' | 
	'less than equal' | '='|'!=' ;
logical_op :
	 '&&' | '||' ;
incr_op: 
	'increment'|'decrement' ;
method_call:
	  'subfunc' '[' (term (',')?)* ']' ':' ;
break_stat:
	 'break' ':' ;
output_stat:
	 'print' term ':' ;
return_stat:
	 'RETURN' term ':' | 'RETURN' ':' ;

typeSpecifier : 'int' | 'void' | 'float' ;
var : ID ;
term :ID |LIT ;
ID : [a-zA-Z]+ ;
LIT :[0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
