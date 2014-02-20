class GooglePlusService
  constructor: () ->

  addButton: (id, callbackName, callback) ->
    window.renderGButton = () => @render id
    called = false
    window[callbackName] = (data) =>
      if !called
        called = true
        @signedIn(data, callback)
      
    `(function() {
        var po = document.createElement('script');
        po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/client:plusone.js?onload=renderGButton';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(po, s);
      })();`

  render: (id) ->
    gapi.signin.render id

  signedIn: (data, callback) ->
    if data['status']['signed_in']
      gapi.client.request {
        method: 'GET'
        path: '/plus/v1/people/me',
        callback: (data) => @lookupCallback data, callback
      }
    else
      console.error 'Error loggin in', data

  lookupCallback: (data, callback) ->
    callback {
      id: data.id,
      name: data.name.givenName,
      pic: data.image.url
    }
