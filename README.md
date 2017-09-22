
<h2>
  <img src="https://github.com/alisonbuss/garden-of-eden/raw/master/files/logo-garden-of-eden.png" width="60px" alt="logo" style="vertical-align: middle;"/> 
  Garden of Eden
</h2>

# 

É um projeto Shell Script para provisionamento de um ambiente básico de desenvolvimento para uma distribuição Ubuntu, podendo ser ampliado para distribuições Fedora, openSUSE, Arch Linux, Red Hat Enterprise Linux e as demais distribuição disponíveis.

O **Garden of Eden** provisiona os seguentes programas:

- Gera **chave SSH**
- Instala **Git**
- Instala **JDK**
- Instala **NVM**
- Instala **Node.js + NPM**
- Instala **Go**
- Instala **CFSSL**
- Instala **Config Transpiler**
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
> **1)** *O intuito do projeto **Garden of Eden** é acadêmico, ou seja, para fins de conhecimentos, não sou um profissional linux e Shell Script, qualquer opinião, sugestão será bem vinda.* 
>
> **2)** *A maior parte do conhecimento obtido para se desenvolver esse projeto foi a traveis do canal do YouTube "[Bóson Treinamentos - Shell Scripting - Programação no Linux](https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs)", fico inteiramente grato por todas as informações obtida por esse canal.* 
>  

## O funcionamento do Garden of Eden.

A estrutura base do projeto consiste em um arquivo **"settings.json"**, esse arquivo 
defini a distribuição linux a ser usada e a ordem de execução dos Shell Scripts e 
seus parâmetros. Um exemplo do arquivo **"settings.json"**:

```json
{
    "distribution": "./dist-ubuntu",
    "settings": [
        {"script": "script-git.sh", "action": "install", "execute": true, 
            "param": { 
                "nameUser": "Lúcifer", "emailUser": "lucifer.dev@ghell.com" 
            }
        }, 
        ...
    ]
}
```

No arquivo **"settings.json"** consiste de 2 parâmetros básicos (**distribution** e o **settings**) 
como mostra o exemplo acima: 

- "**distribution**": destina-se ao diretório de um tipo de distribuição linux, nesse projeto se usa o Ubuntu.
- "**settings**": é uma lista de scripts em ordem a ser executados de acordo com a distribuição linux setada no parâmetro *distribution*, essa lista contem 4 parâmetros padrões que são (**script, action, execute, param**).

Os parâmetros do **"settings: [{...}, ...]"** consiste em:

- "**script**": define o nome do Shell Script a ser executado.
- "**action**" define o tipo da ação que queira executar no Shell Script, essa ação é de acordo com Shell Script especificado.
- "**execute**": define se o script vai ser executado, (**true** ou **false**), se for **true** esse script será executado caso contrario ele não é executado.
- "**param**": define um json de (**chave** e **valor**), esse json será repassado para o Shell Script especificado para ser consumido na execução.

### Como ficaria o arquivo "settings.json" do Garden of Eden:

```json
{
    "distribution": "./dist-ubuntu",
    "settings": [
        { "script": "script-keyssh.sh", "action": "create", "execute": true, 
            "param": { "comment": "Que reinaste o anjo caído!", "passwordKey": "luxferre", "pathKey": "/home/user/.ssh", "nameKey": "id_rsa" } 
        },
        { "script": "script-git.sh", "action": "install", "execute": true, 
            "param": { "nameUser": "Lúcifer", "emailUser": "lucifer.dev@ghell.com" }
        },
        { "script": "script-jdk.sh", "action": "install", "execute": true, 
            "param": { "version": "8" } 
        },
        { "script": "script-nvm.sh", "action": "install", "execute": true, 
            "param": { "version": "0.33.4" } 
        },
        { "script": "script-nodejs.sh", "action": "install", "execute": true, 
            "param": { "version": "8.4.0" } 
        },
        { "script": "script-golang.sh", "action": "install", "execute": true, 
            "param": { "version": "1.9" } 
        },
        { "script": "script-cfssl.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-config-transpiler.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-ansible.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-virtualbox.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-vagrant.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-vscode.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-gitkraken.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-staruml.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-chrome.sh", "action": "install", "execute": true, "param": null },
        { "script": "script-netbeans.sh", "action": "install", "execute": true, "param": null }
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
Pronto agora você pode executar um dos dois Shell Scripts do "Garden of Eden" que são:

- "start-divine-creation.sh" em modo de comandos.
- "start-divine-creation-ui.sh" em modo gráfico.

### Executando em modo de comandos:

Você tem que dar permissão root ao script.

Terminal:
```bash
$ sudo chmod a+x start-divine-creation.sh
```

Visualizar a documentação, passando o parametro **--view-doc**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --view-doc
```

Visualizar ou editar o "settings.json", passando o parametro **--edit-settings** e o **editor de texto**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --edit-settings gedit
```

Visualizar ou editar o script, passando o parametro **--edit-script** e **nome do script** e o **editor de texto**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --edit-script script-git.sh gedit
```

