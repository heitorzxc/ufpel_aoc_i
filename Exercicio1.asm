# Nome: Heitor Silva Avila
# Turma: M1
# Data: 02/12/2022
# Pseudo-instruções: DESATIVADAS
# Delayed branch: DESATIVADO

.data # Área de memória no meu simulador MARS
	
# A primeira posição de memória é 0x10010000
vetor: .word 0,0,0,0

# Início dos meus mneumónicos
.text

# Inicializando o registrador $t0 com 0x10010000
addi $t0, $zero, 0x1001
# Como o imediato tem apenas 16 bits, preciso fazer o deslocamento
sll $t0, $t0, 16

# Laï¿½o de repetiï¿½ï¿½o para ler "n" números conforme solicitado
loopLeituraNumero:

# Adicionando o valor "5" ao registrador $v0 sem uso de pseudoinstruções
addi $v0, $zero, 5
# Feito isso, posso efetuar o syscall para a leitura do número
syscall

# O número lido está em $v0, então vou copiar ele para $t1 para poder usar posteriormente
or $t1, $zero, $v0

# A partir do momento que foi recebido um inteiro, de sua soma e de sua quantidade de leituras para a memória
jal contabilizaUmaLeitura

# Letra A: Conte o número de valores positivos entre os valores lidos e escreva esse resultado na posição "n+4" da memória
bgezal $t1, incrementaPositivos

# Letra B: Calcule a média dos valores lidos e escreva esse resultado na posição "n+8" da memória
jal calculaMediaNoVetor

# Letra C: Determine quantos valores lidos estão acima da média e escreva esse resultado na posição "n+12" da memória
jal verificaAcimaDaMedia

# Permite a leitura de outro número
j loopLeituraNumero

contabilizaUmaLeitura:
# Somando em $s1 o valor recebido por $t1 ($s1 = $t1 + $s1)
add $s1, $s1, $t1
# Somando em $s2 a quantidade de leituras efetuadas até momento
addi $s2, $s2, 1
# Fim da subrotina, é feito um jump para o registrador $ra que contém o endereço de retorno
jr $ra

incrementaPositivos:
# Se o número foi positivo (maior ou igual a zero), preciso incrementar o vetor
lw $t8, 4($t0)
# Carrega o valor que está na posição ($t1 = 0x10010000) + 0 da memória para o registrador $t8
addi $t8, $t8, 1
# Incrementa o valor deste registrador (contabiliza mais um positivo)
sw $t8, 4($t0)
# Sobrescreve a mesma posição de memória com o novo valor atualizado de números positivos
jr $ra
# Fim da subrotina, é feito um jump para o registrador $ra que conté o endereço de retorno

calculaMediaNoVetor:
# $s1 = Somatório de todos os números lidos
# $s2 = Quantidade de todos os números lidos
div $s1, $s2
# $lo = Quosciente da divisï¿½o inteira (média)
mflo $t9
# A média da divisão inteira está em $t9 e vai ser escrita em ($t0)+8
sw $t9, 8($t0)
# Fim da subrotina, é feito um jump para o registrador $ra que contém o endereço de retorno
jr $ra

verificaAcimaDaMedia:
# Primeiro carrego o valor da memória em um registrador
lw $t4, 12($t0)
# Se a média for MENOR que o valor lido ($t1) então $t7 será igual a "1"
slt $t7, $t4,$t1 
# Então, caso isso seja verdade, vou chamar uma subrotina, e pra isso, vou precisar guardar $ra na pilha
sw $ra, 0($sp)
# Com o valor de $ra na pilha, agora sim posso chamar minha subrotina
bgtz $t7, incrementaVetorMedia
# Recupero o valor de retorno da minha subrotina original
lw $ra, 0($sp)
# E assim finalizo a minha original subrotina
jr $ra

incrementaVetorMedia:
# Quando essa função for executada, sua única função é a de incrementar a posição "n+12" no vetor, portanto...
lw $t6, 12($t0)
# Carrega o valor que está na posição ($t1 = 0x10010000) + 12 na memória para o registrador $t6
addi $t6, $t6, 1
# Incrementa o valor deste registrador (contabiliza mais um)
sw $t6, 12($t0)
# Sobrescreve a mesma posição de memória com o novo valor atualizado de números positivos
jr $ra
# Fim da subrotina, é feito um jump para o registrador $ra que contém o endereço de retorno