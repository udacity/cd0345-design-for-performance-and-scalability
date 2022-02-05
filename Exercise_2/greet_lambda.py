"""
This is a lambda function that greets the user.
"""
import os
import logging

logging.getLogger().setLevel(logging.INFO)


def lambda_handler(event, context):
    logging.info("Received event: " + str(event))
    logging.info("Received context: " + str(context))
    return "{} from Lambda!".format(os.environ['greeting'])
