-- data/globalevents/scripts/announcements.lua

-- Uma tabela contendo mensagens de an�ncio em ingl�s e portugu�s.
-- Para adicionar uma nova mensagem, basta copiar a estrutura { en = "...", pt = "..." }
-- e adicionar ao final da tabela.
local messages = {
	{
		en = "Found a bug or want to connect with more players? Join our Discord server!",
		pt = "Encontrou algum bug ou quer ter contato com mais jogadores? Participe do nosso servidor no Discord!"
	},
	{
		en = "Become a supporter and help the server grow: make a donation and get access to our store content!",
		pt = "Seja um apoiador e ajude o servidor a crescer: fa�a uma doa��o e ganhe acesso ao conte�do da nossa store!"
	},
	{
		en = "Don't know the server commands?\nUse the !commands command and have fun! :)",
		pt = "N�o conhece os comandos do servidor?\nUtilize o comando !commands e seja feliz. :)"
	},
	{
		en = "Difficulties leveling up or can't drop that item? Be a VIP and get exclusive advantages! :)",
		pt = "Dificuldades no level up ou n�o consegue dropar aquele item? Seja VIP e ganhe vantagens exclusivas! :)"
	},
	{
		en = "Donated via PayPal and didn't receive your coins? Create a ticket on our website. Don't forget to include the transaction details.",
		pt = "Doou via PayPal e suas moedas n�o ca�ram? Crie um ticket em nosso site. N�o se esque�a de incluir os dados da sua doa��o."
	},
	{
		en = "Attention: AVOID using passwords from other servers here at Shanera-Retro. Players are being hacked for this reason, and if the number of cases is too high, it will be impossible to help everyone.",
		pt = "Aten��o: EVITEM usar senhas de outros servidores aqui no Shanera-Retro. Jogadores est�o sendo hackeados por este motivo e, se o n�mero de casos for muito alto, ser� imposs�vel ajudar a todos."
	},
	{
		en = "Follow us on social media for news and updates! Find the links on our website.",
		pt = "Siga-nos nas redes sociais para not�cias e novidades! Encontre os links em nosso site."
	},
	{
		en = "New events and quests are coming! Stay tuned for the latest updates on our website.",
		pt = "Novos eventos e quests est�o chegando! Fique de olho nas �ltimas atualiza��es em nosso site."
	}
}

-- Vari�vel para controlar qual idioma ser� transmitido. 1 = Portugu�s, 2 = Ingl�s.
local currentLanguage = 1

function onThink(interval)
	-- Escolhe uma mensagem aleat�ria da tabela.
	local msg = messages[math.random(#messages)]

	-- Alterna entre os idiomas a cada execu��o.
	currentLanguage = currentLanguage % 2 + 1
	
	-- Transmite a mensagem correspondente ao idioma atual.
	if currentLanguage == 1 then
		Game.broadcastMessage(msg.pt, MESSAGE_EVENT_ADVANCE)
	else
		Game.broadcastMessage(msg.en, MESSAGE_EVENT_ADVANCE)
	end
	
	return true
end
