#!/bin/sh
#assemble and preprocess all the sources files
echo " Starting convertion of chapters to .html format "

pandoc text/pre.txt --lua-filter=epigraph.lua --to markdown | pandoc --top-level-division=chapter --to html > html/pre.html

pandoc text/intro.txt --lua-filter=epigraph.lua --to markdown | pandoc --top-level-division=chapter --to html > html/intro.html

for filename in text/ch*.txt; do
   [ -e "$filename" ] || continue
   pandoc --lua-filter=extras.lua "$filename" --to markdown | pandoc --lua-filter=extras.lua --to markdown | pandoc --lua-filter=epigraph.lua --to markdown | pandoc --lua-filter=additionfilter.lua --to markdown | pandoc --lua-filter=note.lua --to markdown | pandoc --lua-filter=filtro.lua --to markdown |  pandoc --lua-filter=figure.lua --to markdown | pandoc --lua-filter=footnote.lua --to markdown | pandoc --filter pandoc-fignos --to markdown | pandoc --metadata-file=meta.yml --top-level-division=chapter --citeproc --bibliography=bibliography/"$(basename "$filename" .txt).bib" --reference-location=section --wrap=none --to html > html/"$(basename "$filename" .txt).html"
done

echo " Done converting chapters "

pandoc text/web.txt --lua-filter=epigraph.lua --to markdown | pandoc --top-level-division=chapter --to html > html/web.html
pandoc text/bio.txt --top-level-division=chapter --to html > html/bio.html

for filename in text/apx*.txt; do
   [ -e "$filename" ] || continue
   pandoc --lua-filter=extras.lua "$filename" --to markdown | pandoc --lua-filter=extras.lua --to markdown | pandoc --lua-filter=epigraph.lua --to markdown | pandoc --lua-filter=additionfilter.lua --to markdown | pandoc --lua-filter=figure.lua --to markdown | pandoc --filter pandoc-fignos --to markdown | pandoc --metadata-file=meta.yml --top-level-division=chapter --citeproc --bibliography=bibliography/"$(basename "$filename" .txt).bib" --reference-location=section --to html > html/"$(basename "$filename" .txt).html"
done

echo " Converting to html... "

pandoc -s  html/*.html -o book.html --metadata title="Ο Προγραμματισμός της Διάδρασης"  

pandoc -N --quiet -s book.html -f html -t html -s -o book.html --metadata title="Ο Προγραμματισμός της Διάδρασης"

echo " Done converting to html."
