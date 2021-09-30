build:
	jupyter-book build src/
publish:
	ghp-import -n -p -f src/_build/html
show: build
	(cd src/_build/html/ && firefox index.html &)
clean:
	jupyter-book clean src/
