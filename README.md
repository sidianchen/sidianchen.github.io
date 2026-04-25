Personal research website built with Jekyll and adapted from the
[uwsampa/research-group-web](https://github.com/uwsampa/research-group-web)
template.

## Local Preview

Install Ruby, then run:

```powershell
gem install bundler
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
```

On Windows, you can also run:

```powershell
.\serve.ps1
```

Then open <http://127.0.0.1:4000>.

This Gemfile uses the current GitHub Pages Jekyll version, `jekyll 3.10.0`,
plus the feed plugin and WEBrick for local serving.
