.PHONY: dist
dist: clean
	mkdir -p dist dist/images dist/notes
	cp -r images/* dist/images/
	jinja index.html.j2 -o dist/index.html
	jinja notes.html.j2 -o dist/notes/index.html
	jinja redirect.html.j2 -o dist/redirect.html -D url https://google.com
	python3 -c "import yaml; \
		data = yaml.safe_load(open('data/notes-links.yaml')); \
		[print(f'mkdir -p dist/notes/{slug}') for slug, url in data.items()]; \
		[print(f'jinja redirect.html.j2 -o dist/notes/{slug}/index.html -D url {url}') for slug, url in data.items()]" | sh

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
