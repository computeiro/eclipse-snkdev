Basta executar o seguinte comando:

wget -O - https://raw.githubusercontent.com/computeiro/snk-docker/main/eclipse-sankhya.sh | bash

Aproveita pra ir pegar um café pois o script vai baixar muita coisa...

O script irá fazer download da imagem Docker e executa-la.
Note que será mapeado como volume o diretório $HOME/git e o container irá enxergar lá como $HOME/git (o user no container é o snkdev). Se não houver dentro deste volume os repositórios _"api_sankhya"_  e _"api_outros"_ os mesmos também será clonados na máquina host antes de inicializar o container.

https://git.sankhya.com.br/plataforma-w/apis.git

https://git.sankhya.com.br/plataforma-w/sankhyaw.git


Após todo o processo o Eclipse será incializado. 
Se você fechar o Eclipse o container será finalizado. Daqui por diante, a inicialização do Eclipse será bem mais rápida e para isto basta usar o comando:

`xhost +  && docker start eclipse-skdev`


**Observação:**

Tanto na primeira vez em que estamos criando o container (docker run)  quanto nas demais inicializações do container (docker start) a primeira coisa que será feita antes de abrir o Eclipse é a atualização das apis. Por isso, lembre-se de dar um refresh (F5) no _"api_sankhya"_ e _"api_outros"_ 

Você precisará também importar os projetos que precisa, para isso, basta ir na perpesctiva do Git que ele já o trará o repositório do _sankhyaw_ conforme a imagem abaixo

![Importe os projetos do Sankhya Om](docs/eclipse_perpectiva_git.png)

Novos repositórios Git poderão ser adicionado no diretório Git que está na sua máquina, lembre-se mapeamos esse diretório como volume do container.
