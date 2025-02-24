.PHONY: dist
dist: clean
	mkdir -p dist dist/images dist/notes
	cp -r images/* dist/images/
	jinja index.html.j2 -o dist/index.html
	jinja notes.html.j2 -o dist/notes/index.html

.PHONY: dist
serve: dist
	python3 -m http.server 8080 --directory dist

.PHONY: clean
clean:
	rm -rf dist

.PHONY: venv
venv:
	python3 -m venv venv

.PHONY: requirements
requirements:
	pip3 install -r requirements.txt
