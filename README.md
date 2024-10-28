# Servidor_Nginx
Servidor NGINX utilizando WSL com ubuntu 20.04

# Processo de instalação do Linux no Windows via WSL
  1. Na barra de pesquisa digite: powershell.
  2. Execute como admnistrador.
  3. Digite `wsl --install`.
     > Ele instala por padrão a versão do Ubuntu na release mais recente, caso queira utilizar outra versão utilize o comando `wsl --install -d <Nome da distribuição>`.
  4. Reinicie sua maquina
  5. Agora abra novamente o powershell, de um `wsl -l -v` e verifique se foi instalado corretamente.
  6. Va na barra de pesquisa e abra o aplicativo do Ubuntu.
     > Caso você tenha instalado outra distro so pesquisar o nome dela ou no proprio powershell digite `wsl` que ira abrir a distro linux.

# Instalando o servidor Nginx
  1. `sudo apt update`
  2. `sudo apt install nginx`
  3. Agora com o Nginx instalado iremos iniciar ele.
  4. `sudo systemctl nginx`
  5. Verificaremos se o Nginx iniciou corretamente.
  6. `sudo systemctl nginx status`
     > Se tudo der certo deve aparecer como `active(running)`
  7. Abra agora o seu navegador e digite http://localhost

# Criando o Script de atividade do Nginx
  Iremos criar um Script simples, para verificar se o Nginx se encontra online ou offline. Criando um arquivo log no qual ira nos dizer a data e hora da ultima verificação além de expecificar se está online ou não.
