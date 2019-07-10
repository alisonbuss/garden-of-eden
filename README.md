
<h1 align="center" >
  <img src="https://github.com/alisonbuss/garden-of-eden/raw/master/support-files/logo-garden-of-eden.png" width="166px" alt="logo"/> 
  <br/>Garden of Eden
</h1>

O **Garden of Eden** é um projeto Shell Script para provisionamento básico de um ambiente de desenvolvimento para uma distribuição Ubuntu Desktop, podendo ser ampliado para distribuições Fedora, openSUSE, Arch Linux, Red Hat Enterprise Linux e as demais distribuição disponíveis. 

O **Garden of Eden** provisiona os seguentes recursos:

- Gerar **chave SSH**
- Instala o **Git**
- Instala o **JDK**
- Instala o **pyenv (Python Version Manager)**
- Instala o **NVM (Node Version Manager)**
- Instala o **Node.js usando NVM**
- Instala o **RVM (Ruby Version Manager)**
- Instala o **Ruby usando RVM**
- Instala o **Go**
- Instala o **Ansible**
- Instala o **Docker**
- Instala o **Docker Compose**
- Instala o **VirtualBox**
- Instala o **Vagrant**
- Instala o **Packer**
- Instala o **Terraform**
- Instala o **VS Code**
- Instala o **GitKraken**
- Instala o **StarUML**
- Instala o **NetBeans**
- Instala o **Postman**
- Instala o **Chrome**

> **Nota:**
>
> **1)** *Este projeto foi TESTADO no **Ubuntu 17.10 (Artful Aardvark)**, **Ubuntu 18.10 (Cosmic Cuttlefish)** e **Ubuntu 19.04 (Disco Dingo)** e o provisionamento levou aproximadamente **45 minutos** por conta da internet discada da "NET...".*
>
> **2)** *O intuito do projeto **Garden of Eden** é acadêmico, ou seja, para fins de conhecimento prático, não sou um profissional linux, qualquer opinião, sugestão, será bem vinda.* 
>
> **3)** *A maior parte do conhecimento obtido para se desenvolver esse projeto foi a traveis do canal do YouTube "[Bóson Treinamentos - Shell Scripting - Programação no Linux](https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs)", fico inteiramente grato por todas as informações obtida por esse canal.* 
>  

## O funcionamento do Garden of Eden.

A estrutura base do projeto consiste em um arquivo **"settings-*.json"**, esse arquivo json defini os modulos de scripts shell a ser executados, a distribuição linux a ser usada, e entre outras definições. Um exemplo do arquivo **"settings-you-file.json"**:

```json
{
    "settings": [
        {
            "module": "example",
            "description": "Executar um exemplo de como usar um script no padrão do (Garden Of Eden)",
            "active": true,
            "logsPath": "./logs/dist-ubuntu/personalize",
            "scriptsPath": "./shell-script/dist-ubuntu/personalize",
            "scripts": [
                { "script": "script-example.sh", "action": "print-version", "execute": true,
                    "param": { "version": "3.6.66" }
                }
                ...mais scripts...
            ]
        },
        ...outros modulos de scripts...
    ]
}
```

Logo abaixo o arquivo json a ser usado como padrão do ambiente de desenvolvimento do **Garden of Eden**

> **Nota:**
>
> ***Lembre-se de alterar os valores correspondente aos parâmetros dos scripts, para a sua realidade.***

Arquivo principal do ambiente padrão: **settings-environment.json**

