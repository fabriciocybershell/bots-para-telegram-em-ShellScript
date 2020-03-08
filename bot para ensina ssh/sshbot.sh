#! /bin/bash

source ShellBot.sh

bot_token='SUA_TOKEN'

ShellBot.init --token "$bot_token" --return map 
inicio='
[ "comunicação ssh" ],
[ "como funciona" ], 
[ "conceito de ssh" ]
'

rede='
[ "local/localhost" ],
[ "retornar ao menu" ]
'

sistema='
[ "Raspberry pi" ],
[ "Linux" ]
'

conect='
[ "linux" , "windows" ],
[ "android" ]
'

app=''
ShellBot.InlineKeyboardButton --button 'app' --line 1 --text 'JuiceSSH' --callback_data '1' --url 'https://play.google.com/store/apps/details?id=com.sonelli.juicessh'
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'app')"

while :
do

ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30

for id in $(ShellBot.ListUpdates) 
		do
		(
			case ${message_text[$id]%%@*} in
			/start)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "olá ${message_from_first_name[$id]}, eu sou um bot de ssh, e estou aqui para ajudalo a configurar uma conexão por ssh."
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "eu sou operado por opções, você faz suas escolhas referente ao seu objetivo, e eu irei te dar instruções."
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 7s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o que deseja fazer primeiro ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown			
			;;
			'comunicação ssh')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "selecione a opção" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'rede' --one_time_keyboard 'true')" --parse_mode markdown			
			;;
			/desligar)
			init 0
			;;
			'como funciona')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "a comunicação ssh é feita atravez da rede, ela que permite um rápido e seguro controle das maquinas remotas."
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "ele se comunica com a maquina da mesma maneira que um navegador se conecta aos sites, no lugar de usar HTTPS://www ..."
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "ele usa o endereço ip: 192.168. ..., \n no caso de se realizar a comunicação, é inserindo o nome da maquina junto com o endereço ip: \n pc@172.6.... ou o ip da porta de comunicação."
			sleep 7s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "segue a tabela abaixo dos principais protocolos:"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @protocolo.png --caption "ssh é a porta 22."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "fim da explicação reduzida." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown			
			;;
			'conceito de ssh')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o SSH (Secure SHell) é um protocolo de comincação remota, que permite acessar virtualmente o terminal de outra máquina/servidor na rede de forma segura, seja na mesma rede ou conectada na internet em qualquer parte do mundo."
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "se tiver mais duvidas, procure online 😉." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'local/localhost')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "qual sistema que será controlado ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'sistema' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'Raspberry pi')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você deve acessar o bash do raspberri.\n Digite:\n 	sudo raspi-config # para acessar as configurações."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "selecione a opção abaixo:"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @interfacing.png --caption "Interfacing Options"
			sleep 6s
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @ssh.png --caption "SSH"
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "clicar em <YES> e depois <OK>"
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "pegue o ip digitando: ifconfig \n e anote.\n agora reinicie seu raspberry pi para ativar o ssh, ou digite :\n 	sudo reboot now" 
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "selecione a máquina cliente:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'conect' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'Linux')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "geralmente, as distribuições já vem com o pacote instalado, caso a sua distro não possua ssh, instale digitando:"
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Debiam e derivados:\n 	sudo apt-get install openssh-server openssh-client"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Fedora e derivados:\n 	dnf install openssh-server\n ou \n yun install openssh-server"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Artch e derivador:\n 	sudo pacman -S openssh"
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "em seguida você deve abrir a porta de comunicação do firewal da sua máquina, para permitir ser acessada remotamente."
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "digite o comando:\niptables -A INPUT -p tcp --dport 22 -j ACCEPT\n\n este comando irá liberar a porta 22 para ser acessada."
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "pegue o ip digitando: ifconfig \n e anote." 
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "selecione a máquina cliente:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'conect' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'linux')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "inicialmente, instale os programas:"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Debiam e derivados:\n 	sudo apt-get install openssh-server openssh-client"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "Fedora e derivados:\n 	yum install openssh-server"
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "a comunicação é feita digitando o seguinte comando:\n 	ssh user@ip\n\n exemplo:"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "bash$ ssh pi@192.168.1.10\n e digitar a senha da máquina." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'windows')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "inicialmente, instale um gerenciador de ssh, o mais utilizado é o pytt.exe:"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "acesse o link para baixar o programa:\nhttps://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html"
			sleep 6s
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @putt.png --caption "digite o endereço ip da máquina que você ira controlar, e em seguda a porta '22', clique em [Open]."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "ira abrir uma janela de console, digite a senha da máquina." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'android')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "inicialmente vamos começar instalando um app chamado: juiceSSH, ou outro de sua preferência clicando abaixo:" --reply_markup "$keyboard1" --parse_mode markdown
			sleep 7s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "após instalado, abra o app, e clique no seguinte local:"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @conec.png --caption "conexões"
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "depois em:"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @add.png --caption "+"
			sleep 3s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "e em seguida:"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @config.png --caption "vamos por cores."
			sleep 3s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "no campo contornado de vermelho na imagem acima, você pode colocar um apelido ou nome para identificar a maquina remota."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "no campo verde, você deve inserir apenas seu endereço IP anotado anteriormente."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "em seguida, clique no quadrado azul no canto superior direito para salvar as alterações."
			sleep 6s
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @list.png
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "agora, selhecione o item que você acabou de criar, ele irá entrar na tela para se comunicar via ssh, e ira pedir a senha, você escolhe se ela fica salva para acesso altomatico posterior, ou acesso manual." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'retornar ao menu')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "menu:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			esac
		) &
	done
done
