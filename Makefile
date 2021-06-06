all:
	mkdocs build -d /tmp/clojerl.github.io

serve:
	mkdocs serve

material:
	pip install mkdocs-material

deploy:
	git checkout master
	cp -r /tmp/clojerl.github.io/* .
	git add .