```json
{
    "settings": [
        {
            "module": "environment-default",
            "description": "Provisionar ambiente básico de desenvolvimento do (Garden Of Eden)",
            "active": true,
            "logsPath": "./logs/dist-ubuntu/environment",
            "scriptsPath": "./shell-script/dist-ubuntu/environment",
            "scripts": [
                { "script": "script-keyssh.sh", "action": "recreate", "execute": true,
                    "param": {
                        "comment": "Que reinaste o anjo caído!",
                        "nameKey": "id_rsa",
                        "pathKey": "/home/SeuUsuario/.ssh",
                        "passwordKey": ""
                    }
                },
                { "script": "script-git.sh", "action": "install", "execute": true,
                    "param": { "name": "SeuUsuario", "email": "SeuUsuario@mail.com" }
                },
                { "script": "script-jdk.sh", "action": "install", "execute": true,
                    "param": { "version": "12" }
                },
                { "script": "script-pyenv.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-nvm.sh", "action": "install", "execute": true,
                    "param": { "version": "0.34.0" }
                },
                { "script": "script-nodejs.sh", "action": "install-by-nvm", "execute": true,
                    "param": { "version": "10.15.3" }
                },
                { "script": "script-rvm.sh",  "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-ruby.sh", "action": "install-by-rvm", "execute": true,
                    "param": { "version": "2.5.5" }
                },
                { "script": "script-golang.sh", "action": "install", "execute": true,
                    "param": { "version": "1.12.4" }
                },
                { "script": "script-ansible.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-docker.sh", "action": "install", "execute": true,
                    "param": { "version": "18.09.6" }
                },
                { "script": "script-docker-compose.sh", "action": "install", "execute": true,
                    "param": { "version": "1.24.0" }
                },
                { "script": "script-virtualbox.sh", "action": "install", "execute": true,
                    "param": { "version": "6.0.8", "tagVersion": "6.0.8-130520" }
                },
                { "script": "script-vagrant.sh", "action": "install", "execute": true,
                    "param": { "version": "2.2.5" }
                },
                { "script": "script-packer.sh", "action": "install", "execute": true,
                    "param": { "version": "1.4.0" }
                },
                { "script": "script-terraform.sh", "action": "install", "execute": true,
                    "param": { "version": "0.12.3" }
                },
                { "script": "script-vscode.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-gitkraken.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-staruml.sh", "action": "install", "execute": true,
                    "param": { "version": "3.1.0" }
                },
                { "script": "script-netbeans.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-postman.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-chrome.sh", "action": "install", "execute": true,
                    "param": null
                }
            ]
        }
    ]
}
```

### Descrição dos parâmetros do arquivo padrão do projeto.

No arquivo padrão do Garden of Eden **"settings-environment.json"** consiste de 6 parâmetros básicos (**module**, **description**, **active**, **logsPath**, **scriptsPath**, **scripts**) como mostra o exemplo acima:

- "**module**": define a nome/tipo do modulo a ser executado.
- "**description**": define a descrição do modulo.
- "**active**": define se o modulo vai ser executado, (**true** ou **false**), se for **true** esse modulo será executado.
- "**logsPath**": destina-se ao diretório onde vai ser gerado os logs do modulo.
- "**scriptsPath**": destina-se ao diretório base, de onde vai ser chamados os shell scripts a serem executados.
- "**scripts**": define uma lista de scripts para ser executados em ordem, cada item dessa lista contem 4 parâmetros padrão, que são(**script, action, execute, param**).

Os parâmetros do **"scripts": [{...}, ...]** do ultimo item citado acima, consiste em:

- "**script**": define o nome do Shell Script a ser executado.
- "**action**" define o tipo da ação que queira executar no Shell Script, essa ação é de acordo com Shell Script especificado.
- "**execute**": define se o script vai ser executado, (**true** ou **false**), se for **true** esse script será executado caso contrario ele não é executado.
- "**param**": define um json de (**chave** e **valor**), esse json será repassado para o Shell Script especifico para ser consumido na execução.

## Executando o Garden of Eden. 

### Primeiro passo, baixar o projeto de um repositório do GitHub via CLI(Linux Command Line):

Abra terminal no seu linux e execute os comandos abaixo: 

