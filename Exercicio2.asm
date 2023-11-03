# Nome: Heitor Silva Avila
# Turma: M1
# Data: 02/12/2022

# Pseudo-instruaaes: ATIVADAS
# Delayed branch: DESATIVADO

.data # area de memaria do meu simulador MARS

	# Strings (vetor de caracteres) contando a interface do programa
	String1: .asciiz "Esse programa calcula a area de triangulos e retangulos \n"
	String2: .asciiz "Qual area voca quer calcular (1 para triangulo e 2 para retangulo)? "
	String3: .asciiz "Digite o valor de b: "
	String4: .asciiz "Digite o valor de a: "
	String5: .asciiz "A area a igual a: "

.text # Inicio dos meus mneumanicos	

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String1 # $a0 = endereço da string
syscall # sistema imprime a string até caracter nulo

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String2 # $a0 = endereço da string
syscall # sistema imprime a string até caracter nulo

li $v0, 5 # $v0 = 5 = lê inteiro
syscall # sistema pede inteiro para usuário

move $s0, $v0	# será usado na hora do processamento
addi $s0, $s0, -2 # alterando a escala de (1,2) para (-1,0) para reaproveitar funções

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String3 # $a0 = endereço da string3
syscall # sistema imprime a string até caracter nulo
li $v0, 5 # $v0 = 5 = lê inteiro
syscall # sistema pede inteiro para usuário
move $t0, $v0 # Copiando o valor fornecido via teclado para o registrador $t0

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String4 # $a0 = endereço da string
syscall # sistema imprime a string até caracter nulo
li $v0, 5 # $v0 = 5 = lê inteiro
syscall # sistema pede inteiro para usuário
move $t1, $v0 #copiando o valor para registrador

bltzal $s0, calcularAreaDoTriangulo # $s0 = -1 implica em jump and link para calcularAreaDoTriangulo
bgezal $s0, calcularAreaDoRetangulo # $s0 = 0 implica em jump and link para calcularAreaDoRetangulo

li $v0, 10 # Terminando a execuaao das subrotinas, carrego o valor imediato em $v0
syscall # O valor 10 em $v0 para syscall significa encerramento do programa

calcularAreaDoTriangulo:

mul $t0, $t0, $t1 # $t0 = b * a
srl $t0, $t0, 1 # Deslocar 1 casa binaria para a direita a equivalente a divisao inteira por 2

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String5 # $a0 = endereço da string5
syscall # sistema imprime a string até caracter nulo
li $v0, 1 # $v0 com valor igual a 1 permite "imprimir inteiro"
move $a0, $t0 # Colocando em $a0 o valor que esta em $t0
syscall # A funaao vai chamar o sistema operacional para imprimir o inteiro

jr $ra # Terminando a subrotina

calcularAreaDoRetangulo:

mul $t0, $t0, $t1 # $t0 = b * a

li $v0, 4 # $v0 = 4 = imprimir string
la $a0, String5 # $a0 = endereço da string5
syscall # sistema imprime a string até caracter nulo

li $v0, 1 # $v0 com valor igual a 1 permite "imprimir inteiro"
move $a0, $t0 # Colocando em $a0 o valor que esta em $t0
syscall # A funaao vai chamar o sistema operacional para imprimir o inteiro

jr $ra # Terminando a subrotina