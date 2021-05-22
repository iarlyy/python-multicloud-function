import function

app = function.ServerlessApp()

def handler(event, context):
    msg = event['msg']
    return app.process(msg)
