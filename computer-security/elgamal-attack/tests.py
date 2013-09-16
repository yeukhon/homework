#!/usr/bin/python

from subprocess import Popen, PIPE

bad = 0

for i in xrange(1000):
    cmd = ['python', 'adversary.py']
    p = Popen(cmd, stdout=PIPE, stdin=PIPE, stderr=PIPE)
    pin, pout = p.communicate()
    if pout != 'right answer!\n':
        bad += 1
    print 'bad count', bad

print bad
