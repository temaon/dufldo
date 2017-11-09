class @ScriptsLoader

  constructor: () ->
    @script_loader

  script_loader: (url) =>
    if Array.isArray(url)
      prom = []
      url.forEach (item) =>
        prom.push @script_loader(item)
        return
      return Promise.all(prom)
    new Promise((resolve, reject) =>
      r = false
      t = document.getElementsByTagName('script')[0]
      s = document.createElement('script')
      s.type = 'text/javascript'
      unless (url.params == undefined)
        params = $.param(url.params)
        url = "#{url.url}?#{params}"
      s.src = url
      s.async = true
      s.onload =
        s.onreadystatechange = ->
          if !r and (!@readyState or @readyState == 'complete')
            r = true
            resolve this
          return
      s.onerror = s.onabort = reject
      t.parentNode.insertBefore s, t
      return
    )