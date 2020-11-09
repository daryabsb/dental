from datetime import datetime, timedelta


# DATE FILTER GENERATOR
def get_date_range(date_query):
    
    aday = timedelta(days=1)
    week = timedelta(weeks=1)
    month = timedelta(days=30)
    today = datetime.now()

    return {
        'today': lambda: today,
        'tomorrow': lambda: today + aday,
        'week': lambda: today + week,
        'month': lambda: today + month
    }.get(date_query, lambda: None)()

def datefilter(a, c):

    def myfilter(x):
        return a < x < c
    return myfilter