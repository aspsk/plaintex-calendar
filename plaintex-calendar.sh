#! /bin/bash

year=${1:-`date +%Y`}

echo "Creating a calendar for the year $year" >&2

month() {

	local month="$1"
	local year="$2"

	echo "\\setbox$month="'\vbox{\halign{\hfil # &\hfil # &\hfil # &\hfil # &\hfil # &\hfil # &\hfil #\cr'

	ncal -Mhb $month $year |    # gimme calendar for this month
	sed 1d |                    # remove the first line (month name)
	sed -e 's/ \+$//' |         # remove trailing spaces
	sed '/^$/d' |               # don't need empty lines
	sed -e 's/\(..\) /\1\&/g' | # insert TeX table delimiters
	awk '{if (NR == 1) { print $0"\\cr\\noalign{\\vskip4pt\\hrule\\vskip4pt}"} else {print $0"\\cr"}}' # add delimiters and line breaks

	echo "}}"

}

echo '\hsize 8.5in
\vsize 11in
\pdfpagewidth 8.5in
\pdfpageheight 11in
'

for month in `seq 1 12`; do month $month $year; done

echo '
\nopagenumbers

\hbox to 6.5in{\hfil\font\foo=cmr10 scaled 2000\foo '"$year"'\hfil}
\vskip 1in

\hbox to 6.5in {
\vtop{\hbox to\wd1{\hfil\bf January\hfil}\vskip6pt\box1}%
\hfil
\vtop{\hbox to\wd2{\hfil\bf February\hfil}\vskip6pt\box2}%
\hfil
\vtop{\hbox to\wd3{\hfil\bf March\hfil}\vskip6pt\box3}%
}
\vskip .5in
\hbox to 6.5in {
\vtop{\hbox to\wd4{\hfil\bf April\hfil}\vskip6pt\box4}%
\hfil
\vtop{\hbox to\wd5{\hfil\bf May\hfil}\vskip6pt\box5}%
\hfil
\vtop{\hbox to\wd6{\hfil\bf June\hfil}\vskip6pt\box6}%
}
\vskip .5in
\hbox to 6.5in {
\vtop{\hbox to\wd7{\hfil\bf July\hfil}\vskip6pt\box7}%
\hfil
\vtop{\hbox to\wd8{\hfil\bf August\hfil}\vskip6pt\box8}%
\hfil
\vtop{\hbox to\wd9{\hfil\bf September\hfil}\vskip6pt\box9}%
}
\vskip .5in
\hbox to 6.5in {
\vtop{\hbox to\wd10{\hfil\bf October\hfil}\vskip6pt\box10}%
\hfil
\vtop{\hbox to\wd11{\hfil\bf November\hfil}\vskip6pt\box11}%
\hfil
\vtop{\hbox to\wd12{\hfil\bf December\hfil}\vskip6pt\box12}%
}

\bye
'
