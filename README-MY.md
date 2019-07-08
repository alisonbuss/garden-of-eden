
<h1>Garden of Eden - Personalize</h1>

> **Nota:**
>
> ***Esse ambiente disponibiliza meus recursos personalizados, como tema, papel de parece, programas de multimídias e codecs, clone dos meus repositórios GitHub e entre outros...***

### O **Garden of Eden - Personalize** provisiona os seguentes recursos:

- Instala o **Tools**
- Instala o **CfSSL**
- Instala o **Psensor**
- Instala o **Brasero**
- Instala o **GnomeBaker**
- Instala o **Multimedia (vlc, extras)**
- Instala o **Themes (pop-theme, gnome-tweak-tool, chrome-gnome-shell)**
- Clona o **Repository Work**
    - []
- Clona o **Repository Private**
    - []
- Clona o **Repository Public**
    - https://github.com/alisonbuss/garden-of-eden.git
    - https://github.com/alisonbuss/centos-packer.git
    - https://github.com/alisonbuss/ubuntu-packer.git
    - https://github.com/alisonbuss/coreos-packer.git
    - https://github.com/alisonbuss/cluster-coreos-kubernetes-ansible.git
    - https://github.com/alisonbuss/cluster-coreos-kubernetes-vagrant.git
    - https://github.com/alisonbuss/ubuntu-vagrant.git
    - https://github.com/alisonbuss/centos-vagrant.git
    - https://github.com/alisonbuss/coreos-kids-vagrant.git
    - https://github.com/alisonbuss/cluster-coreos-basic-vagrant.git
    - https://github.com/alisonbuss/multiple-nodes-vagrant.git
    - https://github.com/alisonbuss/project-initial-ansible.git
    - https://github.com/alisonbuss/ansible-environment.git
    - https://github.com/alisonbuss/cluster-coreos-terraform.git
    - https://github.com/alisonbuss/terraform-provider-vagrant.git
    - https://github.com/alisonbuss/provider-vagrant-for-terraform.git
    - https://github.com/alisonbuss/kharon.git
    - https://github.com/alisonbuss/my-posts.git
    - https://github.com/alisonbuss/crud-angular6.git
    - https://github.com/alisonbuss/publish-articles-angular.git
    - https://github.com/alisonbuss/shell-script-tools.git
    - https://github.com/alisonbuss/kubernetes-the-hard-way.git
    - https://github.com/alisonbuss/alisonbuss.github.io.git
    - https://github.com/alisonbuss/my-licenses.git
    - https://github.com/alisonbuss/Formulation.git
    - https://github.com/alisonbuss/QuestionsAnswers-AndroidApp.git
    - https://github.com/alisonbuss/new-garden-of-eden.git
    - https://github.com/alisonbuss/cluster-kubernetes-ansible-vagrant.git
    - https://github.com/alisonbuss/cluster-coreos-ansible-vagrant.git
    - https://github.com/alisonbuss/modules-for-packer.git
    - https://github.com/alisonbuss/my-garden-of-eden-light.git




### Logo abaixo o arquivo json a ser usado para executar o ambiente personalizado.

Arquivo principal do ambiente: **settings-personalize.json**

