import function

import azure.functions as func

app = function.ServerlessApp()


def handler(req: func.HttpRequest) -> func.HttpResponse:
    msg = req.get_json()['msg']
    return func.HttpResponse(
        app.process(msg),
        status_code=200
    )
