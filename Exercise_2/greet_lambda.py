import os

def lambda_handler(event, context):
    return "{HELLO} from Lambda!".format(os.environ['greeting'])
