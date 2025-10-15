# Estruturas de controle--------------------------------------------------------

# IF-ELSE
# Permite desviar a execução do código conforme uma condição
# Não é vetorizada, ou seja, avalia um único valor de entrada

hora <- 6

if (hora >= 6 & hora <12){
  saudacao <- "Bom dia!"
} else if (hora >=12 & hora < 18){
  saudacao <- "Boa tarde!"
} else if (hora >= 18 & hora < 23){
  saudacao  <- "Boa noite!"
} else {
  saudacao <- "Não enviar mensagem"
  stop("Não enviar mensagem")
}

# SWITCH
# Um empilhamento de estruturas IF-ELSE
# Confere mais clareza e eficiência ao código
# Serve para testar um valor contra um conjunto de strings
# Geralmente há uma condição final ou de escape
# Também não é vetorizada

x <- 1:10
tipo <- "geométrica"

switch(tipo,
       "aritmética" = {
         mean(x)
       },
       "harmônica" = {
         length(x)/ sum(1/x)
       },
       "geométrica" = {
         prod(x)^(1/length(x))
       },
       {
         NA_real_
       })

# ifelse()
# Versão do IF-ELSE vetorizada

notas <- c("João" = 70, "Ana" = 89,
           "Lucas" = 67, "Mateus" = 40,
           "Felipe" = 20)

ifelse(notas >= 70, "Aprovado", "Reprovado")

# CASE 
# Versão vetorizada do SWITCH
dplyr::case_when(notas >= 70 ~ "Aprovado",
                 notas >= 40 ~ "Exame",
                 TRUE ~ "Reprovado")

# Estruturas de repetição-------------------------------------------------------

# LOOP FOR
# Utilizado para executar uma instrução um número previamente conhecido de vezes
# O loop itera sobre uma sequência de valores: um vetor ou lista
# Pode-se interromper a execução do loop ou pular uma iteração conforme condições
# que são avaliadas

#Exemplo 1
for (i in 1:10){
  print(i^2)
}

#Exemplo 2
tx_juros <- 0.01
n_meses <- 12

rend <- numeric(n_meses)

rend[1] <- 100

for (i in 2:n_meses){
  rend[i] <- rend[i-1] * (1+tx_juros)
}
rend

# WHILE
# Utilizado para executar uma intrução um número desconhecido de vezes
# A condição é testada antes das instruções serem executadas
# CUIDADO: a condição de parada deve ser declarada para que o loop não seja 
# interminável

n_numbers <- 12
total <- 0
indice <- 1

while (i < n_numbers){
  u <- total + runif(1)
  if (sum(u) > 4) break
  total <- u
  i <-  i + 1
}

total

# REPEAT 
# Utilizado para executar uma intrução um número desconhecido de vezes
# A condição é testada em qualquer posição dentro das instruções a serem execu-
# tadas
# CUIDADO: a condição de parada deve ser declarada para que o loop não seja 
# interminável

total <- 0
indice <- 1

repeat{
  u <- total + runif(1)
  if (u > 4) break
  total <- u
  i <- i+1
}

total

# Exercício: Lançamento de dados
tentativas <- 1
n_max <- 100
while (tentativas < n_max){
  faces <- sample(1:6, 3, replace = T)
  faces_ordenado <- sort(faces)
  print(faces_ordenado)
  sequencia <- sum(ifelse(diff(faces_ordenado) == 1, TRUE, FALSE))
  if (sequencia == 2) break
  tentativas <- tentativas +1
}
tentativas


# Exercício: Número médio de lançamentos

output <- c()
for (i in 1:1000){
  tentativas <- 1
  n_max <- 100
  while (tentativas < n_max){
    faces <- sample(1:6, 3, replace = T)
    faces_ordenado <- sort(faces)
    print(faces_ordenado)
    sequencia <- sum(ifelse(diff(faces_ordenado) == 1, TRUE, FALSE))
    if (sequencia == 2) break
    tentativas <- tentativas +1
  }
   output[i] <- tentativas
}
media_tentativas <- mean(output)
media_tentativas
hist(output)

# Funções ----------------------------------------------------------------------

# Funções encapsulam uma tarefa composta de várias instruções
# Pegam valores de entrada e geram valores de saída
# Permitem o reuso de código de uma forma enxuta

# Exemplo:
imc  <- function(peso, altura){
  imc <- peso/altura^2
  limits <- c(0,18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificacao = classif))
}
imc(57, 1.75)

# Estrutura da função: nome da função, argumentos formais, corpo e retorno.
# Nome da função: verbo ou composto por verbo.
# Argumentos: nomes apropriados, podem ser vetores, amtrizes, listas, etc, até
# outras funções, podem ter valores default.
# Retorno: importante retornar alguma coisa, se precisar retornar mais de um 
#objeto sempre usar lista.
# Colocar mensagens descritivas para erros, avisos e comentários
# Evitar modificar variáveis fora do escopo da função

# Exercício: Fórmula de Bhaskara

calcula_bhaskara <- function(a, b = 1, c = 0){
  delta <- b^2 - 4*a*c
  x <- (-b + c(1, -1) * sqrt(delta))/ (2* a)
  return(x)
}

args(calcula_bhaskara)
formals(calcula_bhaskara)
body(calcula_bhaskara)

