#!/bin/bash

output_format='mobi'

function scrape {
	echo "scraping" $1 "to" ${2}
	ruby serial_scrape.rb -s $1 > ${1}.html
	ebook-convert ${1}.html ${1}.${2} --authors "John McCrae" --title "${1}" --max-toc-links 500
	rm ${1}.html
}

while getopts ":aehmptw" opt; do
	case $opt in
		w) projects="worm"
		;;
		t) projects="twig"
		;;
		p) projects="pact"
		;;
		a) projects="worm pact twig"
		;;
		e) output_format='epub'
		;;
 		m) output_format='mobi'
		;;
		h) echo "options are: -a for all, -h for help, -p for pact, -t for twig, -w for worm, -e for epub, -m for mobi" 
		;;
	esac
done

for project in ${projects}; do
	scrape ${project} ${output_format} 
done
