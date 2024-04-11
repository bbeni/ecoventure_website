'''https://github.com/josue-rojas/csv-yaml/blob/master/convert3.py'''
'''import yaml
import os
import csv
import codecs
from urllib.request import urlopen
import getopt
import sys



def csvToYaml(csvFile, output):
    stream = open(output, 'w',encoding="utf-8")
    csvOpen = csv.reader(codecs.iterdecode(csvFile, 'utf-8'))
    keys = next(csvOpen)
    for row in csvOpen:
        yaml.dump([dict(zip(keys, row))], stream, default_flow_style=False, allow_unicode=True)


if __name__ in ("__main__", "csvyml"):
    main()'''

import csv
import sys
import yaml

def split(string, delim=",", escapes=['"', "'"]):
    words = []
    ignore = False
    escaper = ""
    last = 0
    for i in range(len(string)):
        c = string[i]

        if c in escapes and escaper == "":
            escaper = c
            continue

        if c in escapes and escaper == c:
            escaper = ""
            continue

        if c == delim and escaper == "":
            words.append(string[last:i])
            last = i+1

    return words

def CSV2YML(pathCSV, pathYML, consume=True):

    with open(pathCSV, encoding='utf-8') as f:
        csvContent = f.read()

    lines = csvContent.split("\n")
    titles = split(lines[0])
    title = pathCSV.split(".")[0].split("/")[-1]
    if consume:
        titles = list(map(lambda x: x.strip("'").strip('"').strip("'"), titles))

    out = { title: [] }

    for line in lines[1:]:
        line = line.strip()
        if line == "":
            continue
        values = split(line)
        assert(len(values) == len(titles))
        if consume:
            values = list(map(lambda x: x.strip("'").strip('"').strip("'"), values))
        out[title].append(dict(zip(titles, values)))

    with open(pathYML, "w", encoding='utf-8') as file:
        yaml.dump(out, file)


assert(len(sys.argv) == 3)
inf = sys.argv[1]
outf = sys.argv[2]
CSV2YML(inf, outf)