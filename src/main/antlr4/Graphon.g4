//header
grammar Graphon;

//parser rules
variable: GRAPH | NODE | ARC ID;
print: PRINT ID;


//lexer rules
GRAPH : 'graph';
NODE: 'node';
ARC: 'arc';

PRINT: 'print';

ASSIGN: ':';
R_ARROW: '->';
L_ARROW: '<-';
LR_ARROW: '<->';

ID : [a-zA-Z0-9]+ ;
NUMBER: [0-9]+;
STRING : '"'.*'"' ;
WS: [\t\n\r]+ -> skip;
