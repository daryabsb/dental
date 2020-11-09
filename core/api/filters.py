from datetime import datetime, timedelta, date


# DATE FILTER GENERATOR
def get_date_range(date_query):
    
    aday = timedelta(days=2)
    week = timedelta(weeks=1)
    month = timedelta(days=30)
    today = date.today()
    tomorrow = today + aday
    now = datetime.now()

    # print(aday)

    return {
        'today': lambda: now,
        'tomorrow': lambda: tomorrow,
        'week': lambda: today + week,
        'month': lambda: today + month
    }.get(date_query, lambda: None)()

def datefilter(a, c):

    def myfilter(x):
        return a < x < c
    return myfilter