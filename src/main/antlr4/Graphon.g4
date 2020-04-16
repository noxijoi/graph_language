//header
grammar Graphon;

//parser rules

compilationUnit: function*
                mainBlock
                EOF;

mainBlock: MAIN block;

graphOperation:
     '(' graphOperation '+' graphOperation ')' #UNION
    | graphOperation '+' graphOperation #UNION

    | '(' graphOperation '-' graphOperation ')' #INTERSECTION
    |  graphOperation '-' graphOperation  #INTERSECTION

    | '(' graphOperation '\\' graphOperation ')' #DIFFERENCE
    |  graphOperation '\\' graphOperation  #DIFFERENCE

    | '(' graphOperation '*' graphOperation ')' #MULTIPLICATION
    |  graphOperation '*' graphOperation  #MULTIPLICATION;


function : functionSignature block;
functionSignature : (builtInType)? functionName '(' parameterList')' ;
parameterList: parameter (COMMA parameter)*;
functionName : ID ;
parameter : builtInType ID;


block: BLOCK_START statement* BLOCK_END;
statement :
    block
    | variableDeclaration
    | assignment
    | graphAssignation
    | printStatement
    | forStatement
    | returnStatement
    | ifStatement
    | whileStatement
    | exp;


variableDeclaration:
    graphDeclaration #GRAPH_DECLARATION
    | nodeDeclaration #NODE_DECLARATION
    | arcDeclaration #ARC_DECLARATION;

assignment: ID EQUALS exp;
printStatement: PRINT ID;
returnStatement: RETURN exp #RETURN_VALUE
    | RETURN #RETURN_VOID;
ifStatement :  'if'  ('(')? exp (')')? trueStatement=statement ('else' falseStatement=statement)?;

forStatement : 'for' ('(')? forConditions (')')? statement ;
forConditions : iterator=ID  'from' startExpr=exp range='to' endExpr=exp ;

whileStatement: WHILE  ('(')? exp (')')? statement;
exp:
    ID #VarRef
    |functionName '(' #FunctionCall
    | graphOperation #Operation
    | value  #ValueExpr
    | exp cmp='>' exp #ConditionalExpr
    | exp cmp='<' exp #ConditionalExpr
    | exp cmp='==' exp #ConditionalExpr
    | exp cmp='!=' exp #ConditionalExpr
    | exp cmp='>=' exp #ConditionalExpr
    | exp cmp='<=' exp #ConditionalExpr
    ;

graphDeclaration: GRAPH ID EQUALS '()';
nodeDeclaration: NODE ID EQUALS ('(' STRING ')'| '()');
arcDeclaration: ARC ID EQUALS ('('STRING ',' ID arrow ID ')' | '(' ID arrow ID ')');

graphAssignation: ID ASSIGN ID (COMMA ID)*;

builtInType: graphType| primitiveType;
graphType: GRAPH | NODE | ARC;
primitiveType: BOOL | INT | VOID;

arrow: R_ARROW | L_ARROW | LR_ARROW;
value: BOOL_VALUES | NUMBER | STRING;
//lexer rules
//graph types
GRAPH: 'graph';
NODE: 'node';
ARC: 'arc';
//oter primitive types
BOOL: 'bool';
INT: 'int';
VOID: 'void';


MAIN: 'main';
RETURN: 'return';
PRINT: 'print';

EQUALS: '=';
ASSIGN: ':';
R_ARROW: '->';
L_ARROW: '<-';
LR_ARROW: '--';
COMMA: ',';

BLOCK_START: '{';
BLOCK_END: '}';

EMPTY_BRACKETS: '()';
ID : [a-zA-Z0-9]+ ;
NUMBER: [0-9]+;
STRING : '"'~('\r' | '\n' | '"')*'"' ;
BOOL_VALUES: 'true' | 'false';
WS: [\t\r\n' ']+ -> skip;
