all:
	mkdocs build -d /tmp/clojerl.github.io

serve:
	mkdocs serve

material:
	pip install mkdocs-material
