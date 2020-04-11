//header
grammar Graphon;

//parser rules

compilationUnit: function*
                exp* EOF;

exp: (variableDeclaration
       | preDefinedActions
       | graphAssignation
       |)
    EXP_END;

graphOperation:
    functionCall #FUNCALL
    | '(' graphOperation '+' graphOperation ')' #UNION
    | graphOperation '+' graphOperation #UNION

    | '(' graphOperation '-' graphOperation ')' #INTERSECTION
    |  graphOperation '-' graphOperation  #INTERSECTION

    | '(' graphOperation '\\' graphOperation ')' #DIFFERENCE
    |  graphOperation '\\' graphOperation  #DIFFERENCE

    | '(' graphOperation '*' graphOperation ')' #MULTIPLICATION
    |  graphOperation '*' graphOperation  #MULTIPLICATION;


function : functionDeclaration '{' (blockStatement)* '}' ;
functionDeclaration : (built_in_type)? functionName '('functionArgument*')' ;
functionName : ID ;
functionArgument : built_in_type ID;


functionCall : functionName '('expressionList ')';
expressionList : exp (',' exp)* ;

blockStatement : variableDeclaration
               | preDefinedActions
               | functionCall ;
variableDeclaration: graphDeclaration
    | nodeDeclaration
    | arcDeclaration
    | ID EQUALS exp;

graphDeclaration: GRAPH ID EQUALS '()';
nodeDeclaration: NODE ID EQUALS ('(' STRING ')'| '()');
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
