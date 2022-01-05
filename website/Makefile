docs      = $(wildcard *.rst)
docs_html = $(patsubst %.rst,%.html,$(docs))

all: $(docs_html)

$(docs_html): %.html : %.rst
	pandoc -s --toc --ascii -c default.css -A footer.html $< -o $*.html
	cp -vf $*.html ../docs/
