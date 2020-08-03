#!/usr/bin/python3

import twint

c = twint.Config()

### Basic Configuration ###

c.Search = "Covid-19"
c.Store_json = True
c.Geo = "20.71502,-101.68945,500km"
c.User_full = True
c.Output = "tweets.json"
c.Since = "2020-01-01 00:00:00"
c.Hide_output = True

c.Elasticsearch = "localhost:9200"


twint.run.Search(c)
