#! /bin/bash
#-*- coding: utf-8 -*-

source ShellBot.sh

bot_token='SEU_TOKEN'

ShellBot.init --token "$bot_token" --return map 

while :
do

ShellBot.getUpdates --limit 500 --offset $(ShellBot.OffsetNext) --timeout 30

escrever(){
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
}

enviar() {
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --t "$mensagem" $1
}

responder(){
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --t "$mensagem" --reply_to_message_id ${message_message_id[$id]}
}

editar() {
	ShellBot.editMessageText --chat_id ${message_chat_id[$id]} --message_id ${message_message_id[$id]} --t "$mensagem"
}

foto() {
	ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @$1
}

enviarfoto() {
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
}

enviarvideo() {
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_video
	ShellBot.sendVideo --chat_id ${message_chat_id[$id]} --video @"$video"	
}

respondervideo() {
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_video
	ShellBot.sendVideo --chat_id ${message_chat_id[$id]} --video @"$video"	--reply_to_message_id ${message_message_id[$id]}
}

sendaudio(){ 
	let valor=$2/3;

	repetir=0
	while [  $repetir -lt $valor ]; do
    	let repetir=repetir+1;
   		ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action record_audio
   		sleep 3s
	done
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
	ShellBot.sendAudio --chat_id ${message_chat_id[$id]} --audio @$1 $3
}

sticker(){
	ShellBot.sendSticker --chat_id ${message_chat_id[$id]} --sticker @$1 $2
}

banir(){
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]}
}

desbanir(){
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]}
}

adeus(){
	ShellBot.leaveChat --chat_id ${message_chat_id[$id]}
}

scope(){
	let valor=$2/3;

	repetir=0
	while [  $repetir -lt $valor ]; do
    	let repetir=repetir+1;
   		ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action record_video_note
	sleep 3s
	done
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_video_note
	ShellBot.sendVideoNote --chat_id ${message_chat_id[$id]} --video_note @$1 $3
}

enviandodocumento(){
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_document
}

documento(){
	ShellBot.sendDocument --chat_id ${message_chat_id[$id]} --document @$1 
}

resp="--reply_to_message_id ${message_message_id[$id]}"

edit="--parse_mode markdown"

somardb (){
        dado=$1
        dados=$(cat mikosuma.db)
        echo "$dados" | sed "/$dado/d" > mikosuma.db
        soma=$(echo "$dados" | grep "$dado" | cut -d: -f2)
        soma=$(($soma+1))
        echo "$dado:$soma" >> mikosuma.db
}

consultadb (){
	declare -g valor
        dado=$1
        dados=$(cat mikosuma.db)
        valor=$(echo "$dados" | sed -n "/$dado/p" | cut -d: -f2)
}

alterardb (){
        dado=$1
        valor=$2
        dados=$(cat mikosuma.db)
        echo "$dados" | sed "/$dado/d" > mikosuma.db
        echo "$dado:$valor" >> mikosuma.db
}

for i in $(ShellBot.ListUpdates)
do(

	case ${message_text[$id]%%@*} in
		/start)
			mensagem="me envie uma foto qualquer em forma de arquivo ou imagem, enviando em forma de arquivo você obtem maior qualidade no efeito."
			enviar
			mensagem="po favor, não abuse de arquivos pesados, o processamento poderá atrasar, assim como o upload."
		;;
	esac
	[[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1
	[[ ${message_photo_file_id[$id]} ]] && file_id=${message_photo_file_id[$id]} && download_file=1
	[[ $download_file -eq 1 ]] && {
		file_id=$(echo $file_id | cut -d "|" -f1)
		mensagem="baixando..."
		enviar
		ShellBot.getFile --file_id $file_id
		ShellBot.downloadFile --file_path ${return[file_path]} --dir $HOME/ShellBot
		arquivo=$(echo ${return[file_path]} | cut -d "/" -f5)
		mensagem="processando arquivo: $arquivo"
		enviar
		#resolucao="2560x1440"
		resolucao="3840x2160"
		command="convert $arquivo -background black "
		command+="\( -clone 0 -blur 0x9 -background white -resize $resolucao^ \) "
		command+="\( -clone 0 -background white -resize $resolucao \) "
		command+="-delete 0 -gravity center -compose over -composite -extent $resolucao $arquivo"
		eval $command
		enviarfoto
		foto $arquivo
		doc=""
		enviandodocumento
		documento $arquivo
		rm -f $arquivo
	}

	)&
	done

done
