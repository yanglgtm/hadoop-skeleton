#!/usr/bin/env python
# encoding:utf-8

import sys
import hashlib

i = 0
for line in sys.stdin:
    print hashlib.md5(line).hexdigest()