curve(2 * x^2 + x +0, from = -5, to = 5)
abline(h = 0, col = "blue")

x <- calcula_bhaskara(a = 2, b = -3, c = -3)
x

curve(2 * x^2 -  3* x -3, from = -5, to = 5)
abline(h = 0, col = "blue") 
abline(v = x, col = "green")



# Tratamento de exceções
# Usados quando se faz funções para usos gerais e uma maior audiência, faz com 
# que a função se comunicque de forma clara ao usuário.

# Prever desvios de uso po: variáveis com tipos incorretor, objetos com classe 
# incorreta, indeterminação nos resultados, falha de convergência, arquivos/objetos
# não encontrados

# cat() e print(): imprimir conteúdo no console
# message(): imprime mensagens neutras ao usuário
# warning(): imprime mensagens de aviso, ela causa a saída warning
calcula_bhaskara_2 <- function(a, b = 1, c = 0){
  delta <- b^2 - 4*a*c
  if (delta < 0){
    return(c(NA_real_, NA_real_))
  }
  x <- (-b + c(1, -1) * sqrt(delta))/ (2* a)
  return(x)
}

calcula_bhaskara(2,-3,3)
calcula_bhaskara_2(2,-3,3)

calcula_bhaskara_3 <- function(a, b = 1, c = 0){
  if (a == 0){
    message("o valor de 'a' deve ser diferente de 0")
    return(c(NA_real_, NA_real_))
  }
  delta <- b^2 - 4*a*c
  if (delta < 0){
    return(c(NA_real_, NA_real_))
  }
  x <- (-b + c(1, -1) * sqrt(delta))/ (2* a)
  return(x)
}

calcula_bhaskara_3(0,-3,3)
suppressMessages(calcula_bhaskara_3(0,-3,3))

# Exercício: Lançamento de dados

joga_dados <- function(n_dados, n_max, n_simulacoes){
  vetor_saida <- c()
  for (i in 1:n_simulacoes){
    tentativas <- 1
    while (tentativas < n_max){
      faces <- sample(1:6, n_dados, replace = T)
      print(faces)
      if (n_dados > 6){
        faces_ordenado <- unique(sort(faces))
      } else { 
        faces_ordenado <- sort(faces)
      }
      print(faces_ordenado)
      sequencia <- sum(ifelse(diff(faces_ordenado) == 1, TRUE, FALSE))
      if (sequencia == (length(faces_ordenado) -1)) break
      tentativas <- tentativas +1
    }
    vetor_saida[i] <- tentativas
  }
  return(lista = list(lacamentos = vetor_saida, media_lancamentos = mean(vetor_saida), indices <- which(vetor_saida ==1), n_indices = length(indices)))
}

joga_dados2 <- function(n_dados, n_max, n_simulacoes){
  vetor_saida <- c()
  for (i in 1:n_simulacoes){
    tentativas <- 1
    while (tentativas < n_max){
      faces <- sample(1:6, n_dados, replace = T)
      print(faces)
      if (n_dados > 6){
        faces <- unique(faces)
        print(faces)
      } 
      sequencia <- sum(ifelse(diff(faces) == 1, TRUE, FALSE))
      if (sequencia == (length(faces) -1)) break
      tentativas <- tentativas +1
    }
    vetor_saida[i] <- tentativas
  }
  return(lista = list(lacamentos = vetor_saida, media_lancamentos = mean(vetor_saida), indices <- which(vetor_saida ==1), n_indices = length(indices)))
}
joga_dados2(n_dados = 10, n_max = 1000, n_simulacoes = 1000)

# Aspectos avançados de funções 

# Argumento com valor default
calcula_imc  <- function(peso = 80, altura){
  imc <- peso/altura^2
  limits <- c(0,18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificacao = classif))
}
calcula_imc(altura = 1.8)


# Tratando exceções
calcula_imc  <- function(peso = 80, altura){
  if (altura <= 0) stop("Altura deve ser maior que 0")
  if (peso < 0) stop("Peso deve ser maior que 0")
  imc <- peso/altura^2
  limits <- c(0,18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificacao = classif))
}
calcula_imc(altura = 0)

# Funções sem argumentos 
calcula_imc_sem_args  <- function(){
  if (altura <= 0) stop("Altura deve ser maior que 0")
  if (peso < 0) stop("Peso deve ser maior que 0")
  imc <- peso/altura^2
  limits <- c(0,18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificacao = classif))
}

calcula_imc_sem_args()

peso <- 70
altura <- 1.70 
calcula_imc_sem_args()


#Lazy evaluation
calcula_imc_com_arg_extra  <- function(altura, peso = 80, altura2){
  if (altura <= 0) stop("Altura deve ser maior que 0")
  if (peso < 0) stop("Peso deve ser maior que 0")
  imc <- peso/altura^2
  limits <- c(0,18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificacao = classif))
}
calcula_imc_com_arg_extra(altura = 1.9, altura2 = 1.8)

# Uso dos 3 ...

calcula_numero_imc <- function(peso, altura){
  imc <- peso/altura^2
  return(imc)
}

classifica_imc <- function(...){
  imc <- calcula_numero_imc(...)
  limits <- c(0, 18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", 
              "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, limits)]
  return(list(IMC = imc, Classificacao = classif))
}
classifica_imc(80, 1.98)
