.PHONY: all build serve clean

all: build

build:
	bundle exec jekyll build

serve:
	bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload

clean:
	bundle exec jekyll clean
