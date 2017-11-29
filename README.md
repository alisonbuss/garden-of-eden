
<h1 align="center" >
  <img src="https://github.com/alisonbuss/garden-of-eden/raw/master/files/logo-garden-of-eden.png" width="166px" alt="logo"/> 
  <br/>Garden of Eden
</h1>

### O projeto **Garden of Eden** foi refeito para suportar modularização de repositórios de shell scripts **"local/cloud"** para uma determinada distribuição Linux. 

### Uma referência prática dessa modularização está no projeto "[My Garden of Eden Light](https://github.com/alisonbuss/my-garden-of-eden-light)" que é uma extensão resumida do próprio projeto "Garden of Eden".

O **Garden of Eden** é um projeto Shell Script para provisionamento de um ambiente básico de desenvolvimento para uma distribuição Ubuntu, podendo ser ampliado para distribuições Fedora, openSUSE, Arch Linux, Red Hat Enterprise Linux e as demais distribuição disponíveis. 

O **Garden of Eden** provisiona os seguentes programas:

- Gera **chave SSH**
- Instala **Git**
- Instala **JDK**
- Instala **NVM (Node Version Manager)**
- Instala **Node.js com NVM.**
- Instala **RVM (Ruby Version Manager).**
- Instala **Ruby com RVM.**
- Instala **Go**
- Instala **CFSSL**
- Instala **Config Transpiler**
- Instala **Terraform**
- Instala **Ansible**
- Instala **VirtualBox**
- Instala **Vagrant**
- Instala **VS Code**
- Instala **GitKraken**
- Instala **StarUML**
- Instala **Chrome**
- Instala **NetBeans**

> **Nota:**
>
> **1)** *Este projeto foi **TESTADO no Ubuntu 16.04 LTS (Xenial Xerus)** e o provisionamento levou aproximadamente **45 minutos** por conta da internet discada do "NET Combo Bosta".*
>
> **2)** *O intuito do projeto **Garden of Eden** é acadêmico, ou seja, para fins de conhecimentos, não sou um profissional linux e Shell Script, qualquer opinião, sugestão, será bem vinda.* 
>
> **3)** *A maior parte do conhecimento obtido para se desenvolver esse projeto foi a traveis do canal do YouTube "[Bóson Treinamentos - Shell Scripting - Programação no Linux](https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs)", fico inteiramente grato por todas as informações obtida por esse canal.* 
>  

## O funcionamento do Garden of Eden.

A estrutura base do projeto consiste em um arquivo **"settings.json"**, esse arquivo defini a distribuição linux a ser usada, local da geração de logs, definições de modularização dos repositórios de scripts e a ordem de execução dos scripts e seus parâmetros. Um exemplo do arquivo **"settings.json"**:

```text
{
    "distribution": "ubuntu",
    "pathLogGeneral": "./logs/",
    "pathLogScripts": "./logs/dist-ubuntu/",
    "scriptsRepositories": [
        {
            "repository": "local-example", 
            "repositoryInfo": "Exemplo de como usar um script no padrão do (Garden Of Eden)",
            "repositoryPath": "./dist-ubuntu/scripts/",
            "repositoryActive": true,
            "scripts": [
                { "script": "script-example.sh", "action": "install", "execute": true, 
                    "param": { "version": "3.6.66" } 
                } 
            ]
        },
        ...outros..repositórios...
    ]
}
```

No arquivo **"settings.json"** consiste de 4 parâmetros básicos (**distribution**, **pathLogGeneral**, **pathLogScripts**, **scriptsRepositories**) 
como mostra o exemplo acima: 

- "**distribution**": destina-se ao tipo de distribuição linux, nesse projeto se usa o Ubuntu.
- "**pathLogGeneral**": destina-se ao diretório onde vai ser gerado o log geral do Garden of Eden.
- "**pathLogScripts**": destina-se ao diretório onde vai ser gerado os logs dos repositórios de scripts.
- "**scriptsRepositories**": destina-se a modularização dos repositórios de scripts em ordem a ser executados, esse modulo contem 5 parâmetros padrões que são (**repository, repositoryInfo, repositoryPath, repositoryActive, scripts**).

Os parâmetros do **"scriptsRepositories": [{...}, ...]** do ultimo item citado acima, consiste em:

