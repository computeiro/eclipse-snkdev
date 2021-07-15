Basta executar o seguinte comando:

wget -O - https://raw.githubusercontent.com/computeiro/snk-docker/main/eclipse-sankhya.sh | bash


Note que o script irá mapaerar o Git no home do usuário e se não tiver $HOME/git será criado e efetuado o checkout dos repositórios:

https://git.sankhya.com.br/plataforma-w/apis.git

https://git.sankhya.com.br/plataforma-w/sankhyaw.git


Após todo o processo o Eclipse será incializado. Se você fechar o Eclipse o container será finalizado. Daqui por diante, a inicialização do Eclipse será bem mais rápida e para e o comando para inicializar o Eclipse será apenas:

`xhost +  && docker start eclipse-skdev`


**Observação:**

Tanto na primeira vez em que estamos criando o container (docker run)  quanto nas demais inicializações do container (docker start) a primeira coisa que será feita antes de abrir o Eclipse é a atualização das apis. Por isso, lembre-se de dar um refresh (F5) no _"api_sankhya"_ e _"api_outros"_ 

Você precisará também importar os projetos que precisa para isso basta ir na perpesctiva do Git que ele já o trará o repositório do _sankhyaw_

![Foo](http://www.google.com.au/images/nav_logo7.png)

Novos repositórios Git poderão ser adicionado no diretório Git que está na sua máquina, lembre-se mapeamos esse diretório como volume do container.
