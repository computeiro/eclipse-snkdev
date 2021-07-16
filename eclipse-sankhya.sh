#!/bin/bash

gitDir=$HOME/git

containerName=eclipse-skdev

apis_repo=https://git.sankhya.com.br/plataforma-w/apis.git
sankhyaw_repo=https://git.sankhya.com.br/plataforma-w/sankhyaw.git

GIT_DIR_NOT_FOUND="Não encontramos o diretório Git em ${gitDir}. Este é o diretório padrão e RECOMENDADO,
Caso você use noutro local informe como arguemnto. 
    Ex:
    \$ eclipse-sankhya.sh  '/caminho/para/diretorio/git'
"


exitWithMsg(){
    echo -e "$1"
    exit 1
}

cloneIfNotExits(){
    repoDir=$1
    repoUrl=$2

    echo "Clonando $1 : $2"
    if [[ ! -d  $repoDir ]];
    then
        git -C $gitDir clone $repoUrl

        if [[ $? == 1 ]];
        then
            exitWithMsg "Erro ao clonar repostiório $repoUrl "
        fi
    fi
}

if [[ `docker ps -a --format '{{.Names}}' |grep $containerName` ]]; 
then 
    exitWithMsg "O container $containerName já existe.
Você pode simplesmente inicializa-lo com o comando:
    docker start $containerName
Ou, se você deseja recria-lo, delete o container e execute este script novamente.
"
fi


if [[ ! -d $gitDir ]];
then
    
    if [[ -z "$1" || ! -d "$1" ]];
    then
        exitWithMsg "$GIT_DIR_NOT_FOUND"
    else
        gitDir="$1";
    fi

fi

if [[ ! -d "$gitDir/apis" ]] ||  [[ ! -d "$gitDir/sankhyaw" ]];
then

    echo -e "Não encontramos o repositório  'sankhyaw' ou 'apis. Caminhos esperados:'
 $gitDir/sankhyaw
 $gitDir/apis
"
    read -r -p "PODEMOS efetuar o checkout dos projetos? [S/n]" response
    response=${response,,} # tolower
    if [[ $response =~ ^(yes|y|s|sim| ) ]] || [[ -z $response ]]; 
    then
        echo -e "####### CLONANDO PROJETOS DO GIT... #######"
        cloneIfNotExits "apis" $apis_repo;
        cloneIfNotExits "sankhyaw" $sankhyaw_repo;
    fi
fi

xhost + 

docker run \
    --name $containerName \
    --hostname eclipse-skdev \
    --user snkdev -e DISPLAY=$DISPLAY \
    -e JAVA_HOME=/home/snkdev/sk-java/sdk/jdk1.8.0_231 \
    -v $XAUTHORITY:/tmp/.host_Xauthority:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/.git-credentials:/home/snkdev/.git-credentials \
    -v ~/.gitconfig:/home/snkdev/.gitconfig \
    -v $gitDir:/home/snkdev/git \
    -p 8080:8080 \
    computeiro/eclipse-skdev \
    /home/snkdev/init-container.sh
