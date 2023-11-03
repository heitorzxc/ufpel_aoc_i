# Nome: Heitor Silva Avila
# Turma: M1
# Data: 02/12/2022
# Pseudo-instru��es: DESATIVADAS
# Delayed branch: DESATIVADO

.data # �rea de mem�ria no meu simulador MARS
	
# A primeira posi��o de mem�ria � 0x10010000
vetor: .word 0,0,0,0

# In�cio dos meus mneum�nicos
.text

# Inicializando o registrador $t0 com 0x10010000
addi $t0, $zero, 0x1001
# Como o imediato tem apenas 16 bits, preciso fazer o deslocamento
sll $t0, $t0, 16

# La�o de repeti��o para ler "n" n�meros conforme solicitado
loopLeituraNumero:

# Adicionando o valor "5" ao registrador $v0 sem uso de pseudoinstru��es
addi $v0, $zero, 5
# Feito isso, posso efetuar o syscall para a leitura do n�mero
syscall

# O n�mero lido est� em $v0, ent�o vou copiar ele para $t1 para poder usar posteriormente
or $t1, $zero, $v0

# A partir do momento que foi recebido um inteiro, de sua soma e de sua quantidade de leituras para a mem�ria
jal contabilizaUmaLeitura

# Letra A: Conte o n�mero de valores positivos entre os valores lidos e escreva esse resultado na posi��o "n+4" da mem�ria
bgezal $t1, incrementaPositivos

# Letra B: Calcule a m�dia dos valores lidos e escreva esse resultado na posi��o "n+8" da mem�ria
jal calculaMediaNoVetor

# Letra C: Determine quantos valores lidos est�o acima da m�dia e escreva esse resultado na posi��o "n+12" da mem�ria
jal verificaAcimaDaMedia

# Permite a leitura de outro n�mero
j loopLeituraNumero

contabilizaUmaLeitura:
# Somando em $s1 o valor recebido por $t1 ($s1 = $t1 + $s1)
add $s1, $s1, $t1
# Somando em $s2 a quantidade de leituras efetuadas at� momento
addi $s2, $s2, 1
# Fim da subrotina, � feito um jump para o registrador $ra que cont�m o endere�o de retorno
jr $ra

incrementaPositivos:
# Se o n�mero foi positivo (maior ou igual a zero), preciso incrementar o vetor
lw $t8, 4($t0)
# Carrega o valor que est� na posi��o ($t1 = 0x10010000) + 0 da mem�ria para o registrador $t8
addi $t8, $t8, 1
# Incrementa o valor deste registrador (contabiliza mais um positivo)
sw $t8, 4($t0)
# Sobrescreve a mesma posi��o de mem�ria com o novo valor atualizado de n�meros positivos
jr $ra
# Fim da subrotina, � feito um jump para o registrador $ra que cont� o endere�o de retorno

calculaMediaNoVetor:
# $s1 = Somat�rio de todos os n�meros lidos
# $s2 = Quantidade de todos os n�meros lidos
div $s1, $s2
# $lo = Quosciente da divis�o inteira (m�dia)
mflo $t9
# A m�dia da divis�o inteira est� em $t9 e vai ser escrita em ($t0)+8
sw $t9, 8($t0)
# Fim da subrotina, � feito um jump para o registrador $ra que cont�m o endere�o de retorno
jr $ra

verificaAcimaDaMedia:
# Primeiro carrego o valor da mem�ria em um registrador
lw $t4, 12($t0)
# Se a m�dia for MENOR que o valor lido ($t1) ent�o $t7 ser� igual a "1"
slt $t7, $t4,$t1 
# Ent�o, caso isso seja verdade, vou chamar uma subrotina, e pra isso, vou precisar guardar $ra na pilha
sw $ra, 0($sp)
# Com o valor de $ra na pilha, agora sim posso chamar minha subrotina
bgtz $t7, incrementaVetorMedia
# Recupero o valor de retorno da minha subrotina original
lw $ra, 0($sp)
# E assim finalizo a minha original subrotina
jr $ra

incrementaVetorMedia:
# Quando essa fun��o for executada, sua �nica fun��o � a de incrementar a posi��o "n+12" no vetor, portanto...
lw $t6, 12($t0)
# Carrega o valor que est� na posi��o ($t1 = 0x10010000) + 12 na mem�ria para o registrador $t6
addi $t6, $t6, 1
# Incrementa o valor deste registrador (contabiliza mais um)
sw $t6, 12($t0)
# Sobrescreve a mesma posi��o de mem�ria com o novo valor atualizado de n�meros positivos
jr $ra
# Fim da subrotina, � feito um jump para o registrador $ra que cont�m o endere�o de retorno