#!/bin/bash

#gitDir=$HOME/git
gitDir=/mnt/gaveta/macgyver/git

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


if [[ ! -d $gitDir ]];
then
    
    if [[ -z "$1" || ! -d "$1" ]];
    then
        exitWithMsg $GIT_DIR_NOT_FOUND
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
        cloneIfNotExits "apis" $apis_repo;
        cloneIfNotExits "sankhyaw" $sankhyaw_repo;
    fi
fi

xhost + 

docker run -t \
    --name valid-eclipse-sankhya2 \
    --hostname eclipse-snk \
    --user snkdev -e DISPLAY=$DISPLAY \
    -e JAVA_HOME=/home/snkdev/sk-java/sdk/jdk1.8.0_231 \
    -v $XAUTHORITY:/tmp/.host_Xauthority:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $gitDir:/home/snkdev/git \
    -p 8080:8080 \
    computeiro/snk-eclipse \
    /home/snkdev/sk-java/eclipse/eclipse
