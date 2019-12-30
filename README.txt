#############################################################################
#######################   CALCULADORA MIPS   ################################
#############################################################################


-->Operações disponíveis:
'+' adição
'-' subtração
'*' multiplicação
'/' divisão
'!' inversão (bitwise)

-->Como usar:
1) escolha qual o tipo de dados dos operandos:

'I' ou 'i' inteiro
'F' ou 'f' float
'D' ou 'd' double

2) escolha a operação
3) digite os dois operandos em decimal (no caso da inversão, só é preciso digitar um)
4) após o digitar cada operando, será printado na tela o valor hexadecimal dos mesmos
5) o resultado será printado na tela em hexadecimal
6) escolha se deseja continuar fazendo operações ou se deseja sair do programa

-->Observações:
1) Estouro de precisão causará a impressão da mensagem 'Overflow' na tela, juntamente com o posterior encerramento da atual operação
2) Os números podem ser impressos em 32 bits ou 64 bits, a depender da operação. A impressão de números de 64 bits se dá da seguinte forma:

'0x000001010x00000000', que, de maneira usual, corresponde ao número '0x0000010100000000'

***

Programada por Lucas Gabriel Mendes Miranda, 10265892
