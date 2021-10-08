import datetime

def timestamp():
    return datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

def parse_timestamp(t):
    return datetime.datetime.strptime(t, '%Y-%m-%d %H:%M:%S')
