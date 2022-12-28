# Rouge Highlighter Online

Paste in the browser the code you want to highlight, select the language and get back the code highlighted. No external css needed!

## To start using Rouge Highlighter Online:

* clone the repo
* install dependencies with:
```
bundle install
```

* change the domain in config/application.rb:
```
Rails.application.config.hosts << "domain.name"
```

* start the app:
```
bin/rails server -b domain.name
```