#! /bin/bash
#-*- coding: utf-8 -*-

source ShellBot.sh #importar a API do ShellBot.sh

bot_token='SUA_TOKEN' #aqui você insere sua token do botfather do telegram, para obter sua token, pesquise por @BotFather

ShellBot.init --token "$bot_token" --return map # aqui ele loga nos servidores do telegram com sua token, sem modo de registro de log "--monitor"

topo='<!DOCTYPE html>     # variável carregada com elementos html e css para a criação da página,
<html>                    # aqui estão incluidos o topo de uma pagina simples em html,que seria uma
<head>					  # parte imutável do documento ja pré definida na hora da contrução do arquivo
<meta charset="utf-8">
</head>
<style>				/* estilo de como ficará a página em si, configurando o tamanho e estilo padrão da janela, para que possa ter seu estilo de cores alterados de acordo com a montagem do bot, neste caso, ele ira especificar a configuração base da janela que será formada.*/
	.button{ /* define uma variável 'class' para a configuração dos botões da janela*/ 
	border:solid 2px white; /* dita como será o contorno dos botões da janela*/
	width: 12px; /* tamanho vertical*/
	height: 12px; /* tamanho horizontal*/
	border-radius: 360px; /* circular*/
	float: left; /* posicionar a esquerda do anterior*/
	margin-right: 7px; /* distância da lateral */
	margin-top:-1px; /* distância do topo */
	}
	
</style>
'
superior='
<body style="background-color: #4b117f;"> <!-- define a cor de fundo da página para roxo -->
<center> <!-- posição central da vertical -->
<div style="/*display: flex;*/ background-color: #2b213a; border:solid 2px white; width: 90%; height: auto; border-radius: 9px; padding: 20px; box-shadow: 0px 0px 18px black; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: white; text-shadow: 0px 0px 10px #00b1ff; font-style: monospace; font-weight: 900; text-align:left;"> <!-- define os parâmetros de cor da janela, texto padrão e estilo de fonte -->
<div><p class="button"></p><p class="button"></p><p class="button"></p></div><br><br> <!-- posiciona os três botões da janela -->
'
superior2='
<body style="background-color: white;"> <!-- define a cor de fundo da página para branco -->
<center> <!-- posição central da vertical -->
<div style="/*display: flex;*/ background-color: #efefef; width: 90%; height: auto; border-radius: 5px; padding: 20px; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: black; font-style: normal; font-weight: 300; text-align:left;"> <!-- define os parâmetros de cor da janela, texto padrão e estilo de fonte -->
<div><p class="button" style="background-color: #ff5f56; border:solid 2px #ff5f56;"></p><p class="button" style="background-color: #ffbd2e; border:solid 2px #ffbd2e;"></p><p class="button" style="background-color: #27c93f; border:solid 2px #27c93f;"></p></div><br><br> <!-- posiciona os três botões da janela -->
'
superior3='
<body style="background-color: #133e7c;"> <!-- define a cor de fundo da página para azul escuro -->
<center> <!-- posição central da vertical -->
<div style="/*display: flex;*/ background-color: #091833; width: 90%; height: auto; border-radius: 5px; padding: 20px; box-shadow: 0px 0px 18px black; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: #0abdc6; font-style: normal; font-weight: 300; text-align:left;"> <!-- define os parâmetros de cor da janela, texto padrão e estilo de fonte -->
<div><p class="button"style="background-color: #ea00d9; border:solid 2px #ea00d9;"></p><p class="button" style="background-color: #711c91; border:solid 2px #711c91;"></p><p class="button" style="background-color: #0abdc6; border:solid 2px #0abdc6;"></p></div><br><br> <!-- posiciona os três botões da janela -->
'
inferior='  <!-- finaliza os elementos da página -->
</h3>
</div>
</div>
</center>
</body>
</html>
'
#abaixo é definido os parâmetros de coloração de cada palavra/função/caracter de programação que for filtrada pelo SED, que serão adicionado ao redor de cada uma encontrada.
roxo='<a style="color: #ff0096; text-shadow: 0px 0px 0px white; font-style: monospace; font-weight: 900;">' 
brancolaranj='<a style="color: orange; text-shadow: 0px 0px 10px orange; font-style: monospace; font-weight: 900;">'
vermelho='<a style="color: red; text-shadow: 0px 0px 10px red; font-style: monospace; font-weight: 900;">'
branco='<a style="color: white; font-style: monospace; font-weight: 900;">'

