#-------------------------------------------------------------------------------
# Lucas G. Mendes Miranda, 10265892
#-------------------------------------------------------------------------------

.data
	mensagem1:	.asciiz	"DataType: "
	mensagem2:	.asciiz	"\nOperation: "
	mensagem3:	.asciiz	"\nResult: "
	mensagem4:	.asciiz	"\nOverflow"
	mensagem5:	.asciiz	"\nInvalid choice, try again."
	mensagem6:	.asciiz	"\nEnd of program"
	mensagem7:	.asciiz "\nRepeat? Y = Yes, N = No"
	newLine:	.asciiz	"\n"
	inputChar:	.space	1
	valor1:		.space	8
	valor2:		.space	8
	zero:		.double	0.0
	flag:		.byte	1  #para dizer se quer continuar calculando ou não (1 - quer, 2 - não quer)

.text
#--------------------------------------------------------------------------------
# Procedimento principal do programa.
#
	main:
		#flag overflow ($t8), inicialmente nula:
		addi		$t8, $zero, 0
		ldc1		$f30, zero
		lb		$t9, flag
		
		while:
			#testa:
			beq		$t9, 0, exit
			
			#pergunta qual o tipo de dados trabalhado:
			la		$t4, newLine
			jal		printString
			
			la		$t4, mensagem1
			jal		printString
			
			#pega a resposta do usuário e coloca em inputChar:
			la		$t4, inputChar
			jal		getChar
			
			#decide o próximo passo conforme a entrada do usuário:
			lb		$t4, inputChar  
			
			beq		$t4, 73, inteiro  #vê se o tipo de dados foi 'I'
			beq		$t4, 105, inteiro  #vê se o tipo de dados foi 'i'
			
			beq		$t4, 70, float  #vê se o tipo de dados foi 'F'
			beq		$t4, 102, float  #vê se o tipo de dados foi 'f'
			
			beq		$t4, 68, double  #vê se o tipo de dados foi 'D'
			beq		$t4, 100, double  #vê se o tipo de dados foi 'd'						 		 					 		 		
			
			inteiro:
				#pergunta  a operação:
				la		$t4, mensagem2
				jal		printString
				
				#pega a resposta do usuário e coloca em inputChar:
				la		$t4, inputChar
				jal		getChar	
				
				#decide o próximo passo conforme a entrada do usuário:
				lb 		$t4, inputChar  										
				
				beq		$t4, 43, adicaoInteiro  #checa se a operação foi '+'
				beq		$t4, 45, subtracaoInteiro  #checa se a operação foi '-'
				beq		$t4, 42, multiplicacaoInteiro  #checa se a operacao foi '*'
				beq		$t4, 47, divisaoInteiro  #checa se a operação foi '/'
				beq		$t4, 33, inversaoInteiro  #checa se a operação foi '!'
				
				adicaoInteiro:
					#coloca os valores 1 e 2 nos registradores $t1 e $t2 (#PVF):
					la		$t4, newLine
					jal		printString
					
					jal 		getInt
					beq		$t8, 1, terminouOperacao					
					addi		$t1, $v0, 0
					move		$t4, $t1
					jal		printInt
					
					la		$t4, newLine
					jal		printString
										
					jal		getInt
					beq		$t8, 1, terminouOperacao						
					addi		$t2, $v0, 0
					move		$t4, $t2
					jal		printInt					
					
					#realiza a soma e coloca o resultado em $t3:
					add		$t3, $t1, $t2
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printAddInt  #se não ocorreu overflow, imprime o resultado	
					j		terminouOperacao													
					
					#se não ocorreu overflow, imprime o resultado:
					printAddInt:
					la		$t4, newLine
					jal		printString					
					
					add		$t4, $t3, $zero
					jal		printInt 
					
					j		terminouOperacao
					
				subtracaoInteiro:
					#coloca os valores 1 e 2 nos registradores $t1 e $t2 (#OCF):
					la		$t4, newLine
					jal		printString
					
					jal 		getInt
					beq		$t8, 1, terminouOperacao					
					addi		$t1, $v0, 0
					move		$t4, $t1
					jal		printInt
					
					la		$t4, newLine
					jal		printString
										
					jal		getInt	
					beq		$t8, 1, terminouOperacao					
					addi		$t2, $v0, 0
					move		$t4, $t2
					jal		printInt					
					
					#realiza a subtração e coloca o resultado em $t3:
					sub		$t3, $t1, $t2 					 			 			
				
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printSubInt  #se não ocorreu overflow, imprime o resultado	
					j		terminouOperacao																				
					
					#se não ocorreu overflow, imprime o resultado:
					printSubInt:
					la		$t4, newLine
					jal		printString						
					
					add		$t4, $t3, $zero
					jal		printInt 
					
					j		terminouOperacao
					
				multiplicacaoInteiro:
					#coloca os valores 1 e 2 nos registradores $t1 e $t2(#OCF):
					la		$t4, newLine
					jal		printString
					
					jal 		getInt
					beq		$t8, 1, terminouOperacao										
					addi		$t1, $v0, 0
					move		$t4, $t1
					jal		printInt
					
					la		$t4, newLine
					jal		printString
										
					jal		getInt	
					beq		$t8, 1, terminouOperacao					
					addi		$t2, $v0, 0
					move		$t4, $t2
					jal		printInt					
					
					#realiza a multiplicação e coloca o resultado em $t3:
					mul		$t3, $t1, $t2 					 			 			
				
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printMulInt  #se não ocorreu overflow, imprime o resultado	
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printMulInt:
					la		$t4, newLine
					jal		printString					
					
					#imprime msb:
					mfhi		$t4
					jal		printInt
					
					#imprime lsb:
					add		$t4, $t3, $zero
					jal		printInt 
					
					j		terminouOperacao
					
				divisaoInteiro:
					#coloca os valores 1 e 2 nos registradores $t1 e $t2(#OCF):
					la		$t4, newLine
					jal		printString
					
					jal 		getInt
					beq		$t8, 1, terminouOperacao										
					addi		$t1, $v0, 0
					move		$t4, $t1
					jal		printInt
					
					la		$t4, newLine
					jal		printString
										
					jal		getInt	
					beq		$t8, 1, terminouOperacao					
					addi		$t2, $v0, 0
					move		$t4, $t2
					jal		printInt						
					
					#realiza a divisão e coloca o resultado em $t3:
					div		$t3, $t1, $t2 					 			 			
				
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printDivInt  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printDivInt:
					la		$t4, newLine
					jal		printString						
					
					add		$t4, $t3, $zero
					jal		printInt 
					
					j		terminouOperacao
					
				inversaoInteiro:
					#coloca o valor 1 no registrador $t1:
					la		$t4, newLine
					jal		printString
					
					jal 		getInt
					beq		$t8, 1, terminouOperacao										
					addi		$t1, $v0, 0
					move		$t4, $t1
					jal		printInt										
					
					#realiza a inversão e coloca o resultado em $t3:
					not		$t3, $t1 					 			 			
				
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printInvInt  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printInvInt:
					la		$t4, newLine
					jal		printString						
					
					add		$t4, $t3, $zero
					jal		printInt 
					
					j		terminouOperacao																																																																															
																				
			float:
				#pergunta a operação:
				la		$t4, mensagem2
				jal		printString
				
				
				#pega a resposta do usuário e coloca em inputChar:
				la		$t4, inputChar
				jal		getChar									
				
				#decide o próximo passo conforme a entrada do usuário:
				lb		$t4, inputChar
				
				beq		$t4, 43, adicaoFloat  #vê se a operação foi '+'
				beq		$t4, 45, subtracaoFloat  #vê se a operação foi '-'
				beq		$t4, 42, multiplicacaoFloat  #vê se a operacao foi '*'
				beq		$t4, 47, divisaoFloat  #vê se a operação foi '/'
				beq		$t4, 33, inversaoFloat  #vê se a operação foi '!'				  						  						
				
				adicaoFloat:
					#coloca os valores 1 e 2 nos registradores $f1 e $f2:
					la		$t4, newLine
					jal		printString
					
					jal 		getFloat
					beq		$t8, 1, terminouOperacao										
					add.s		$f1, $f0, $f30
					mov.s		$f4, $f1
					jal		printFloat
					
					la		$t4, newLine
					jal		printString
										
					jal		getFloat	
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					mov.s		$f4, $f2
					jal		printFloat					
					
					#realiza a adição e coloca o resultado em $f3:
					add.s		$f3, $f1, $f2																				
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printAddFloat  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao						
					
					#se não ocorreu overflow, imprime o resultado:
					printAddFloat:
					la		$t4, newLine
					jal		printString					
					
					add.s		$f4, $f3, $f30
					jal		printFloat 
					
					j		terminouOperacao
					
				subtracaoFloat:
					#coloca os valores 1 e 2 nos registradores $f1 e $f2:
					la		$t4, newLine
					jal		printString
					
					jal 		getFloat
					beq		$t8, 1, terminouOperacao										
					add.s		$f1, $f0, $f30
					mov.s		$f4, $f1
					jal		printFloat
					
					la		$t4, newLine
					jal		printString
										
					jal		getFloat	
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					mov.s		$f4, $f2
					jal		printFloat					
					
					#realiza a subtração e coloca o resultado em $f3:
					sub.s		$f3, $f1, $f2					
			
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printSubFloat  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao														
					
					#se não ocorreu overflow, imprime o resultado:
					printSubFloat:
					la		$t4, newLine
					jal		printString						
					
					add.s		$f4, $f3, $f30
					jal		printFloat 
					
					j		terminouOperacao
				multiplicacaoFloat:
					#coloca os valores 1 e 2 nos registradores $f1 e $f2:
					la		$t4, newLine
					jal		printString
					
					jal 		getFloat
					beq		$t8, 1, terminouOperacao										
					add.s		$f1, $f0, $f30
					mov.s		$f4, $f1
					jal		printFloat
					
					la		$t4, newLine
					jal		printString
										
					jal		getFloat	
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					mov.s		$f4, $f2
					jal		printFloat						
					
					#realiza a multiplicação e coloca o resultado em $f3:
					mul.s		$f3, $f1, $f2
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printMulFloat  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao																																			
					
					#se não ocorreu overflow, imprime o resultado:
					printMulFloat:
					la		$t4, newLine
					jal		printString						
					
					add.s		$f4, $f3, $f30
					jal		printFloat 
					
					j		terminouOperacao
					
				divisaoFloat:
					#coloca os valores 1 e 2 nos registradores $f1 e $f2:
					la		$t4, newLine
					jal		printString
					
					jal 		getFloat
					beq		$t8, 1, terminouOperacao										
					add.s		$f1, $f0, $f30
					mov.s		$f4, $f1
					jal		printFloat
					
					la		$t4, newLine
					jal		printString
										
					jal		getFloat	
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					mov.s		$f4, $f2
					jal		printFloat						
					
					#realiza a divisao e coloca o resultado em $f3:
					div.s		$f3, $f1, $f2
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printDivFloat  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printDivFloat:
					la		$t4, newLine
					jal		printString						
					
					add.s		$f4, $f3, $f30
					jal		printFloat 
					
					j		terminouOperacao
					
				inversaoFloat:
					#coloca os valores 1 e 2 nos registradores $f1 e $f2:
					la		$t4, newLine
					jal		printString
					
					jal 		getFloat
					mfc1		$t1, $f0
					beq		$t8, 1, terminouOperacao										
					add.s		$f1, $f0, $f30
					mov.s		$f4, $f1
					jal		printFloat
					
					#realiza a inversão e coloca o resultado em $f3:
					not		$t3, $t1
					mtc1		$t3, $f3 					 			 			
				
					bne		$t8, 1, printInvFloat  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printInvFloat:
					la		$t4, newLine
					jal		printString						
					
					add.s		$f4, $f3, $f30
					jal		printFloat 
					
					j		terminouOperacao			
			
			double:
				#pergunta a operação
				la		$t4, mensagem2
				jal		printString
				
				#pega a resposta do usuário e coloca em inputChar:
				la		$t4, inputChar
				jal		getChar		
				
				#decide o próximo passo conforme a entrada do usuário:
				lb		$t4, inputChar  																			
					
				beq		$t4, 43, adicaoDouble  #vê se a operação foi '+'
				beq		$t4, 45, subtracaoDouble  #vê se a operação foi '-'
				beq		$t4, 42, multiplicacaoDouble  #vê se a operacao foi '*'
				beq		$t4, 47, divisaoDouble  #vê se a operação foi '/'
				beq		$t4, 33, inversaoDouble  #vê se a operação foi '!'
							
				adicaoDouble:
					#coloca os valores 1 e 2 nos registradores $f2$f3 e $f4$f5:
					la		$t4, newLine
					jal		printString
					
					jal 		getDouble
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					add.s		$f3, $f1, $f30					
					
					mov.s		$f4, $f2
					mov.s		$f5, $f3					
					jal		printDouble
					
					la		$t4, newLine
					jal		printString
										
					jal		getDouble
					beq		$t8, 1, terminouOperacao						
					add.s		$f4, $f0, $f30
					add.s		$f5, $f1, $f30	
					jal 		printDouble
																						
					
					#realiza a adição e coloca o resultado em $f6$f7:
					add.d		$f6, $f2, $f4
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printAddDouble  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao																		
					
					#se não ocorreu overflow, imprime o resultado:
					printAddDouble:
					la		$t4, newLine
					jal		printString					
					
					add.s		$f4, $f6, $f30
					add.s		$f5, $f7, $f30
					jal		printDouble 
					
					j		terminouOperacao				
					
				subtracaoDouble:
					#coloca os valores 1 e 2 nos registradores $f2$f3 e $f4$f5:
					la		$t4, newLine
					jal		printString
					
					jal 		getDouble
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					add.s		$f3, $f1, $f30					
					
					mov.s		$f4, $f2
					mov.s		$f5, $f3					
					jal		printDouble
					
					la		$t4, newLine
					jal		printString
										
					jal		getDouble
					beq		$t8, 1, terminouOperacao						
					add.s		$f4, $f0, $f30
					add.s		$f5, $f1, $f30	
					jal 		printDouble				
					
					#realiza a subtração e coloca o resultado em $f6$f7:
					sub.d		$f6, $f2, $f4
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printSubDouble  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printSubDouble:
					la		$t4, newLine
					jal		printString						
					
					add.s		$f4, $f6, $f30
					add.s		$f5, $f7, $f30
					jal		printDouble 
					
					j		terminouOperacao
					
				multiplicacaoDouble:
					#coloca os valores 1 e 2 nos registradores $f2$f3 e $f4$f5:
					la		$t4, newLine
					jal		printString
					
					jal 		getDouble
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					add.s		$f3, $f1, $f30					
					
					mov.s		$f4, $f2
					mov.s		$f5, $f3					
					jal		printDouble
					
					la		$t4, newLine
					jal		printString
										
					jal		getDouble
					beq		$t8, 1, terminouOperacao						
					add.s		$f4, $f0, $f30
					add.s		$f5, $f1, $f30	
					jal 		printDouble
					
					#realiza a multiplicação e coloca o resultado em $f6$f7:
					mul.d		$f6, $f2, $f4
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printMulDouble  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printMulDouble:
					la		$t4, newLine
					jal		printString					
					
					add.s		$f4, $f6, $f30
					add.s		$f5, $f7, $f30
					jal		printDouble 
					
					j		terminouOperacao
					
				divisaoDouble:
					#coloca os valores 1 e 2 nos registradores $f2$f3 e $f4$f5:
					la		$t4, newLine
					jal		printString
					
					jal 		getDouble
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					add.s		$f3, $f1, $f30					
					
					mov.s		$f4, $f2
					mov.s		$f5, $f3					
					jal		printDouble
					
					la		$t4, newLine
					jal		printString
										
					jal		getDouble
					beq		$t8, 1, terminouOperacao						
					add.s		$f4, $f0, $f30
					add.s		$f5, $f1, $f30	
					jal 		printDouble				
					
					#realiza a divisão e coloca o resultado em $f6$f7:
					div.d		$f6, $f2, $f4
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printDivDouble  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao
					
					#se não ocorreu overflow, imprime o resultado:
					printDivDouble:
					la		$t4, newLine
					jal		printString					
					
					add.s		$f4, $f6, $f30
					add.s		$f5, $f7, $f30
					jal		printDouble 
					
					j		terminouOperacao
					
				inversaoDouble:
					#coloca o valor 1 em $t1$t2:
					la		$t4, newLine
					jal		printString
					
					jal 		getDouble
					beq		$t8, 1, terminouOperacao					
					add.s		$f2, $f0, $f30
					add.s		$f3, $f1, $f30					
					
					mov.s		$f4, $f2
					mov.s		$f5, $f3					
					jal		printDouble										
					
					mfc1		$t1, $f0
					mfc1		$t2, $f1									
					
					#realiza a inversão e coloca o resultado em $f6$f7:
					not		$t3, $t1
					not 		$t4, $t2
					mtc1		$t3, $f4
					mtc1		$t4, $f5
					
					#se ocorreu overflow, finaliza a operação:
					bne		$t8, 1, printInvDouble  #se não ocorreu overflow, imprime o resultado	
					addi		$t8, $zero, 0	#se ocorreu, define de novo a flag como zero
					j		terminouOperacao															
					
					#se não ocorreu overflow, imprime o resultado:
					printInvDouble:
					la		$t4, newLine
					jal		printString					
					
					jal		printDouble 
					
					j		terminouOperacao
					
			terminouOperacao:
			
			#define a flag de overflow como zero novamente:
			addi		$t8, $zero, 0			
			
			#pergunta se quer continuar calculando:
			la		$t4, mensagem7
			jal		printString
			
			la		$t4, newLine
			jal		printString			
			
			#coloca a resposta do usuário em inputChar:												
			la		$t4, inputChar
			jal		getChar
			
			
			#move a resposta do usuário para o registrador $t4:
			lb		$t4, ($t4)
			
			#se o usuário digitou 'y' ou 'Y':
			beq		$t4, 89, continua
			beq		$t4, 121, continua
			
			#se o usuário digitou 'n' ou 'N':				
			beq		$t4, 78, exit
			beq		$t4, 110, exit
			
			#se o usuário digitou qualquer outra coisa:
			j		terminouOperacao
			
			#garante o loop:
			continua: 
			j		while
		exit:
		#end program:
		la		$t4, mensagem6
		jal		printString
		li		$v0, 10
		syscall			
	
