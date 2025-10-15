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