roxo2='<a style="color: #ff0096; font-style: normal; font-weight: 300;">'
vermelho2='<a style="color: #ff0000; font-style: normal; font-weight: 300;">'
branco2='<a style="color: #545454; font-style: normal; font-weight: 300;">'
azul2='<a style="color: #00a3eb; font-style: normal; font-weight: 300;">'

roxoescuro='<a style="color: #711c91; font-style: normal; font-weight: 300;">'
rosa='<a style="color: #ea00d9; font-style: normal; font-weight: 300;">'
azulclaro='<a style="color: #0abdc6; font-style: normal; font-weight: 300;">'
azulescuro='<a style="color: #133e7c; font-style: normal; font-weight: 300;">'
azulnight='<a style="color: #091833; font-style: normal; font-weight: 300;">'

twopoints=':' #define um caracter conflitante com o SED em uma variável, para que ele possa ser usado normalmente, porém outros demais não são aceitos até o momento.

while : #em quanto ligado o loop será infinito
do
ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30 #obtem as atualizações e seta o limite de pessoas ao mesmo tempo, e o limite de tempo de operação do bot

for id in $(ShellBot.ListUpdates) #roda cada elemento da lista de atualizações uma a uma para ser adicionadas separadamente.   
		do
		(
			case ${message_text[$id]%%@*} in #checa se a variavel da lista existe, se existir, começa uma execução do script
			/start) #menssagem de boas vindas
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "hello ${message_from_first_name[$id]}, me mande seu código com /<tema>code <código>, e eu gero uma imagem com ele." #envia a menssagem para o ID especificado "universal" para o usuário que requisitou a ação.
			;;
			/help) #exibe o menu de ajuda
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o bot tem os seguintes temas: \n /cybercode <código> \n /whitecode <código> \n /cyber2code <código>" # exibe o menu de ajuda com as opções do bot
			;;
			/cybercode*) # cria o layout da página com o tema cyberpunk utilizando as variáveis setadas lá no topo do script, com os elementos html e css
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'criando layout cyberpunk ...' #envia menssagem de confirmação de receibimento do comando
			code=$(echo "${message_text[$id]}" | cut -d " " -f2-) # separa o comando da menssagem do usuário para ser trabalhada
			render=$(echo "${message_chat_id[$id]}" | tr -d "-") # ele elimina o caracter '-' quando ele esta em grupos, pois em grupos os bot recebem como argumento uma -100+ID
			echo "$topo" > $render.html # grava a informação de criação do topo da página
			echo "$superior" >> $render.html # grava os dados restantes do layout com as cores do tema desejado no fundo e na janela.
			# na liinha abaixo contém vários argumentos de busca e substituição com sed, que pode ser muito melhorada, onde a cada palavra chave encontrada, ele ira colorir de acordo, inserindo 
			printf "$code" | sed "s/$twopoints/$vermelho $twopoints<\/a>/" | sed "s/while/$brancolaranj while<\/a>/" | sed "s/echo/$brancolaranj echo<\/a>/" | sed "s/int /$brancolaranj int <\/a>/" | sed "s/true/$brancolaranj true<\/a>/" | sed "s/false/$brancolaranj false<\/a>/" | sed "s/True/$brancolaranj True<\/a>/" | sed "s/False/$brancolaranj False<\/a>/" | sed "s/float/$brancolaranj float<\/a>/"  | sed "s/php/$vermelho php<\/a>/" | sed "s/function/$brancolaranj function<\/a>/" | sed "s/printf/$brancolaranj printf<\/a>/"  | sed "s/\[/$roxo \[<\/a>/" | sed "s/\]/$roxo \]<\/a>/" | sed "s/(/$roxo (<\/a>/" | sed "s/)/$roxo )<\/a>/" | sed "s/\[\[/$roxo \[\[<\/a>/" | sed "s/\]\]/$roxo \]\]<\/a>/" | sed "s/))/$roxo ))<\/a>/" | sed "s/esac/$brancolaranj esac<\/a>/" | sed "s/done/$brancolaranj done<\/a>/" | sed "s/;;/$roxo ;;<\/a>/" | sed "s/{/$vermelho {<\/a>/" | sed "s/}/$vermelho }<\/a>/" | sed "s/fi /$brancolaranj fi<\/a>/" | sed "s/==/$brancolaranj ==<\/a>/"  | sed 's/^/<h3>/' | sed 's/$/<\/h3>/' >> $render.html
			echo "$inferior" >> $render.html # grava os ultimos códigos de final do html
			wkhtmltoimage --quality 100 $render.html $render.jpg #pega o arquivo gerado e salvo com sua ID e renderiza uma imagem
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo # sinaliza o envio da imagem
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @$render.jpg #envia a imagem criada
			rm -r $render.html #deleta o arquivo html criado
			rm -r $render.jpg #deleta a imagem criada
			;; # fim do código
			/whitecode*) #a partir daqui o restante é a mesma coisa, mesmos comandos, o que muda são as variáveis iniciais de gravar conteudo, que colocam outras que contenham o elemento daquele tema, que seria as cores.
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'criando layout branco ...'
			code=$(echo "${message_text[$id]}" | cut -d " " -f2-)
			render=$(echo "${message_chat_id[$id]}" | tr -d "-")
			echo "$topo" > $render.html
			echo "$superior2" >> $render.html
			printf "$code" | sed "s/$twopoints/$vermelho2 $twopoints<\/a>/" | sed "s/while/$vermelho2 while<\/a>/" | sed "s/echo/$vermelho2 echo<\/a>/" | sed "s/int /$vermelho2 int <\/a>/" | sed "s/true/$vermelho2 true<\/a>/" | sed "s/false/$vermelho2 false<\/a>/" | sed "s/True/$vermelho2 True<\/a>/" | sed "s/False/$vermelho2 False<\/a>/" | sed "s/float/$vermelho2 float<\/a>/" | sed "s/php/$vermelho2 php<\/a>/" | sed "s/function/$vermelho2 function<\/a>/" | sed "s/printf/$vermelho2 printf<\/a>/" | sed "s/\[/$roxo2 \[<\/a>/" | sed "s/\]/$roxo2 \]<\/a>/" | sed "s/(/$roxo2 (<\/a>/" | sed "s/)/$roxo2 )<\/a>/" | sed "s/\[\[/$roxo2 \[\[<\/a>/" | sed "s/\]\]/$roxo2 \]\]<\/a>/" | sed "s/))/$roxo2 ))<\/a>/" | sed "s/esac/$vermelho2 esac<\/a>/" | sed "s/done/$vermelho2 done<\/a>/" | sed "s/;;/$roxo2 ;;<\/a>/" | sed "s/{/$vermelho2 {<\/a>/" | sed "s/}/$vermelho2 }<\/a>/" | sed "s/fi /$vermelho2 fi<\/a>/" | sed "s/if/$vermelho2 if<\/a>/" | sed "s/==/$vermelho2 ==<\/a>/" | sed 's/^/<h3>/' | sed 's/$/<\/h3>/' >> $render.html
			echo "$inferior" >> $render.html
			wkhtmltoimage --quality 100 $render.html $render.jpg
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @$render.jpg
			rm -r $render.html
			rm -r $render.jpg
			;;
			/cyber2code*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'criando layout cyberpunk 2 ...'
			code=$(echo "${message_text[$id]}" | cut -d " " -f2-)
			render=$(echo "${message_chat_id[$id]}" | tr -d "-")
			echo "$topo" > $render.html
			echo "$superior3" >> $render.html
			printf "$code" | sed "s/$twopoints/$azulescuro $twopoints<\/a>/" | sed "s/while/$rosa while<\/a>/" | sed "s/echo/$rosa echo<\/a>/" | sed "s/int /$rosa int <\/a>/" | sed "s/true/$rosa true<\/a>/" | sed "s/false/$rosa false<\/a>/" | sed "s/True/$rosa True<\/a>/" | sed "s/False/$rosa False<\/a>/" | sed "s/float/$rosa float<\/a>/"  | sed "s/php/$azulescuro php<\/a>/" | sed "s/function/$rosa function<\/a>/" | sed "s/printf/$rosa printf<\/a>/"  | sed "s/\[/$azulescuro \[<\/a>/" | sed "s/\]/$azulescuro \]<\/a>/" | sed "s/(/$azulescuro (<\/a>/" | sed "s/)/$azulescuro )<\/a>/" | sed "s/\[\[/$azulescuro \[\[<\/a>/" | sed "s/\]\]/$azulescuro \]\]<\/a>/" | sed "s/))/$azulescuro ))<\/a>/" | sed "s/esac/$rosa esac<\/a>/" | sed "s/done/$rosa done<\/a>/" | sed "s/;;/$azulescuro ;;<\/a>/" | sed "s/{/$azulescuro {<\/a>/" | sed "s/}/$azulescuro }<\/a>/" | sed "s/fi /$rosa fi<\/a>/" | sed "s/==/$rosa ==<\/a>/"  | sed 's/^/<h3>/' | sed 's/$/<\/h3>/' >> $render.html
			echo "$inferior" >> $render.html
			wkhtmltoimage --quality 100 $render.html $render.jpg
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @$render.jpg
			rm -r $render.html
			rm -r $render.jpg
			;;
			esac
		) &
	done
done