#---------------------------------------------------------------------------------
# Procedimento para imprimir uma string.
#
	printString:
		#imprime uma mensagem da RAM (o endereço da mensagem está registrador $t4):
		li		$v0, 4
		la		$a0, ($t4)
		syscall			
													
		#retorna:
		jr		$ra
		
#---------------------------------------------------------------------------------
# Procedimento para imprimir um inteiro em hexadecimal.
#
	printInt:
		#imprime o inteiro armazenado no registrador $t4:		
		add		$v0, $zero, 34
		addi		$a0, $t4, 0
		syscall
																																														
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para imprimir um float em hexadecimal.
#
	printFloat:
		#imprime o float armazenado no registrador $f4:
		mfc1		$a0, $f4
		li		$v0, 34
		syscall
																																														
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para imprimir um double em hexadecimal.
#
	printDouble:
                #imprime o double armazenado nos registradores	$f4 e $f5:	
		mfc1.d		$a0, $f5				
		li		$v0, 34
		syscall		
	
		mfc1.d		$a0, $f4
		li		$v0, 34
		syscall	
																								
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para ler uma string do teclado.
#		 		 		
	getChar:
		# lê um char cujo endereço está armazenado no registrador $t4:
		li		$v0, 8
		add		$a0, $t4, $zero
		li		$a1, 2
		syscall			
																								
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para ler um inteiro do teclado.
#
	getInt:
		#pega um inteiro do usuário e o armazena no reg. $v0:
		li		$v0, 5
		syscall
															
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para ler um float do teclado.
#		 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 				 		 		
	getFloat:
		#pega um float do usuário e o armazena no reg. $f0:
		li		$v0, 6
		syscall		
																								
		#retorna:
		jr		$ra

#---------------------------------------------------------------------------------
# Procedimento para ler um double do teclado.
#
	getDouble:
		#pega um double do usuário e o armazena no reg. $f0 e &f1:
		li		$v0, 7
		syscall		
																								
		#retorna:
		jr		$ra	
		
#---------------------------------------------------------------------------------
# Lida com exceção causada por overflow.
#				
	.ktext 0x80000180
		#salva $v0 e $a0:			
   		move 		$k0,$v0  
	   	move 		$k1,$a0
	   	
	   	#imprime a mensagem de erro devido a overflow: 
	   	la		$a0, quebraLinha
	   	li		$v0, 4
	   	syscall
	   	
		la   		$a0, msg  
   		li   		$v0, 4
   		syscall
   		
   		#define uma flag, para indicar que ocorreu overflow:
   		addi		$t8, $zero, 1
   		
   		#recupera $a0 e $v0:
	   	move 		$v0,$k0
   		move 		$a0,$k1 
   		
   		#retorna à instrução que causou a exceção:
   		mfc0 		$k0,$14   
   		addi 		$k0,$k0,4 
   		mtc0 		$k0,$14  
   		eret
   	.kdata
   		msg:		.asciiz	"Overflow"
   		quebraLinha:	.asciiz	"\n"		
