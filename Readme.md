# Create calendars in plain TeX

I wanted to print a calendar, but couldn't google anything useful.
So I wrote a script to generate a calendar for a particular year
in plain TeX.  Weeks in generated calendars start with Mondays.
The paper is of letter size (8.5in x 11in).

You can use it as follows:
```
plaintex-calendar.sh 2021 > 2021.tex
pdftex 2021
```
