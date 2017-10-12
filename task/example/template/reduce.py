#!/usr/bin/env python
# encoding:utf-8

import sys

t = ""
i = 0
j = 1

for line in sys.stdin:
    i = i + 1
    if line != t:
        j = j + 1
        t = line

# sys.stdout.write(str(i))
# sys.stdout.write(str(j))

print i
print j
