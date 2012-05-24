#!/bin/bash

echo '                            ____    ___              ___               ___  ____'		
echo '|\    /|    /\    |  |     |    |  |     \      / | |    \          / |    |    |'
echo '| \  / |   /  \   |  |     |____|  |___   \    /  | |___  \        /  |___ |____|'
echo '|  \/  |  /----\  |  |     |   \   |       \  /   | |      \  /\  /   |    |   \'
echo '|      | /      \ |  |____ |    \  |___     \/    | |___    \/  \/    |___ |    \'
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
	read -p '[j/n]	' correct

	if [[ "$correct" == "j" ]]
		then break;
	fi
done

echo 'Om fouten te vermijden wordt er een backup gemaakt van de huidige .tex file.'
cp "$pad/GPG.tex" "$pad/GPGbackup.tex"

sed -r "s/xname/$naam $voornaam/" "$pad/GPG.tex" > "$pad/GPG.txt" && mv "$pad/GPG.txt" "$pad/GPG.tex"

cd $pad
pdflatex GPG.tex
cd ~

zip -r "$pad/KaripidisChari_$naam$voornaam.zip" $pad > "$pad/zip.txt"

read -p 'Er opent, bij het drukken op enter, een tekstverwerker om een bericht toe te voegen in uw mail.' pause
gedit "$pad/tempMail.txt"

read -p 'geef een onderwerp voor de mail: ' onderwerp
echo "De mail wordt vestuurd naar: $email."
mutt -s $onderwerp $email -a "$pad/KaripidisChari_$naam$voornaam.zip" < "$pad/tempMail.txt"
echo "De mail is succesvol verzonden naar $email."

rm "$pad/zip.txt" "$pad/KaripidisChari_$naam$voornaam.zip" "$pad/tempMail.txt"

read -p 'Wenst u het backup bestand terug te plaatsen? [j/n]	' backup

if [[ "$backup" == "j" ]]
	then mv $pad/GPGbackup.tex $pad/GPG.tex
fi


