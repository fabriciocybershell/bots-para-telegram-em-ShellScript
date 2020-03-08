#! /bin/bash
#-*- coding: utf-8 -*-

source ShellBot.sh

bot_token='SUA_TOKEN'

ShellBot.init --token "$bot_token" --return map 

topo='<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<style>
	.button{
	border:solid 2px white;
	width: 12px;
	height: 12px;
	border-radius: 360px;
	float: left;
	margin-right: 7px;
	margin-top:-1px;
	}
	
</style>
'
superior='
<body style="background-color: #4b117f;">
<center>
<div style="/*display: flex;*/ background-color: #2b213a; border:solid 2px white; width: 90%; height: auto; border-radius: 9px; padding: 20px; box-shadow: 0px 0px 18px black; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: white; text-shadow: 0px 0px 10px #00b1ff; font-style: monospace; font-weight: 900; text-align:left;">
<div><p class="button"></p><p class="button"></p><p class="button"></p></div><br><br>
'
superior2='
<body style="background-color: white;">
<center>
<div style="/*display: flex;*/ background-color: #efefef; width: 90%; height: auto; border-radius: 5px; padding: 20px; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: black; font-style: normal; font-weight: 300; text-align:left;">
<div><p class="button" style="background-color: #ff5f56; border:solid 2px #ff5f56;"></p><p class="button" style="background-color: #ffbd2e; border:solid 2px #ffbd2e;"></p><p class="button" style="background-color: #27c93f; border:solid 2px #27c93f;"></p></div><br><br>
'
superior3='
<body style="background-color: #133e7c;">
<center>
<div style="/*display: flex;*/ background-color: #091833; width: 90%; height: auto; border-radius: 5px; padding: 20px; box-shadow: 0px 0px 18px black; margin-top:30px; /*margin-left: 10px;*/ margin-bottom: 30px; color: #0abdc6; font-style: normal; font-weight: 300; text-align:left;">
<div><p class="button"style="background-color: #ea00d9; border:solid 2px #ea00d9;"></p><p class="button" style="background-color: #711c91; border:solid 2px #711c91;"></p><p class="button" style="background-color: #0abdc6; border:solid 2px #0abdc6;"></p></div><br><br>
'
inferior='
</h3>
</div>
</div>
</center>
</body>
</html>
'
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

twopoints=':'

while :
do
ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30

for id in $(ShellBot.ListUpdates)  
		do
		(
			case ${message_text[$id]%%@*} in
			/start)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "hello ${message_from_first_name[$id]}, me mande seu código com /<tema>code <código>, e eu gero uma imagem com ele."
			;;
			/help)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o bot tem os seguintes temas: \n /cybercode <código> \n /whitecode <código> \n /cyber2code <código>"
			;;
			/cybercode*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'criando layout cyberpunk ...'
			code=$(echo "${message_text[$id]}" | cut -d " " -f2-)
			render=$(echo "${message_chat_id[$id]}" | tr -d "-")
			echo "$topo" > $render.html
			echo "$superior" >> $render.html
			printf "$code" | sed "s/$twopoints/$vermelho $twopoints<\/a>/" | sed "s/while/$brancolaranj while<\/a>/" | sed "s/echo/$brancolaranj echo<\/a>/" | sed "s/int /$brancolaranj int <\/a>/" | sed "s/true/$brancolaranj true<\/a>/" | sed "s/false/$brancolaranj false<\/a>/" | sed "s/True/$brancolaranj True<\/a>/" | sed "s/False/$brancolaranj False<\/a>/" | sed "s/float/$brancolaranj float<\/a>/"  | sed "s/php/$vermelho php<\/a>/" | sed "s/function/$brancolaranj function<\/a>/" | sed "s/printf/$brancolaranj printf<\/a>/"  | sed "s/\[/$roxo \[<\/a>/" | sed "s/\]/$roxo \]<\/a>/" | sed "s/(/$roxo (<\/a>/" | sed "s/)/$roxo )<\/a>/" | sed "s/\[\[/$roxo \[\[<\/a>/" | sed "s/\]\]/$roxo \]\]<\/a>/" | sed "s/))/$roxo ))<\/a>/" | sed "s/esac/$brancolaranj esac<\/a>/" | sed "s/done/$brancolaranj done<\/a>/" | sed "s/;;/$roxo ;;<\/a>/" | sed "s/{/$vermelho {<\/a>/" | sed "s/}/$vermelho }<\/a>/" | sed "s/fi /$brancolaranj fi<\/a>/" | sed "s/==/$brancolaranj ==<\/a>/"  | sed 's/^/<h3>/' | sed 's/$/<\/h3>/' >> $render.html
			echo "$inferior" >> $render.html
			wkhtmltoimage --quality 100 $render.html $render.jpg
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @$render.jpg
			rm -r $render.html
			rm -r $render.jpg
			;;
			/whitecode*)
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