Terminal:
```bash
$ wget "https://github.com/alisonbuss/garden-of-eden/archive/master.zip" -O ~/Downloads/garden-of-eden-master.zip
$ unzip ~/Downloads/garden-of-eden-master.zip -d ~/Downloads/
$ cd ~/Downloads/garden-of-eden-master
$ ls -a
```
Pronto agora você pode executar o "Garden of Eden":

Através do arquivo:
- **start-divine-creation.sh** em modo CLI.

### Executando em modo de CLI:

> **Nota:**
> *Antes de executar o **Garden of Eden**, certifique-se de ter ajustado os parâmetros do arquivo **settings.json** para sua realidade.*


#### Visualizar a documentação, passando o parâmetro **--help|-help|-h|help**.

Terminal:
```bash
$ bash start-divine-creation.sh --help
```

#### Listar todos os scripts a serem executados através do "settings.json", passando o parâmetro **--list**

> **Nota:**
> *Caso não seja passado o **--setting-file='...'** jundo com o parâmetro **--list** o Garden Of Eden ira setar o caminho padrão para './settings-environment.json'.*

Terminal:
```bash
$ bash start-divine-creation.sh --list
```
Ou:
```bash
$ bash start-divine-creation.sh -l
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'*:
```bash
$ bash start-divine-creation.sh --setting-file='./settings-environment.json' --list
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'* reduzido:
```bash
$ bash start-divine-creation.sh -s='./settings-environment.json' -l
```

#### Executando todos os scripts do "settings.json", passando o parâmetro **--rum**

> **Nota:**
> *Caso não seja passado o **--setting-file='...'** jundo com o parâmetro **--run** o Garden Of Eden ira setar o caminho padrão para './settings.json'.*

Terminal:
```bash
$ bash start-divine-creation.sh --run
```
Ou:
```bash
$ bash start-divine-creation.sh -r
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'*:
```bash
$ bash start-divine-creation.sh --setting-file='./settings-environment.json' --run
```
Ou, setando o caminho padrão: *--setting-file='./settings.json'* reduzido:
```bash
$ bash start-divine-creation.sh -s='./settings-environment.json' -r
```

### Executando em modo de CLI com Makefile:

Terminal:
```bash
$ make help
# OU
$ make version