Executando os scripts do "settings.json", passando o parametro **--rum**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --run
```

Visualizar o log de um determinado script, passando o parametro **--view-log** o **nome do script** e o **editor de texto**.

Terminal:
```bash
$ sudo bash start-divine-creation.sh --view-log script-git.sh gedit
```

### Executando em modo de gráfico:

Você tem que dar permissão root ao script.

Terminal:
```bash
$ sudo chmod a+x start-divine-creation-ui.sh
```

Agora só é executar.

Terminal:
```bash
$ sudo bash start-divine-creation-ui.sh
```

## A estrutura do projeto Garden of Eden. 

Descrição das pastas e arquivos do projeto:

```
garden-of-eden
  |--binaries/....................'Pasta onda se salva os downloads dos binários temporários feito pelos scripts.'
  |--dist-ubuntu/.................'Pasta de uma determinada distribuição linux, onde se encontra os scripts de execução e seus logs '
     |--logs/.....................'Pasta onde se encontra os logs gerados por scripts de execução.'
     |--scripts/..................'Pasta onde se encontra os scripts de execução.'
  |--files/.......................'Pasta de apoio, onde se encontra os arquivos variados, como logo, wallpaper etc.'
  |--shell-script-tools/..........'Pasta onde se encontra bibliotecas de utilitários para Shell Scripts.'
     |--linux/utility.sh..........'Shell Script de utilitário em geral.'
     |--ubuntu/extension-jq.sh....'Shell Script para instalação da extensão 'jq' para distribuição Ubuntu.'
  |--LICENSE......................'Licença Pública Geral - GPL-3.0.'
  |--README.md....................'Descrição e documentação do projeto Garden of Eden.'
  |--settings.json ...............'Arquivo principal do projeto onde é definido a distribuição linux a ser usada e a ordem de execução dos Shell Scripts e seus parâmetros.'
  |--start-divine-creation-ui.sh..'Shell Script de inicialização do projeto em modo de interface gráfico.'
  |--start-divine-creation.sh.....'Shell Script de inicialização do projeto em modo de comandos.'
```

Caso tu queiras criar um script de instalação de um programa do seu interesse, no próprio projeto tem um template que você pode usar como base inicial, exemplo do template abaixo:

Diretório: dist-ubuntu/scripts/script-template.sh

Arquivo:

```bash
#!/bin/bash

###################  DOC  ###################
# @descr: Sua Descrição. 
# @fonts: Fontes de referências
# @param: 
#    action | text: (açãoA, açãoB)                 "PARAMETRO "action" É PADRÃO"
#    paramJson | json: {"versionExemplo":"..."}    "PARAMETRO DE EXEMPLO"
#############################################

function ScriptNomeDoQueVaiFazer {
    
    local ACTION=$1;
    local PARAM_JSON=$2;
    
    local version=$(echo ${PARAM_JSON} | jq -r '.versionExemplo');

    __install() {
        print.info "Iniciando..."; 

       
    }

    __uninstall() {
        print.info "Iniciando..."; 
        
        
    }

    __actionError() {
        print.error "Erro: 'action' passado:($ACTION) não coincide com [açãoA, açãoB]!";
    } 

    __initialize() {
        case ${ACTION} in
            açãoA) __install; ;;
            açãoB) __uninstall; ;;
            *) __actionError;
        esac
    }

    __initialize;
}

ScriptNomeDoQueVaiFazer "$@";

exit 0;
```

Caso tu queiras mudar de distribuição linux, exemplo *"dist-fedora"*, basta copiar a pasta "**dist-ubuntu**" e renomear para "**dist-sua-distribuição**" e mudar o parâmetro "**distribution**" do arquivo **settings.json** para **..."distribution": "./dist-sua-distribuição"...** e ajustar os scripts do diretório "**dist-sua-distribuição/scripts/**", para que possa rodar as instalações de acordo com sua distribuição, exemplo:

```
garden-of-eden
  |--dist-ubuntu/
     |--logs/
     |--scripts/...
  |--dist-fedora/
     |--logs/
     |--scripts/...
```  

E mudar o parametro do arquivo **"settings.json"**:

```json
{
    "distribution": "./dist-fedora",
    "settings": [...]
}
```

***Pronto!! Agora você tem um ambiente de desenvolvimento básico para duas distribuições linux e homogêneas, du karalho né?? rsrsrsrs...***


## Tradução | Translation
- [Inglês | English](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=en&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhjF8wXBywEnSgThP4hIo1rEuBQcIw)
- [Espanhol | Español](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=es&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgaHMX6VZow_LV_2D6thOl3ojl1Cw)
- [Russo | русский](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ru&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhgUDrwtXLR16xyVuHUFVSjUYsqF1w)
- [Chinês | 中國](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=zh-TW&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhhzK2w-woMjhAwW32tPxVeGv57DeQ)
- [Coreano do Norte | 한국어](https://translate.googleusercontent.com/translate_c?act=url&depth=1&hl=pt-BR&ie=UTF8&prev=_t&rurl=translate.google.com.br&sl=pt-BR&sp=nmt4&tl=ko&u=https://github.com/alisonbuss/garden-of-eden&usg=ALkJrhiN-zOrr5ZpGk91vIzguZh-aavo_g)

## Licença

- [GPL-3.0: GNU General Public License v3.0](https://github.com/alisonbuss/garden-of-eden/blob/master/LICENSE)
