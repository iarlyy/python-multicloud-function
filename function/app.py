import json
import datetime


class ServerlessApp:
    def __init__(self):
        self.multicloud = True

    def process(self, message):
        #
        # logic goes here
        #
        return json.dumps(
            {
                'now': datetime.datetime.now().isoformat(),
                'message': message
            }
        )