# OU
$ make list-environment
$ make run-environment
```

## A estrutura do projeto Garden of Eden. 

Descrição das pastas e arquivos do projeto:

```
.
├── binaries.................................'Pasta dos binários e downloads dos scripts executados.'
│   └── jq-linux64-v1.6
├── logs.....................................'Pasta onde se encontra os logs gerados pelo Garden Of Eden.'
│   └── start-divine-creation.sh.log
├── shell-script.............................'Pasta dos scripts a ser executados de uma determinada distribuição linux.'
│   ├── dist-ubuntu
│   │   ├── environment
│   │   │   ├── script-ansible.sh
│   │   │   ├── script-chrome.sh
│   │   │   ├── script-docker-compose.sh
│   │   │   ├── script-docker.sh
│   │   │   ├── script-gitkraken.sh
│   │   │   ├── script-git.sh
│   │   │   ├── script-golang.sh
│   │   │   ├── script-jdk.sh
│   │   │   ├── script-keyssh.sh
│   │   │   ├── script-netbeans.sh
│   │   │   ├── script-nodejs.sh
│   │   │   ├── script-nvm.sh
│   │   │   ├── script-packer.sh
│   │   │   ├── script-pyenv.sh
│   │   │   ├── script-ruby.sh
│   │   │   ├── script-rvm.sh
│   │   │   ├── script-staruml.sh
│   │   │   ├── script-terraform.sh
│   │   │   ├── script-vagrant.sh
│   │   │   ├── script-virtualbox.sh
│   │   │   └── script-vscode.sh
│   │   └── personalize
│   │       ├── script-brasero.sh
│   │       ├── script-cfssl.sh
│   │       ├── script-example.sh
│   │       ├── script-gnomebaker.sh
│   │       ├── script-multimedia.sh
│   │       ├── script-psensor.sh
│   │       ├── script-repositories-git.sh
│   │       ├── script-tools.sh
│   │       └── script-themes.sh
│   └── tools
│       └── utility.sh
├── support-files............................'Pasta de apoio, onde se encontra os arquivos variados, como configurações, logo, wallpaper etc.'
│   ├── logo-garden-of-eden.png
│   ├── docker-configs
│   │   ├── containerd.service
│   │   ├── docker.service
│   │   └── docker.socket
│   ├── files
│   │   ├── end-bender.gif
│   │   └── header.txt
│   └── wallpapers
│       ├── wallpaper01.jpg
│       └── ...
├── LICENSE..................................'Licença - MIT.'
├── Makefile.................................'Arquivo para reduzir/facilitar a forma de execução do projeto Garden of Eden via CLI.'
├── README.md................................'Descrição e documentação do projeto Garden of Eden.'
├── README-MY.md.............................'Descrição do meu ambiente personalizado/adicional do Garden of Eden.'
├── settings-environment.json................'Arquivo principal do projeto onde é definido a modularização dos scripts shell a serem executados.'
├── settings-personalize.json................'Arquivo secundário, para um ambiente alternativo a ser executado, baseado no modelo padrão do Garden of Eden.'
└── start-divine-creation.sh.................'Shell Script de inicialização do projeto em modo de CLI.'
```

Caso tu queiras criar um script de instalação de um programa do seu interesse, no próprio projeto tem um script de exemplo que você pode usar como base inicial, exemplo abaixo:

Diretório: ./shell-script/dist-ubuntu/personalize/script-example.sh

> **Nota:**
>
> *Por padrão, os seguintes recursos serão disponibilizados para todos os scripts de shell, através **./start-divine-creation.sh**:*
>
> **1)** *Duas variáveis de ambientes **[LOCAL_DIR, RUN_JQ]**.*
>
> **2)** *Importe de utilitários shell **./shell-script/tools/utility.sh**.*
>

Arquivo:

```bash
#!/bin/bash
 
#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Sua Descrição da Instalação na Maquina.
# @fonts: Fontes de referências
# @example:
#
#   bash script-example.sh --action='print-version' --param='{"version":"3.6.66"}'
#
#-------------------------------------------------------------#

# @descr: Descrição da Função.
# @fonts: Fontes de referências
# @param: 
#    action | text: (install, uninstall)
#    param | json: '{"version":"..."}'
function ScriptExample {
    
    # @descr: Variavel que define a ação que o script ira realizar.
    local ACTION=$(util.getParameterValue "(--action=|-a=)" "$@");
    # @descr: Variavel de parametros JSON.
    local PARAM_JSON=$(util.getParameterValue "(--param=|-p=)" "$@");

    # @descr: Descrição da Variavel.
    local version=$(echo "${PARAM_JSON}" | $RUN_JQ -r '.version');

    # @descr: Descrição da Função.
    # @fonts: Fontes de referências
    # @param: Parametros (--aa='aaa', --bb='bbb')
    __print_version() {
        util.print.out '%s\n' "Iniciando o Teste do Example na maquina...";
        util.print.out '%s\n' "--> Print Version: ${version}";

        util.print.out '%s\n' "--> Print value: ${version}"; 

        echo "Print value [LOCAL_DIR]: $LOCAL_DIR";
        
        cat ./shell-script/tools/utility.sh;
    }

    # @descr: Função é chamada qndo a um erro de tipo de ação.
    # @param: 
    #    action | text: "..." | Action não encontrado.
    __actionError() {
        local actionErr=$(util.getParameterValue "(--action=|-a=)" "$@");
        util.print.error "Erro: 'action' passado:(${actionErr}) não coincide com [install, uninstall]!";
        return 1;
    } 

    # @descr: Função principal "um construtor por exemplo".
    __initialize() {
        case ${ACTION} in
            print-version) { 
                __print_version; 
            };;
            *) {
               __actionError "--action=${ACTION}"; 
            };;
        esac
    }

    # @descr: Chamada da função principal de inicialização do script.
    __initialize "$@";
}