- "**repository**": define o nome do repositório de scripts.
- "**repositoryInfo**" define o uma descrição do repositório de scripts.
- "**repositoryPath**": define o diretorio **local** ou da **nuvem** base, de onde vai ser chamados os shell scripts a serem executados.
- "**repositoryActive**": define se o repositório vai ser executado, (**true** ou **false**), se for **true** esse repositório será executado caso contrario ele não é executado.
- "**scripts**": destina-se a uma lista de scripts em ordem para ser executados, essa lista contem 4 parâmetros padrões que são (**script, action, execute, param**).

Os parâmetros do **"scripts": [{...}, ...]** do ultimo item citado acima, consiste em:

- "**script**": define o nome do Shell Script a ser executado.
- "**action**" define o tipo da ação que queira executar no Shell Script, essa ação é de acordo com Shell Script especificado.
- "**execute**": define se o script vai ser executado, (**true** ou **false**), se for **true** esse script será executado caso contrario ele não é executado.
- "**param**": define um json de (**chave** e **valor**), esse json será repassado para o Shell Script especificado para ser consumido na execução.

### Como ficaria o arquivo "settings.json" do Garden of Eden:

```json
{
    "distribution": "ubuntu",
    "pathLogGeneral": "./logs/",
    "pathLogScripts": "./logs/dist-ubuntu/",
    "scriptsRepositories": [
        {
            "repository": "local-example", 
            "repositoryInfo": "Exemplo de como usar um script no padrão do (Garden Of Eden)",
            "repositoryPath": "./dist-ubuntu/scripts/",
            "repositoryActive": true,
            "scripts": [
                { "script": "script-example.sh", "action": "install", "execute": true, 
                    "param": { "version": "3.6.66" } 
                } 
            ]
        },
        {
            "repository": "local", 
            "repositoryInfo": "Provisionar um ambiente básico de desenvolvimento",
            "repositoryPath": "./dist-ubuntu/scripts/",
            "repositoryActive": false,
            "scripts": [
                { "script": "script-keyssh.sh", "action": "create", "execute": false, 
                    "param": { "comment": "Que reinaste o anjo caído!", "passwordKey": "luxferre", "pathKey": "/home/user/.ssh", "nameKey": "id_rsa" } 
                },
                { "script": "script-git.sh", "action": "install", "execute": false, 
                    "param": { "nameUser": "Lúcifer", "emailUser": "lucifer.dev@ghell.com" }
                },
                { "script": "script-jdk.sh", "action": "install", "execute": false, 
                    "param": { "version": "8" } 
                },
                { "script": "script-nvm.sh", "action": "install", "execute": false, 
                    "param": { "version": "0.33.4" } 
                },
                { "script": "script-nodejs.sh", "action": "install", "execute": false, 
                    "param": { "version": "8.4.0" } 
                },
                { "script": "script-golang.sh", "action": "install", "execute": false, 
                    "param": { "version": "1.9" } 
                },
                { "script": "script-terraform.sh", "action": "install", "execute": false, 
                    "param": { "version": "0.10.7" }
                },
                { "script": "script-cfssl.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-config-transpiler.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-ansible.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-virtualbox.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-vagrant.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-vscode.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-gitkraken.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-staruml.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-chrome.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-netbeans.sh", "action": "install", "execute": false, "param": null },
                { "script": "script-repositories-git.sh", "action": "clone", "execute": false, 
                    "param": { 
                        "defaultRepositoryPath": "/mnt/sda2/git-repositories", 
                        "repositories": [
                            {
                                "repositoryPath": "/work",
                                "clonesAddress": []
                            }, {
                                "repositoryPath": "/private",
                                "clonesAddress": []
                            }, {
                                "repositoryPath": "/public",
                                "clonesAddress": [
                                    "https://github.com/alisonbuss/aurora.git",
                                    "https://github.com/alisonbuss/Formulation.git",
                                    "https://github.com/alisonbuss/garden-of-eden.git",
                                    "https://github.com/alisonbuss/shell-script-tools.git",
                                    "https://github.com/alisonbuss/coreos-kids-vagrant.git",
                                    "https://github.com/alisonbuss/multiple-nodes-vagrant.git",
                                    "https://github.com/alisonbuss/cluster-coreos-terraform.git",
                                    "https://github.com/alisonbuss/terraform-provider-vagrant.git"
                                ]
                            }
                        ]
                    } 
                }
            ]
        },
        {
            "repository": "themes-and-apps-cloud", 
            "repositoryInfo": "Instalar Temas e Aplicativos Comuns",
            "repositoryPath": "https://raw.githubusercontent.com/alisonbuss/garden-of-eden/master/dist-ubuntu/scripts/",
            "repositoryActive": false,
            "scripts": [
                { "script": "script-watercolor.sh", "action": "apply", "execute": false, "param": null } 
            ]
        }
    ]
}
```

