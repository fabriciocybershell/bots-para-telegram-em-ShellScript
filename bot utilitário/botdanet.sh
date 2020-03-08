#! /bin/bash
#-*- coding: utf-8 -*-

#dependências qrencode, curl, lynx, html-xml-utils, jq, mbrola ,wkhtmltopdf

source ShellBot.sh

bot_token='SUA_TOKEN'

ShellBot.init --token "$bot_token"  --return map #--monitor #--flush --log_file "/tmp/${0##*/}.log"
ShellBot.username

btn_ajuda='["ajuda"]'
btn_tuto='["tutorial"]'

while :
do

ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30

	for id in $(ShellBot.ListUpdates)
	do
	(

		case ${message_text[$id]%%@*} in
			/start)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "olá ${message_from_first_name[$id]}, eu sou o BotdaNet, e minha função é realizar funções utilitárias." --parse_mode markdown 
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "clique no botão abaixo ou digite /help para poder receber ajuda sobre o meu funcionamento." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_ajuda' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'/help' | 'ajuda')
			catcha=$(cat catcha.txt)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$catcha"
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
			--text "gostaria de um tutorial de como usar ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'btn_tuto' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			/significado*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "realizando busca ..." --parse_mode markdown
			pesqu=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2 | tr "[A-Z]" "[a-z]")
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			a=$(curl https://www.dicio.com.br/$pesqu/ | hxnormalize -x)
			filth=$(echo "$a" | hxselect -i "h2.tit-significado" | lynx -stdin -dump)
			filth+="\n"
			filth+=$(echo "$a" | hxselect -i "p.significado.textonovo" | lynx -stdin -dump)
			env=$(echo "$filth")
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env" --parse_mode markdown
			;;
			/qr*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'gerando qr ...'
			text=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2-)
			qrencode -s 10 -m 2 -o ${message_chat_id[$id]}.png "$text"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @${message_chat_id[$id]}.png --caption "$text"
			text=""
			rm -f ${message_chat_id[$id]}.png 
			;;
			/tinder*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'buscando no tinder ...'
			filtr=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2 | tr "í" "i")
			scrap=$(echo "https://www.gotinder.com/@$filtr" | wget -O- -i- | hxnormalize -x)
			fot=$(echo "$scrap" | hxselect -i "img#user-photo" | lynx -stdin -dump | tr -d " " | tr "&" "/" | tr -d "]" | sed "s/x2F;/#/g" |  tr -d "#"  |  tr -d "[" | tr -d "\n" )
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			info=$(echo "identificador: @$filtr \nnome: ")
			info+=$(echo "$scrap" | hxselect -i "span#name" | lynx -stdin -dump)
			info+=$(echo "\nidade:")
			info+=$(echo "$scrap" | hxselect -i "span#age" | lynx -stdin -dump | tr "," " ")
			info+=$(echo "\nbio: ")
			info+=$(echo "$scrap" | hxselect -i "span#teaser" | lynx -stdin -dump)
			info+=$(echo ".")
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo "$fot" --caption "$info"
			filtr=""
			scrap=""
			fot=""
			info=""
			;;
			/pdf*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "convertendo site para pdf ..."
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "algumas páginas podem ficar desfiguradas, devido a compatibilidade do site, realizando renderização ..."
			filtr=$(echo "${message_text[$id]%%@*}" | cut -d " " -f2-)
			wkhtmltopdf -s A4 $filtr ${message_chat_id[$id]}.pdf
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_document
			documento+=$(echo "${message_chat_id[$id]}.pdf")
			ShellBot.sendDocument --chat_id ${message_chat_id[$id]} --document @$documento
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "se por algum motivo o arquivo não foi enviado, significa que deu erro de decodificação pelo formato do site."
			rm -r ${message_chat_id[$id]}.pdf
			;;
			#/scope*)
			#ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "recurso quebrado no momento."
			#ShellBot.sendVideo --chat_id ${message_chat_id[$id]} --video @1.mp4
			#;;
			/voz*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'gravando audio ...'
			filtr=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2-)
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action record_audio
			espeak-ng -v mb-br4 "$filtr" -s 125 -p 40 -k 170 -a 120 -w ${message_chat_id[$id]}.mp3
			#lianetts 0.6 "$filtr" -g ${message_chat_id[$id]}.wav
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
			ShellBot.sendVoice --chat_id ${message_chat_id[$id]} --voice @${message_chat_id[$id]}.mp3
			#ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
			#ShellBot.sendVoice --chat_id ${message_chat_id[$id]} --voice @${message_chat_id[$id]}.wav
			rm -r ${message_chat_id[$id]}.mp3
			rm -r ${message_chat_id[$id]}.wav
			;;
			/cnpj*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'buscando dados do cnpj ...'
			filtr=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2- | tr -d "-" | tr -d "." | tr -d "[a-z A-Z]")
			tratar=$(echo "https://www.receitaws.com.br/v1/cnpj/$filtr" | wget -O- -i- | tr -d '{}"][' | tr "," "\n")
			montt=$(echo "$tratar" | grep "nome")
			montt+="\n"
			montt+=$(echo "$tratar" | grep "uf")
			montt+="\n"
			montt+=$(echo "$tratar" | grep "fone")
			montt+="\n"
			montt+=$(echo "$tratar" | grep "mail")
			montt+="\n"
			montt+=$(echo "$tratar" | grep "atividades" | cut -d ":" -f1,3- | sed '/^text/d')
			montt+="\n"
			montt+=$(echo "$tratar" | grep "text" | cut -d ":" -f2)
			
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$montt"
			filtr=""
			tratar=""
			;;
			/cep*)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'buscando dados do cep ...'
			filtr=$(echo "${message_text[$id]%%@*}" | tr -d "/" | cut -d " " -f2- | tr -d "-" | tr -d "." | tr -d "[a-z A-Z]")
			tratar=$(echo "https://viacep.com.br/ws/$filtr/json/" | wget -O- -i- | tr -d '{}",')
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$tratar"
			filtr=""
			tratar=""
			;;
			'tutorial')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'iniciando roteiro do tutorial ...'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "pois bem ${message_from_first_name[$id]}, como dito antes, me chamo botdanet."
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "nem todos os exemplos serão abordados, apenas os iniciais."
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'bem, iremos começar gerando um QRcode, irei usar como exemplo o seu nome de perfil.'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'para gerar o QRcode, basta enviar um /qr "texto", como o exemplo abaixo: '
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "/qr ${message_from_first_name[$id]} ${message_from_last_name[$id]}"
			sleep 3s
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			qrencode -s 10 -m 2 -o qr.png "${message_from_first_name[$id]} ${message_from_last_name[$id]}"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo @qr.png --caption "${message_from_first_name[$id]} ${message_from_last_name[$id]}"
			rm -f qr.png
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "agora, vamos com um pouco mais de calma, o recurso que ira ser usado será pesquisar alguém no tinder."
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 6s
			nome=$[$RANDOM%12]
			case $nome in 
				1)
			tinder='daniela'
			;;
				2)
			tinder='joao'
			;;
				3)
			tinder='eduardo'
			;;
				4)
			tinder='gustavo'
			;;
				5)
			tinder='alexandre'
			;;
				6)
			tinder='leticia'
			;;
				7)
			tinder='fabricio'
			;;
				8)
			tinder='rogerio'
			;;
				9)
			tinder='monica'
			;;
				10)
			tinder='daniel'
			;;
				11)
			tinder='marcia'
			;;
				12)
			tinder='brenda'
			;;
		esac

			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "nome escolhido: $tinder."
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'buscando no tinder ...'
			scrap=$(echo "https://www.gotinder.com/@$tinder" | wget -O- -i- | hxnormalize -x)
			fot=$(echo "$scrap" | hxselect -i "img#user-photo" | lynx -stdin -dump | tr -d " " | tr "&" "/" | tr -d "]" | sed "s/x2F;/#/g" |  tr -d "#"  |  tr -d "[" | tr -d "\n" )
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_photo
			info=$(echo "identificador: @$tinder \nnome: ")
			info+=$(echo "$scrap" | hxselect -i "span#name" | lynx -stdin -dump)
			info+=$(echo "\nidade:")
			info+=$(echo "$scrap" | hxselect -i "span#age" | lynx -stdin -dump | tr "," " ")
			info+=$(echo "\nbio: ")
			info+=$(echo "$scrap" | hxselect -i "span#teaser" | lynx -stdin -dump)
			info+=$(echo ".")
			ShellBot.sendPhoto --chat_id ${message_chat_id[$id]} --photo "$fot" --caption "$info"
			filtr=""
			scrap=""
			fot=""
			info=""
			tinder=""
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} --text 'falta apenas mais dois recursos, segure as pontas !!!'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage	--chat_id ${message_from_id[$id]} --text 'aproveitando o embalo, vamos testar o proximo recurso, /voz, que será o ultimo explicado.'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'você pode enviar um /voz <texto> para gerar um arquivo de audio.'
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'exemplo:'
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "/voz não há ninguém tão perfeito quanto ${message_from_first_name[$id]} ${message_from_last_name[$id]}"
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'gravando audio ...'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action record_audio
			espeak-ng -v mb-br4 "não há ninguém tão perfeito quanto ${message_from_first_name[$id]} ${message_from_last_name[$id]}" -s 125 -p 40 -k 170 -a 120 -w audio.mp3
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
			ShellBot.sendVoice --chat_id ${message_chat_id[$id]} --voice @audio.mp3 
			rm -r audio.mp3	
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'claro que temos outras vozes, porém ainda não tão boas kkk:'
			lianetts -g audio.wav "não há ninguém tão perfeito quanto ${message_from_first_name[$id]} ${message_from_last_name[$id]}"
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
			ShellBot.sendVoice --chat_id ${message_chat_id[$id]} --voice @audio.wav 
			rm -r audio.wav
			espeak-ng "não há ninguém tao perfeito quanto ${message_from_first_name[$id]} ${message_from_last_name[$id]}" -w audio.mp3
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_audio
			ShellBot.sendVoice --chat_id ${message_chat_id[$id]} --voice @audio.mp3 
			rm -r audio.mp3
			sleep 6s
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'ja deu para notar rsrs, pois bem, es o último recurso, o "dicionário"'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'basta você digitar /significado <palavra>, exemplo:'
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			sleep 3s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text '/significado amizade'
			sleep 2s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "realizando busca ..." --parse_mode markdown
			a=$(curl https://www.dicio.com.br/amizade/ | hxnormalize -x)
			ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
			filth=$(echo "$a" | hxselect -i "h2.tit-significado" | lynx -stdin -dump)
			filth+="\n"
			filth+=$(echo "$a" | hxselect -i "p.significado.textonovo" | lynx -stdin -dump)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$filth" --parse_mode markdown
			sleep 5s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text 'fim do tutorial interativo, boa sorte.'
			sleep 3s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text '/help'	
			catcha=$(cat catcha.txt)
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$catcha"
			;;
		esac

		[[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1
		[[ $download_file -eq 1 ]] && {
		file_id=($file_id)
		ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o processo pode demorar um pouco, a depender do tamanho do arquivo."
		ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "baixando ..."
		ShellBot.getFile --file_id "$file_id"
		ShellBot.downloadFile --file_path ${return[file_path]} --dir $HOME/ShellBot
		documento1=$(echo "${return[file_path]}" | cut -d "." -f1)
		documento2=$(echo "${return[file_path]}")
		lowriter --headless --convert-to pdf ${return[file_path]}
		ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action upload_document
		rm -rf $documento2
		documento+=$(echo "$documento1.pdf")
		ShellBot.sendDocument --chat_id ${message_chat_id[$id]} --document @$documento
		ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "convertido com exito."
		rm -rf $documento
		download_file=0
		}
	) & 
	done
done