```json
{
    "settings": [
        {
            "module": "personalize",
            "description": "Provisionar ambiente personalizado com temas e recursos pessoais",
            "active": true,
            "logsPath": "./logs/dist-ubuntu/personalize",
            "scriptsPath": "./shell-script/dist-ubuntu/personalize",
            "scripts": [
                { "script": "script-tools.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-cfssl.sh", "action": "install", "execute": false,
                    "param": null
                },
                { "script": "script-psensor.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-brasero.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-multimedia.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-themes.sh", "action": "install", "execute": true,
                    "param": null
                },
                { "script": "script-repositories-git.sh", "action": "clone", "execute": true,
                    "param": {
                        "rootPath": "/mnt/sda3/git-repositories",
                        "repositories": [
                            {
                                "repositoryPath": "/work",
                                "clonesAddress": []
                            }
                        ]
                    }
                },
                { "script": "script-repositories-git.sh", "action": "clone", "execute": true,
                    "param": {
                        "rootPath": "/mnt/sda3/git-repositories",
                        "repositories": [
                            {
                                "repositoryPath": "/private",
                                "clonesAddress": []
                            }
                        ]
                    }
                },
                { "script": "script-repositories-git.sh", "action": "clone", "execute": false,
                    "param": {
                        "rootPath": "/mnt/sda3/git-repositories",
                        "repositories": [
                            {
                                "repositoryPath": "/public",
                                "clonesAddress": [
                                    "https://github.com/alisonbuss/garden-of-eden.git",
                                    "https://github.com/alisonbuss/centos-packer.git",
                                    "https://github.com/alisonbuss/ubuntu-packer.git",
                                    "https://github.com/alisonbuss/coreos-packer.git",
                                    "https://github.com/alisonbuss/cluster-coreos-kubernetes-ansible.git",
                                    "https://github.com/alisonbuss/cluster-coreos-kubernetes-vagrant.git",
                                    "https://github.com/alisonbuss/ubuntu-vagrant.git",
                                    "https://github.com/alisonbuss/centos-vagrant.git",
                                    "https://github.com/alisonbuss/coreos-kids-vagrant.git",
                                    "https://github.com/alisonbuss/cluster-coreos-basic-vagrant.git",
                                    "https://github.com/alisonbuss/multiple-nodes-vagrant.git",
                                    "https://github.com/alisonbuss/project-initial-ansible.git",
                                    "https://github.com/alisonbuss/ansible-environment.git",
                                    "https://github.com/alisonbuss/cluster-coreos-terraform.git",
                                    "https://github.com/alisonbuss/terraform-provider-vagrant.git",
                                    "https://github.com/alisonbuss/provider-vagrant-for-terraform.git",
                                    "https://github.com/alisonbuss/kharon.git",
                                    "https://github.com/alisonbuss/my-posts.git",
                                    "https://github.com/alisonbuss/crud-angular6.git",
                                    "https://github.com/alisonbuss/publish-articles-angular.git",
                                    "https://github.com/alisonbuss/shell-script-tools.git",
                                    "https://github.com/alisonbuss/kubernetes-the-hard-way.git",
                                    "https://github.com/alisonbuss/alisonbuss.github.io.git",
                                    "https://github.com/alisonbuss/my-licenses.git",
                                    "https://github.com/alisonbuss/Formulation.git",
                                    "https://github.com/alisonbuss/QuestionsAnswers-AndroidApp.git",
                                    "https://github.com/alisonbuss/new-garden-of-eden.git",
                                    "https://github.com/alisonbuss/cluster-kubernetes-ansible-vagrant.git",
                                    "https://github.com/alisonbuss/cluster-coreos-ansible-vagrant.git",
                                    "https://github.com/alisonbuss/modules-for-packer.git",
                                    "https://github.com/alisonbuss/my-garden-of-eden-light.git"
                                ]
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

### Executando em modo de CLI com Makefile:

Terminal:
```bash
$ make help
# OU
$ make version

# OU
$ make list-personalize
$ make run-personalize
```

### (Check List) Na fase de formatação do sistema e na pós formatação:

1. **Formatação:**
   * Nome da Sessão: **Admin**
   * Nome do Computador: **cpu-master**
   * Name do usuario: **dev**
   * Senha: **3366677**
2. **Pós Formatação:**
   * Configuração: Dispositivos: Monitores: Ajustar para uma unica tela.
   * Configuração: Energia: Desabilitar proteção de tela e suspensão automática.
   * Configuração: Wi-Fi: Se conectar a uma rede.
   * Disco: Editar opções de montagem. 
   * Atualizar o sistema. 
3. **Executar o Garden Of Eden:**
   * $ make list-environment
   * $ make run-environment  
4. **Executar o Garden of Eden - Personalize:**
   * $ make list-personalize
   * $ make run-personalize  
   * Instale no Firefox os seguintes plugins:
      * https://extensions.gnome.org/extension/19/user-themes/
      * https://extensions.gnome.org/extension/1160/dash-to-panel/