## Executando o Garden of Eden. 

Abra terminal no seu linux e execute os comandos abaixo: 

Terminal:
```bash
$ wget "https://github.com/alisonbuss/garden-of-eden/archive/master.zip" -O ~/Downloads/garden-of-eden-master.zip
$ unzip ~/Downloads/garden-of-eden-master.zip -d ~/Downloads/
$ cd ~/Downloads/garden-of-eden-master
$ ls -a
```
Pronto agora você pode executar Shell Scripts do "Garden of Eden":

- **start-divine-creation.sh** em modo de comandos.

### Executando em modo de comandos:

> **Nota:**
> *Antes de executar o **Garden of Eden**, certifique-se de ter ajustado os parâmetros do arquivo **settings.json** para sua realidade.*

Você tem que dar permissão root ao script.

Terminal:
```bash
$ sudo chmod a+x start-divine-creation.sh
```

#### Visualizar a documentação, passando o parametro **--help|-help|-h|help**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --help
```

#### Listar todos os scripts a serem executados através do "settings.json", passando o parametro **--list**

> **Nota:**
> *Caso não seja passado o **--setting-file='...'** jundo com o parametro **--list** o Garden Of Eden ira setar o caminho padrão para './settings.json'.*

Terminal:
```bash
$ sudo bash start-divine-creation.sh --list
```
Ou:
```bash
$ sudo bash start-divine-creation.sh -l
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'*:
```bash
$ sudo bash start-divine-creation.sh --list --setting-file='./settings.json'
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'* reduzido:
```bash
$ sudo bash start-divine-creation.sh -l -s='./settings.json'
```

#### Executando todos os scripts do "settings.json", passando o parametro **--rum**

> **Nota:**
> *Caso não seja passado o **--setting-file='...'** jundo com o parametro **--run** o Garden Of Eden ira setar o caminho padrão para './settings.json'.*

Terminal:
```bash
$ sudo bash start-divine-creation.sh --run
```
Ou:
```bash
$ sudo bash start-divine-creation.sh -r
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'*:
```bash
$ sudo bash start-divine-creation.sh --run --setting-file='./settings.json'
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'* reduzido:
```bash
$ sudo bash start-divine-creation.sh -r -s='./settings.json'
```

## A estrutura do projeto Garden of Eden. 

Descrição das pastas e arquivos do projeto:

```
garden-of-eden
  |--binaries/....................'Pasta onda se salva os downloads dos binários temporários feito pelos scripts.'
  |--dist-ubuntu/.................'Pasta de uma determinada distribuição linux, onde se encontra os scripts de execução.'
     |--scripts/..................'Pasta onde se encontra os scripts de execução.'
  |--files/.......................'Pasta de apoio, onde se encontra os arquivos variados, como logo, wallpaper etc.'
  |--logs/........................'Pasta onde se encontra os logs gerados pelo Garden Of Eden, o local é definidos no "settings.json".'
     |--dist-ubuntu/..............'Pasta onde se encontra os logs gerados após a execução de cada scripts, o local é definidos no "settings.json".'   
  |--.gitignore...................'Ignorar a pasta de logs no git.'
  |--import.sh....................'Shell Script que contem função de importação dos Shell Scripts do projeto.'
  |--LICENSE......................'Licença Pública Geral - GPL-3.0.'
  |--README.md....................'Descrição e documentação do projeto Garden of Eden.'
  |--settings.json ...............'Arquivo principal do projeto onde é definido a modularização de repositórios shell scripts a serem executados.'
  |--start-divine-creation.sh.....'Shell Script de inicialização do projeto em modo de comandos.'
```

Caso tu queiras criar um script de instalação de um programa do seu interesse, no próprio projeto tem um script de exemplo que você pode usar como base inicial, exemplo abaixo:

Diretório: dist-ubuntu/scripts/script-example.sh

Arquivo:

```bash
#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#       bash script-example.sh --action='install' --param='{"version":"3.6.66"}'
#   OR
#       bash script-example.sh --action='uninstall' --param='{"version":"6.6.63"}'    
#-------------------------------------------------------------#