# SCRIPT INITIALIZE...
util.try; ( ScriptExample "$@" ); util.catch || {
    util.print.error "Erro: Ao executar o script '${0##*/}', Exception Code: ${exception}";
    util.throw $exception;
}

exit 0;
```

Caso tu queiras mudar de distribuição linux, exemplo *"dist-fedora"*, basta copiar a pasta "**dist-ubuntu**" e renomear para "**dist-sua-distribuição**" e agora é ajustar os scripts do diretório "**dist-sua-distribuição/**", para que assim possa rodar os scripts de acordo com a distribuição Linux escolhida.

Exemplo:

```text
.
└── shell-script
    └── dist-ubuntu

Para:

.
└── shell-script
    └── dist-fedora
```  

E agora é só mudar o parâmetro "**scriptsPath**" do arquivo **settings-environment.json** ou **settings-personalize.json** para **..."scriptsPath": "./dist-sua-distribuição"...**, exemplo:

```json
{
    "settings": [
        {
            "module": "environment-default",
            "description": "Provisionar ambiente básico de desenvolvimento do (Garden Of Eden)",
            "active": true,
            "logsPath": "./logs/dist-fedora/environment",
            "scriptsPath": "./shell-script/dist-fedora/environment",
            "scripts": [
                ...mais scripts...
            ]
        }
    ]
}
```

***Pronto!! Agora você tem um ambiente de desenvolvimento básico para as distribuições linux, du karalho né?? rsrsrsrs...***

<p align="center">
    <img src="https://github.com/alisonbuss/garden-of-eden/raw/master/support-files/files/end-bender.gif" width="287px"/>
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
* Blog pantuza, Gustavo Pantuza. ***COMO FUNCIONA O MAKEFILE*** 
  Acessado: *13 de Setembro de 2018.*
  Disponível: *[https://blog.pantuza.com/tutoriais/como-funciona-o-makefile/](https://blog.pantuza.com/tutoriais/como-funciona-o-makefile/)*.
* Blog Linux Journal, Mitch Frazier. ***Pattern Matching In Bash*** 
  Acessado: *13 de Maio de 2019.*
  Disponível: *[https://www.linuxjournal.com/content/pattern-matching-bash/](https://www.linuxjournal.com/content/pattern-matching-bash/)*.
* Blog dev.to, Niko Heikkila. ***Don't Use Bash for Scripting (All the Time)*** 
  Acessado: *13 de Maio de 2019.*
  Disponível: *[https://dev.to/nikoheikkila/don-t-use-bash-for-scripting-all-the-time-2kci/](https://dev.to/nikoheikkila/don-t-use-bash-for-scripting-all-the-time-2kci/)*.


## Tradução | Translation
- [Inglês | English](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=en&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhjF8wXBywEnSgThP4hIo1rEuBQcIw)
- [Espanhol | Español](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=es&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgaHMX6VZow_LV_2D6thOl3ojl1Cw)
- [Russo | русский](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ru&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgUDrwtXLR16xyVuHUFVSjUYsqF1w)
- [Chinês | 中國](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=zh-TW&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhhzK2w-woMjhAwW32tPxVeGv57DeQ)
- [Coreano do Norte | 한국어](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ko&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhiN-zOrr5ZpGk91vIzguZh-aavo_g)


## Licença

[<img width="190" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/logo-open-source-550x200px.png">](https://opensource.org/licenses)
[<img width="166" src="https://raw.githubusercontent.com/alisonbuss/my-licenses/master/files/icon-license-mit-500px.png">](https://github.com/alisonbuss/garden-of-eden/blob/master/LICENSE)
