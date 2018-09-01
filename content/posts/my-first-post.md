+++ 
draft = false
date = 2018-08-26T15:19:12-05:00
title = "This is a title"
slug = "this-is-a-title"
tags = []
categories = []
+++

So um... yeah

{{< highlight dockerfile "linenos=table,hl_lines=3-4,linenostart=199" >}}
FROM klakegg/hugo:ext-alpine-onbuild AS hugo

FROM nginx
COPY --from=hugo /onbuild /usr/share/nginx/html
{{< / highlight >}}

```dockerfile
FROM klakegg/hugo:ext-alpine-onbuild AS hugo

FROM nginx
COPY --from=hugo /onbuild /usr/share/nginx/html
```

{{< highlight toml >}}
baseurl = "https://example.com"
languageCode = "en"
title = "Hemingway"
theme = "hemingway"
copyright = "&copy; <a href=\"https://github.com/tanksuzuki\">Asuka Suzuki</a> 2016"
disqusShortname = "shortname"
googleAnalytics = ""

[params]

[params.highlight]
style = "github"
languages = ["go", "dockerfile"]

[[params.social]]
url = "https://github.com/tanksuzuki"
fa_icon = "fa-github"

[[params.social]]
url = "https://twitter.com/tanksuzuki"
fa_icon = "fa-twitter"

[[params.social]]
url = "/index.xml"
fa_icon = "fa-rss"
{{< / highlight >}}
