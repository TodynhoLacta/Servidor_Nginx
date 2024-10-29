# Servidor_Nginx
Servidor NGINX utilizando WSL com ubuntu 20.04

# Processo de instalação do Linux no Windows via WSL
  1. Na barra de pesquisa digite: PowerShell.
  2. Execute como administrador.
  3. Digite `wsl --install`.
     > Ele instala por padrão a versão do Ubuntu na release mais recente, caso queira utilizar outra versão utilize o comando `wsl --install -d <Nome da distribuição>`.
  4. Reinicie sua máquina.
  5. Abra novamente o PowerShell, de um wsl -l -v e verifique se a instalação foi feita de forma correta.
  6. Na barra de pesquisa selecione e abra o aplicativo Ubuntu.
     > Caso tenha instalado outra distro, pesquise o nome da mesma ou digite wsl no powershell para abri-la.

# Instalando o servidor Nginx.
  1. `sudo apt update`
  2. `sudo apt install nginx`
  3. Com o Nginx instalado, inicie-o.
  4. `sudo systemctl nginx`
  5. Verifique se o Nginx iniciou corretamente.
  6. `sudo systemctl nginx status`
     > Se realizado da forma correta, aparecerá a seguinte mensagem:`active(running)`
  7. Abra agora o seu navegador e digite http://localhost.

# Criando o Script de atividade do Nginx.
Crie um Script simples, afim de verificar se o Nginx se encontra online ou offline. Resultará em um arquivo log, cujo mesmo informará a data e hora da última verificação, além de especificar se está online ou não.
  
1.Para manter a organização, é recomendado que crie um diretório via comando na pasta etc(/etc):

`sudo mkdir /etc/scripts`

2.Em seguida, acesse a pasta executando:

`sudo cd /scripts`

3.Crie um Script com um nome que represente a função:
>Ex.:Em um teste a pasta foi criada com nome em inglês “verify.sh”, utilizando o comando “touch”.

>Obs.: Sh é uma extensão no qual o Linux reconhecerá como script.

`sudo touch verify.sh`
	
4.O comando touch ficará responsável pela criação do arquivo e, antes de realizar as edições, é recomendado que deixe a permissão de execução:

`sudo chmod +x verify.sh`

5.Em continuidade, poderá executar o script para realizar os testes, posteriormente de forma automatizada. Após, abrir o script via terminal para a edição, utilizando o comando "vi":

`sudo vi verify.sh`
	
6.Há possibilidade de adicionar linhas de comando e comentários utilizando o "i" para abrir em modo de "edição". A explicação do Script estará nos comentários representados por "#":
  
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

7.Configure para que este script comece sua execução sempre que iniciarmos o servidor ou a cada 5 minutos.

`sudo crontab -e`
	
8.Selecione a primeira opção “/bin/nano”. Na tela abaixo coloque o seguinte comando.

    */5 * * * * /etc/scripts/verify.sh

9.O comando "*/5" faz com que o crontab entenda que deverá executar a cada 5 minutos. Retirando o asterisco e a barra deste comando "5", observa-se que o servidor apenas rodará o script a cada 5 minutos por hora. 
>Ex.: 01:05/02:05 e assim por diante.
