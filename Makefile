build:
	jupyter-book build src/
publish:
	ghp-import -n -p -f src/_build/html
show: build
	(cd src/_build/html/ && open index.html &)
latex:
	jupyter-book build src/ --builder pdflatex
clean:
	jupyter-book clean src/
