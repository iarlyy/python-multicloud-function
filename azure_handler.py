import function

import azure.functions as func

app = function.ServerlessApp()


def handler(event: func.HttpRequest) -> func.HttpResponse:
    msg = event.get_json(silent=True)['msg']
    return func.HttpResponse(
        app.process(msg),
        status_code=200
    )
