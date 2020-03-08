#! /bin/bash

source ShellBot.sh

bot_token='SUA_TOKEN'

ShellBot.init --token "$bot_token" --return map 
inicio='
[ "começar" ],
'

primeira='
[ "tomar café e ir para a escola." ],
[ "tomar café e jogar video game." ]
'

cozinha='
[ "levar lanche" ],
[ "pegar 4,40 R$ para comer na escola" ]
'

escola='
[ "pegar vam e pagar 4,40R$" ],
[ "andar apé por 0,7KM" ]
'

praca='
[ "escutar música até o sinal bater" ],
[ "checar agenda" ]
'

casa='
[ "entrar em casa" , "ir para casa do amigo"],
'

#ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text ""

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
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "olá ${message_from_first_name[$id]}, eu sou um bot de estoria, e isto é uma estoria interativa, onde suas escolhas fazem a narrativa."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "eu sou operado por opções, você faz suas escolhas, e a estoria vai mudando conforme sua escolha, quando você morrer ou terminar um caminho, o menu de inicio será exibido para você jogar novamente."  --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'começar')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "a estoria se chama: Coragem para VIVER"
			sleep 2s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você acaba de acordar às 7:20 da manhã, qual das opções você decide fazer ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'primeira' --one_time_keyboard 'true')" --parse_mode markdown			
			;;
			'tomar café e ir para a escola')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você passa pela cozinha, prepara um café, e vai se arrumar \n e passa pela cozinha novamente."
			sleep 6s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você se depara com seu lanche preparado a alguns dias atrás,  e a aparência parece meio estranha, mas ainda esta bom."
			sleep 4s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "o que você faz:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'cozinha' --one_time_keyboard 'true')" --parse_mode markdown			
			;;
			'levar lanche')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você passou fome. \n você acabou de chegar a escola, e o horário de entrada ainda não chegou, tem uma praça em frente, o que você deseja fazer para passar o tempo ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'praca' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'pegar 4,40R$ para comer na escola')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você sai de casa, o que você decide fazer para chegar a escola ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'escola' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'pegar vam e pagar 4,40R$')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você acabou de chegar a escola, e o horário de entrada ainda não chegou, tem uma praça em frente, o que você deseja fazer para passar o tempo ?" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'praca' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'andar apé por 0,7KM')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "no meio do caminho você foi asaltado e levou um tiro!, fim." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button '/start' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'escutar música até o sinal bater')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "prova surpresa !, você se arrepende e retorna chorando de vouta pra casa."
			sleep 3s
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você chega em casa e se aproxima da porta, você escuta seus pais brigando dentro de casa.\n o que você faz agora :" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'casa' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'checar agenda')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "agenda: DIA DE PROVAAA. \n  você revisa algumas questõese na hora da prova, consegue tirar um 10."
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "você chega em casa e se aproxima da porta, você escuta seus pais brigando dentro de casa.\n o que você faz agora :" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'casa' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'entrar em casa')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "agora, selhecione o item que você acabou de criar, ele irá entrar na tela para se comunicar via ssh, e ira pedir a senha, você escolhe se ela fica salva para acesso altomatico posterior, ou acesso manual." --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'ir para casa do amigo')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "menu:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'retornar ao menu')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "menu:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'retornar ao menu')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "menu:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			'retornar ao menu')
			ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "menu:" --reply_markup "$(ShellBot.ReplyKeyboardMarkup --button 'inicio' --one_time_keyboard 'true')" --parse_mode markdown
			;;
			esac
		) &
	done
done
