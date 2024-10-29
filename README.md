# Servidor_Nginx
Servidor NGINX utilizando WSL com ubuntu 20.04

# Processo de instalação do Linux no Windows via WSL
  1. Na barra de pesquisa digite: PowerShell.
  2. Execute como administrador.
  3. Digite `wsl --install`.
     > Ele instala por padrão a versão do Ubuntu na release mais recente, caso queira utilizar outra versão utilize o comando `wsl --install -d <Nome da distribuição>`.
  4. Reinicie sua máquina.
  5. Agora abra novamente o PowerShell, de um `wsl -l -v` e verifique se foi instalado corretamente.
  6. Vá à barra de pesquisa e abra o aplicativo do Ubuntu.
     > Caso você tenha instalado outra distro so pesquisar o nome dela ou no proprio powershell digite `wsl` que ira abrir a distro linux.

# Instalando o servidor Nginx.
  1. `sudo apt update`
  2. `sudo apt install nginx`
  3. Agora com o Nginx instalado, iremos iniciar ele.
  4. `sudo systemctl nginx`
  5. Verificaremos se o Nginx iniciou corretamente.
  6. `sudo systemctl nginx status`
     > Se tudo der certo deve aparecer como `active(running)`
  7. Abra agora o seu navegador e digite http://localhost.

# Criando o Script de atividade do Nginx.
Iremos criar um Script simples, para verificar se o Nginx se encontra online ou offline. Criando um arquivo log no qual irá nos dizer a data e hora da última verificação, além de especificar se está online ou não.
  
1.Para questões de organização, recomendo que crie um diretorio via comando na pasta etc(/etc):

`sudo mkdir /etc/scripts`

2.Em seguida, acesse a pasta executando:

`sudo cd /scripts`

3.Agora crie um Script com um nome que represente a função, no meu caso criei com nome em inglês chamado verify.sh, utilizando o comando "touch":

obs: Sh é uma extensão no qual o Linux reconhecerá como script.

`sudo touch verify.sh`
	
4.O comando touch fica responsável pela criação do arquivo e, antes de fazermos as edições, recomendo que deixemos permissão de execução:

`sudo chmod +x verify.sh`

5.Assim podemos executar ele para realizar os testes e também posteriormente de forma automatizada, agora iremos abrir ele via terminal para a edição utilizando o comando "vi":

`sudo vi verify.sh`
	
6.Aqui podemos adicionar linhas de comando e comentários utilizando o "i" para abrir em modo de "edição". A explicação do Script estará nos comentários representados por "#":
  
    # !/bin/bash
    
    # Caminho para os logs.
    
      LOGS_PATH="/var/logs_nginx"
    
    # Relatorios dos logs.
    
      ONLINE_NGINX="$LOGS_PATH/status_online.log"
      OFFLINE_NGINX="$LOGS_PATH/status_offline.log"
    
    # DATA e HORA.
      
      DATA=$(date "+%Y-%m-%d")
      TIME=$(date "+%H:%M:%S")
    
    # Verificar se arquivos de log existe caso não ele irá criar o arquivo.
     
      if test -e $ONLINE_NGINX; 
        then
          echo "O arquivo status_online.log encontrado"
        else
          touch /var/logs_nginx/status_online.log
        fi
      if test -e $OFFLINE_NGINX; 
        then
          echo "O arquivo status_offline.log encontrado"
        else
          touch /var/logs_nginx/status_offline.log
        fi
    
    # Verificar se o serviço se encontra ativo.
     
      if systemctl is-active -q nginx; 
        then
          echo "$DATA - $TIME - Nginx - Status: ONLINE" >> "$ONLINE_NGINX"
          echo "Nginx encontra-se em execução"
        else
          echo "$DATA - $TIME - Nginx - Status: OFFLINE" >> "$OFFLINE_NGINX"
          echo "Nginx encontra-se fora de serviço"
        fi

7.Agora iremos configurar para este script executar sempre que iniciarmos o servidor ou a cada 5 minutos.

`sudo crontab -e`
	
8.Selecione a primeira opção /bin/nano, agora na tela abaixo você irá colocar o seguinte comando.

    */5 * * * * /etc/scripts/verify.sh

9.O `*/5` faz com que o crontab entenda que é para executar a cada 5 minutos, sem esse "*/" antes do cinco faria com que o servidor só rodasse o script a cara 5 minutos por hora. Ex: 01:05/02:05 e assim por diante.
