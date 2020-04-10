//header
grammar Graphon;

//parser rules

compilationUnit: exp* EOF;

exp: (variableDeclaration |
        preDefinedActions |
        graphAssignation)
    EXP_END;
variableDeclaration: graphDeclaration | nodeDeclaration | arcDeclaration;

graphDeclaration: GRAPH ID EQUALS EMPTY_BRACKETS;
nodeDeclaration: NODE ID EQUALS ('(' STRING ')'| EMPTY_BRACKETS);
arcDeclaration: ARC ID EQUALS ('('STRING ',' ID arrow ID ')' |'(' ID arrow ID ')');

graphAssignation: ID ASSIGN ID (COMMA ID)*;

preDefinedActions: print;

print: PRINT ID;


built_in_type: GRAPH | NODE | ARC;
arrow: R_ARROW | L_ARROW | LR_ARROW;

//lexer rules
GRAPH: 'graph';
NODE: 'node';
ARC: 'arc';

PRINT: 'print';

EQUALS: '=';
ASSIGN: ':';
R_ARROW: '->';
L_ARROW: '<-';
LR_ARROW: '--';
COMMA: ',';

EMPTY_BRACKETS: '()';
EXP_END: '\n';
ID : [a-zA-Z0-9]+ ;
NUMBER: [0-9]+;
STRING : '"'.*'"' ;
WS: [\t\r' ']+ -> skip;
