import function

app = function.ServerlessApp()

def handler(event):
    msg = event.get_json(silent=True)['msg']
    return app.process(msg)
