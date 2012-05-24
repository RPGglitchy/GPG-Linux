#!/bin/bash

echo '                            ____    ____              ____               ____  ____'		
echo '|\    /|    /\    |  |     |    |  |      \      / | |     \          / |     |    |'
echo '| \  / |   /  \   |  |     |____|  |____   \    /  | |____  \        /  |____ |____|'
echo '|  \/  |  /----\  |  |     |   \   |        \  /   | |       \  /\  /   |     |   \'
echo '|      | /      \ |  |____ |    \  |____     \/    | |____    \/  \/    |____ |    \'
echo ' '


while true; do
	read -p 'Voorzie een aanspreking: ' aanspreking
	read -p 'De voornaam van de gewenste ontvanger: ' voornaam
	read -p 'De naam van de gewenste ontvanger: ' naam
	read -p 'Het e-mail adress van de persoon die u wents te contacteren: ' email
	read -p 'Geef nu het pad op, waar het .tex bestand zich bevindt: ' pad
	
	echo 'Zijn de gegevens correct?'
	echo '========================='
	echo $aanspreking $naam $voornaam
	echo 'Het e-mail adres: ' $email
	echo 'Het pad naar het .tex bestand: ' $pad
	echo '========================='
	read -p '[J/N]' correct

	if [[ "$correct" == "J" ] -o [ "$correct" == "j" ]]
		then break;
	fi
done

echo 'Om fouten te vermijden wordt er een backup gemaakt van de huidige .tex file.'
cp "$pad/GPG.tex" "$pad/GPGbackup.tex"

sed -r "s/\rfoot{}/\rfoot{$naam $voornaam }/" "$pad/GPG.tex" > "$pad/GPG.txt" && mv "$pad/GPG.txt" "$pad/GPG.tex"

zip -r "$pad/KaripidisChari_$naam$voornaam.zip" $pad > "$pad/zip.txt"

read -p 'Er opent, bij het drukken op enter, een tekstverwerker om een bericht toe te voegen in uw mail.' pause
gedit "$pad/tempMail.txt"

read -p 'geef een onderwerp voor de mail: ' onderwerp
echo "De mail wordt vestuurd naar: $email."
mutt -s $onderwerp $email -a "$pad/KaripidisChari_$naam$voornaam.zip" < "$pad/tempMail.txt"
echo "De mail is succesvol verzonden naar $email."

rm "$pad/zip.txt" "$pad/KaripidisChari_$naam$voornaam.zip" "$pad/tempMail.txt"

read -p 'Wenst u het backup bestand terug te plaatsen?' backup

if [[ "$backup" == "J" ] -o [ "$backup" == "j" ]]
	then mv $pad/GPGbackup.tex $pad/GPG.tex
fi