source <(wget --no-cache -qO- "https://raw.githubusercontent.com/alisonbuss/shell-script-tools/master/import.sh"); 

import.ShellScriptTools "/linux/utility.sh";

# @descr: Descrição da Função.
# @fonts: Fontes de referências
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptExample {
    
    # @descr: Descrição da Variavel.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Descrição da Variavel.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");
    # @descr: Descrição da Variavel.
    local version=$(echo "${PARAM_JSON}" | jq -r '.version');

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __install() {
        util.print.info "Iniciando a instalação do Example na maquina..."; 
        util.print.out '%s\n\n' "  --> Version: ${version}"; 
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __uninstall() { 
        util.print.info "Iniciando a desinstalação do Example na maquina..."; 
        util.print.out '%s\n\n' "  --> Version: ${version}"; 
    }

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __initialize() {
        case ${ACTION} in
            install) { 
                __install; 
            };;
            uninstall) { 
                __uninstall;
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Descrição da Chamada da Função.
    __initialize "$@";
}

# SCRIPT INITIALIZE...
util.try; ( ScriptExample "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
```

Caso tu queiras mudar de distribuição linux, exemplo *"dist-fedora"*, basta copiar a pasta "**dist-ubuntu**" e renomear para "**dist-sua-distribuição**" e agora é ajustar os scripts do diretório "**dist-sua-distribuição/scripts/**", para que possa rodar os scripts de acordo com sua distribuição que você escolheu, exemplo:

```
garden-of-eden
  |--dist-ubuntu/
     |--scripts/...
  |--dist-fedora/
     |--scripts/...
```  

E agora é só mudar o parâmetro "**repositoryPath**" do arquivo **settings.json** para **..."repositoryPath": "./dist-sua-distribuição"...**, exemplo:

```text
{
    "distribution": "fedora",
    "pathLogGeneral": "...",
    "pathLogScripts": "./logs/dist-fedora/",
    "scriptsRepositories": [
        {
            "repository": "...", 
            "repositoryInfo": "...",
            "repositoryPath": "./dist-fedora/scripts/",
            "repositoryActive": ...,
            "scripts": [...]
        },
        ...outros..repositórios...
    ]
}
```

***Pronto!! Agora você tem um ambiente de desenvolvimento básico para duas distribuições linux, du karalho né?? rsrsrsrs...***

<p align="center">
    <img src="https://github.com/alisonbuss/garden-of-eden/raw/master/files/end-bender.gif" width="287px"/>
</p>


## Referências:

* Canal YouTube Bóson Treinamentos, Fábio dos Reis. ***Programação no Linux*** 
  Acessado: *29 de Julho de 2017.*
  Disponível: *[https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs](https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs)*.
* Shell Scriptx Blog, Shamam. ***Trabalhando com funções Shell*** 
  Acessado: *19 de Setembro de 2017.*
  Disponível: *[http://shellscriptx.blogspot.com.br/2016/12/trabalhando-com-funcoes.html](http://shellscriptx.blogspot.com.br/2016/12/trabalhando-com-funcoes.html)*.
* mhavila, Márcio d'Ávila. ***Scripts Shell sob Controle*** 
  Acessado: *19 de Setembro de 2017.*
  Disponível: *[http://www.mhavila.com.br/topicos/unix/shscript.html](http://www.mhavila.com.br/topicos/unix/shscript.html)*.


## Tradução | Translation
- [Inglês | English](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=en&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhjF8wXBywEnSgThP4hIo1rEuBQcIw)
- [Espanhol | Español](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=es&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgaHMX6VZow_LV_2D6thOl3ojl1Cw)
- [Russo | русский](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ru&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgUDrwtXLR16xyVuHUFVSjUYsqF1w)
- [Chinês | 中國](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=zh-TW&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhhzK2w-woMjhAwW32tPxVeGv57DeQ)
- [Coreano do Norte | 한국어](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ko&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhiN-zOrr5ZpGk91vIzguZh-aavo_g)


## Licença

- [GPL-3.0: GNU General Public License v3.0](https://github.com/alisonbuss/garden-of-eden/blob/master/LICENSE)

