#!/usr/bin/python

import base64
import hmac
import sys

from hashlib import sha256 as sha256


def run():
   h = hmac.new(sys.argv[1], digestmod=sha256)
   rdata = readContent(sys.argv[2])
   h.update(rdata)
   print base64.b64encode(h.digest())
   return 0


def readInput():
    txt = ""
    for line in sys.stdin:
        txt += line
    return txt

def readContent(filename):
    txt = ""
    f = open(filename, 'r')
    for line in f:
        txt += line
    f.close()
    return txt
   
if __name__ == '__main__':
  run()
  


